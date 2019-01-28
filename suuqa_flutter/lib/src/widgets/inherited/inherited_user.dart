import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';

class InheritedUser extends StatefulWidget {
  final Widget child;
  final bool isLoggedIn;
  final User user;

  InheritedUser({this.child, this.isLoggedIn, this.user});

  @override
  _InheritedUserState createState() => _InheritedUserState();

  static _InheritedUserState of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_UserState) as _UserState).data;
}

class _InheritedUserState extends State<InheritedUser> {
  Widget _child;
  bool _isLoggedIn;
  User _user;

  @override
  void initState() {
    super.initState();

    this.child = widget.child;
    this.isLoggedIn = widget.isLoggedIn;
    if (this.isLoggedIn) this.user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return _UserState(data: this, child: widget.child);
  }

  // MARK - Functions

  Widget get child => this._child;
  bool get isLoggedIn => this._isLoggedIn;
  User get user => this._user;

  set child(Widget value) {
    setState(() {
      this._child = value;
    });
  }

  set isLoggedIn(bool value) {
    setState(() {
      this._isLoggedIn = value;
    });
  }

  set user(User value) {
    setState(() {
      this._user = value;
    });
  }
}

class _UserState extends InheritedWidget {
  final _InheritedUserState data;

  _UserState({Key key, @required this.data, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
