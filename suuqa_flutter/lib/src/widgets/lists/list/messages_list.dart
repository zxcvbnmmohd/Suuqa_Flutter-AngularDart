import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/lists/item/chats/messages/receiver_item.dart';
import 'package:suuqa/src/widgets/lists/item/chats/messages/sender_item.dart';

class MessagesList extends StatelessWidget {
  final List<Message> messages;
  final ScrollController scrollController;

  MessagesList({this.messages, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context).user;

    return ListView.builder(
      reverse: true,
      controller: this.scrollController,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0.0),
      itemBuilder: (context, index) {
        Message message = this.messages[index];
        return message.user.documentID == cUser.userID ? ReceiverItem(message: message) : SenderItem(message: message);
      },
      itemCount: this.messages.length,
    );
  }
}
