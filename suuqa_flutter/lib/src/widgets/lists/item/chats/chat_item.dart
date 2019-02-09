import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/chats/chat.dart';

class ChatItem extends StatefulWidget {
  final S.Chat chat;

  ChatItem({this.chat});

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  S.User pUser;

  @override
  void initState() {
    super.initState();
    S.APIs().users.user(userID: widget.chat.product.user.documentID).then((pUser) {
       setState(() {
         this.pUser = pUser;
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.pUser == null ? Container() : GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        color: S.Config.bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(this.pUser.aviURL), fit: BoxFit.cover),
                  ),
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    margin: EdgeInsets.only(top: 40.0, left: 40.0),
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        '5',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    this.pUser.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.chat.isTyping ? 'Typing...' : widget.chat.type == 'Text' ? widget.chat.message : widget.chat.type,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    Functions.readDateTime(date: widget.chat.updatedAt),
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(image: NetworkImage(widget.chat.imageURL), fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Functions.navigateTo(
            context: context,
            w: Chat(
              chat: widget.chat,
            ),
            fullscreenDialog: true);
      },
    );
  }
}
