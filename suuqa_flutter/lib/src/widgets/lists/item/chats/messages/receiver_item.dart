import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';

class ReceiverItem extends StatelessWidget {
  final Message message;

  ReceiverItem({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 50.0, bottom: 5.0, right: 5.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50.0),
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Config.pathGradient),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Functions.readDateTime(date: this.message.createdAt),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.0),
              Expanded(
                  child: this.message.type == 'Text'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                              this.message.message,
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      : Container(
                          height: 250.0,
                          decoration: BoxDecoration(
                            color: Config.wColor,
                            image: DecorationImage(
                              image: NetworkImage(this.message.message),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: Config.borderRadius,
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
