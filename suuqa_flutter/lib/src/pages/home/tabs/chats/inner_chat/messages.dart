import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/lists/list/messages_list.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Messages extends StatefulWidget {
  final Product product;
  final User cUser;

  Messages({this.product, this.cUser});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController _messageTEC = TextEditingController();
  FocusNode _messageFN = FocusNode();
  ScrollController _scrollController = ScrollController();

  Chat _chat;
  List<Message> _messages = [];
  bool _isLoading = true, _chatExists = false;
  File _image;
  String _imageURL;

  @override
  void initState() {
    super.initState();

    this._initChat(p: widget.product, u: widget.cUser, c: this._chat, messages: this._messages);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget w = Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: MessagesList(
              messages: this._messages,
              scrollController: this._scrollController,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? size.height >= 812.0 ? 15.0 : 0.0 : 0.0),
            color: Colors.black12,
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: Config.borderRadius),
                    margin: EdgeInsets.only(left: 10.0, top: 6.0, bottom: 5.0),
                    child: Container(
                      child: TextView(
                        controller: this._messageTEC,
                        focusNode: this._messageFN,
                        hintText: 'Is it still available?',
                        hintStyle: TextStyle(
                          color: Config.tColor.withOpacity(0.5),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
                        textCapitalization: TextCapitalization.sentences,
                        color: Config.tColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        onSubmitted: (s) {
                          if (s.length != 0) {
                            String messageID = APIs()
                                .chats
                                .chatsCollection
                                .document(this._chat.chatID)
                                .collection('messages')
                                .document()
                                .documentID;
                            this._sendMessage(
                                userID: widget.cUser.userID,
                                chatID: this._chat.chatID,
                                messageID: messageID,
                                type: 'Text',
                                scrollController: this._scrollController);
                          }
                        },
                        keyboardAppearance: Brightness.light,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  color: Config.sColor,
                  onPressed: () {
                    Functions.addPhoto(
                        context: context,
                        onSuccess: (image) {
                          String messageID = APIs()
                              .chats
                              .chatsCollection
                              .document(this._chat.chatID)
                              .collection('messages')
                              .document()
                              .documentID;
                          Services().storage.upload(
                              path: 'users/${widget.cUser.userID}/chats/${this._chat.chatID}/messages/$messageID/image.png',
                              file: image,
                              onSuccess: (url) {
                                this._sendMessage(
                                    type: 'Image', message: url, userID: widget.cUser.userID, messageID: messageID);
                              },
                              onFailure: (e) {
                                print(e);
                              });
                        });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );

    return PAScaffold(
        iOSLargeTitle: false,
        color: Config.bgColor,
        title: 'Messages',
        leading: IconButton(
            icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            color: Config.tColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Messages',
        androidView: w,
        iOSView: w);
  }

  // MARK - Functions

  _createChat({String productID, String fromUserID, String toUserID}) {
    Map<String, dynamic> m = {
      'product': APIs().products.productsSellingCollection.document(productID),
      'users': [APIs().users.usersCollection.document(fromUserID), APIs().users.usersCollection.document(toUserID)],
      'imageURL': widget.product.images.first,
      'type': '',
      'message': '',
      'isTyping': false,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now()
    };
    Services().crud.create(
        ref: APIs().chats.chatsCollection.document(),
        map: m,
        onSuccess: () {
          setState(() {
            this._chatExists = !this._chatExists;
          });
        },
        onFailure: (e) {
          print(e);
        });
  }

  _initChat({Product p, User u, Chat c, List<Message> messages}) {
    APIs().chats.observeChat(
          productID: p.productID,
          userID: u.userID,
          onAdded: (c) {
            print('CHAT ADDED');
            setState(() {
              c = c;
              this._initMessages(chatID: c.chatID, messages: messages);
            });
          },
          onModified: (c) {
            print('CHAT MODIFEID');
            setState(() {
              c = c;
            });
          },
          onRemoved: (c) {
            print('CHAT REMOVED');
            setState(() {
              c = null;
            });
          },
          onEmpty: () {
            print('CHAT CREATED');
            this._createChat(productID: p.productID, fromUserID: u.userID, toUserID: p.user.documentID);
          },
          onFailure: (e) {
            print(e);
          },
        );
  }

  _initMessages({String chatID, List<Message> messages}) {
    APIs().chats.observeMessages(
        chatID: chatID,
        onAdded: (m) {
          setState(() {
            messages.add(m);
            messages.sort((b, a) => a.createdAt.compareTo(b.createdAt));
          });
        },
        onModified: (m) {
          int i = messages.indexWhere((message) => m.messageID == message.messageID);
          setState(() {
            messages[i] = m;
            messages.sort((b, a) => a.createdAt.compareTo(b.createdAt));
          });
        },
        onRemoved: (m) {
          int i = messages.indexWhere((message) => m.createdAt == message.createdAt);
          setState(() {
            messages.removeAt(i);
            messages.sort((b, a) => a.createdAt.compareTo(b.createdAt));
          });
        },
        onFailure: (e) {
          print(e);
        });
  }

  _sendMessage(
      {String userID, String chatID, String messageID, String message, String type, ScrollController scrollController}) {
    Map<String, dynamic> c = {'type': type, 'message': message, 'createdAt': DateTime.now(), 'updatedAt': DateTime.now()};
    Map<String, dynamic> m = {
      'user': APIs().users.usersCollection.document(userID),
      'isRead': false,
      'type': type,
      'message': message,
      'createdAt': DateTime.now()
    };

    Services().crud.create(
        ref: APIs().chats.chatsCollection.document(chatID).collection('messages').document(messageID),
        map: m,
        onSuccess: () {
          print('MESSAGE SENT');
          Services().crud.update(
              ref: APIs().chats.chatsCollection.document(chatID),
              map: c,
              onSuccess: () {
                print('CHAT UPDATED');
                scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
              },
              onFailure: (e) {
                print(e);
              });
        },
        onFailure: (e) {
          print('NOT SENT');
          print(e);
        });
  }
}
