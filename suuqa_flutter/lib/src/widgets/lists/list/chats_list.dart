import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/lists/item/chats_item.dart';

class ChatsList extends StatelessWidget {
  final List<Chat> chats;

  ChatsList({this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ChatsItem();
      },
      itemCount: this.chats.length,
    );
  }
}
