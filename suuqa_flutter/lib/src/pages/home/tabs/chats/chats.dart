import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/pages/home/tabs/chats/sections/all.dart';
import 'package:suuqa/src/pages/home/tabs/chats/sections/buying.dart';
import 'package:suuqa/src/pages/home/tabs/chats/sections/selling.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Chats extends StatefulWidget {
  final User cUser;

  Chats({this.cUser});

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<Chat> _allChats = [];
  List<Chat> _buyingChats = [];
  List<Chat> _sellingChats = [];

  @override
  void initState() {
    super.initState();
    this._initChats(
        userID: widget.cUser.userID,
        allChats: this._allChats,
        buyingChats: this._buyingChats,
        sellingChats: this._sellingChats);
  }

  @override
  Widget build(BuildContext context) {
    Widget w = DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Config.bgColor,
        appBar: TabBar(
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Buying'),
            Tab(text: 'Selling'),
          ],
          indicatorColor: Config.pColor,
          labelColor: Config.tColor,
        ),
        body: TabBarView(
          children: [
            All(chats: this._allChats),
            Buying(chats: this._buyingChats),
            Selling(chats: this._sellingChats),
          ],
        ),
      ),
    );

    return PAScaffold(
        iOSLargeTitle: false,
        color: Config.bgColor,
        title: 'Chats',
        leading: Platform.isIOS ? Container() : null,
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Chats',
        androidView: w,
        iOSView: w);
  }

  // MARK - Functions

  _initChats({String userID, List<Chat> allChats, List<Chat> buyingChats, List<Chat> sellingChats}) {
    APIs().chats.observeChats(
        userID: userID,
        onAdded: (c) {
          setState(() {
            allChats.add(c);
            allChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));

            if (userID == c.users.first.documentID) {
              sellingChats.add(c);
              sellingChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
            } else {
              buyingChats.add(c);
              buyingChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
            }
          });
        },
        onModified: (c) {
          int ai = allChats.indexWhere((chat) => c.chatID == chat.chatID);
          int bi = buyingChats.indexWhere((chat) => c.chatID == chat.chatID);
          int si = sellingChats.indexWhere((chat) => c.chatID == chat.chatID);

          setState(() {
            allChats[ai] = c;
            allChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));

            if (userID == c.users.first.documentID) {
              sellingChats[si] = c;
              sellingChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
            } else {
              buyingChats[bi] = c;
              buyingChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
            }
          });
        },
        onRemoved: (c) {
          int ai = allChats.indexWhere((chat) => c.chatID == chat.chatID);
          int bi = buyingChats.indexWhere((chat) => c.chatID == chat.chatID);
          int si = sellingChats.indexWhere((chat) => c.chatID == chat.chatID);

          setState(() {
            allChats.removeAt(ai);
            allChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));

            if (userID == c.users.first.documentID) {
              sellingChats.removeAt(si);
              sellingChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
            } else {
              buyingChats.removeAt(bi);
              buyingChats.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
            }
          });
        },
        onFailure: (e) {
          print(e);
        });
  }
}
