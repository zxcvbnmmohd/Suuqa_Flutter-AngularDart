import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/lists/item/chats/chat_item.dart';

class ChatsList extends StatelessWidget {
  final List<Chat> chats;

  ChatsList({this.chats});

  @override
  Widget build(BuildContext context) {
    User cUser = InheritedUser.of(context).user;
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Chat c = this.chats[index];
        return ChatItem(chat: c, pUser: cUser);
      },
      itemCount: this.chats.length,
    );
  }
}
