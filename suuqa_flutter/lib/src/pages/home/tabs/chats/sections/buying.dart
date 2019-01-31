import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/lists/list/chats_list.dart';

class Buying extends StatelessWidget {
  final List<Chat> chats;

  Buying({this.chats});

  @override
  Widget build(BuildContext context) {
    return ChatsList(chats: this.chats);
  }
}
