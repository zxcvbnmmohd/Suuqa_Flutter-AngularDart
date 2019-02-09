import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/lists/item/chats/chat_item.dart';

class ChatsList extends StatelessWidget {
  final List<Chat> chats;

  ChatsList({this.chats});

  @override
  Widget build(BuildContext context) {
    return this.chats == null
        ? Center(child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator())
        : ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Chat c = this.chats[index];
              return ChatItem(chat: c);
            },
            itemCount: this.chats.length,
          );
  }
}