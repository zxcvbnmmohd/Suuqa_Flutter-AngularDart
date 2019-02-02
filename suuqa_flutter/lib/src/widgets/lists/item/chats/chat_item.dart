import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/chats/chat.dart';

class ChatItem extends StatelessWidget {
  final S.Chat chat;
  final S.User pUser;

  ChatItem({this.chat, this.pUser});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    this.chat.isTyping ? 'Typing...' : this.chat.type == 'Text' ? this.chat.message : this.chat.type,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    Functions.readDateTime(date: this.chat.updatedAt),
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
                image: DecorationImage(image: NetworkImage(this.chat.imageURL), fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Functions.navigateTo(
            context: context,
            w: Chat(
              chat: this.chat,
            ),
            fullscreenDialog: true);
      },
    );
  }
}
