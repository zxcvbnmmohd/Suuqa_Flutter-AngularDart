import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';

class PATabBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final Color backgroundColor;
  final List<Widget> views;

  PATabBar({this.items, this.backgroundColor, this.views});

  @override
  _PATabBarState createState() => _PATabBarState();
}

class _PATabBarState extends State<PATabBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: widget.items,
              onTap: this._onPageChanged,
              currentIndex: this._currentIndex,
              backgroundColor: widget.backgroundColor,
              border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
              activeColor: Config.pColor,
              inactiveColor: Config.wColor,
            ),
            tabBuilder: (context, index) {
              return widget.views[index];
            },
            backgroundColor: widget.backgroundColor,
          )
        : Scaffold(
            body: widget.views[this._currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: widget.items,
              onTap: this._onPageChanged,
              currentIndex: this._currentIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: Config.sColor,
            ),
            backgroundColor: widget.backgroundColor,
          );
  }

  // MARK - Functions

  _onPageChanged(int i) => setState(() => this._currentIndex = i);
}
