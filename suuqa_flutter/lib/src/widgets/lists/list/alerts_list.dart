import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/lists/item/alerts/chat_item.dart';
import 'package:suuqa/src/widgets/lists/item/alerts/delivery_item.dart';
import 'package:suuqa/src/widgets/lists/item/alerts/product_item.dart';

class AlertsList extends StatelessWidget {
  final List<Alert> alerts;

  AlertsList({this.alerts});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        this.alerts == null
            ? Center(child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator())
            : ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Alert a = this.alerts[index];

                  switch (a.type) {
                    case 'Chat':
                      return ChatItem(alert: a);
                      break;
                    case 'Delivery':
                      return DeliveryItem(alert: a);
                      break;
                    case 'Product':
                      return ProductItem(alert: a);
                      break;
                  }
                },
                itemCount: this.alerts.length,
              ),
      ],
    );
  }
}
