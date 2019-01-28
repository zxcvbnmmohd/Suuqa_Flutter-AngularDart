import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';

class Filter extends StatefulWidget {
  final List<Address> addresses;
  final int addressIndex, sortBy;
  final double radius, priceMin, priceMax;
  final Function(int, double, double, double, int) onTap;

  Filter({this.addresses, this.addressIndex, this.radius, this.priceMin, this.priceMax, this.sortBy, this.onTap});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  TextEditingController _addressTEC, _priceMinTEC, _priceMaxTEC;
  List<Address> _addresses;
  int _addressIndex, _sortBy;
  double _radius, _priceMin, _priceMax;

  @override
  void initState() {
    super.initState();
    this._initVariables(
      addresses: widget.addresses,
      addressIndex: widget.addressIndex,
      sortBy: widget.sortBy,
      radius: widget.radius,
      priceMin: widget.priceMin,
      priceMax: widget.priceMax,
    );
    this._addressTEC = TextEditingController(text: this._addresses[_addressIndex].type);
    this._priceMinTEC = TextEditingController(text: this._priceMin.toString());
    this._priceMaxTEC = TextEditingController(text: this._priceMax.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.only(top: 125.0),
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            GestureDetector(onTap: () {
              Navigator.pop(context);
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: Config.borderRadius,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 5.0,
                        blurRadius: 20.0,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: TextField(
                          controller: this._addressTEC,
                          decoration: InputDecoration(labelText: 'Address'),
                          onTap: () {},
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                              controller: this._priceMinTEC,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(labelText: 'Price Min'),
                            )),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: TextFormField(
                              controller: this._priceMaxTEC,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(labelText: 'Price Max'),
                            )),
                          ],
                        ),
                      ),
                      Container(
                        child: Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Radius'),
                                  Text(this._radius.toString() + ' km'),
                                ],
                              ),
                              Platform.isIOS
                                  ? CupertinoSlider(
                                      value: this._radius,
                                      min: 0.0,
                                      max: 50.0,
                                      onChanged: (r) {
                                        setState(() {
                                          this._radius = r.floor().floorToDouble();
                                        });
                                      },
                                      activeColor: Colors.amberAccent,
                                    )
                                  : Slider(
                                      value: this._radius,
                                      min: 0.0,
                                      max: 50.0,
                                      onChanged: (r) {
                                        setState(() {
                                          this._radius = r.floor().floorToDouble();
                                        });
                                      },
                                      activeColor: Colors.amberAccent,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this._sortBy = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 43.0,
                                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: Config.borderRadius,
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.amber,
                                      ),
                                      color: this._sortBy == 0 ? Colors.amber : Colors.white,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Oldest',
                                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this._sortBy = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 43.0,
                                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: Config.borderRadius,
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.amber,
                                      ),
                                      color: this._sortBy == 1 ? Colors.amber : Colors.white,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'Newest',
                                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this._sortBy = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 43.0,
                                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: Config.borderRadius,
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.amber,
                                      ),
                                      color: this._sortBy == 2 ? Colors.amber : Colors.white,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '\$',
                                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this._sortBy = 3;
                                    });
                                  },
                                  child: Container(
                                    height: 43.0,
                                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: Config.borderRadius,
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.amber,
                                      ),
                                      color: this._sortBy == 3 ? Colors.amber : Colors.white,
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          '\$\$\$',
                                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5.0,
                          blurRadius: 20.0,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Button(
                        outline: false,
                        text: 'Filter Products',
                        color: Colors.amberAccent,
                        onTap: () {
                          widget.onTap(this._addressIndex, this._radius, double.parse(this._priceMinTEC.text),
                              double.parse(this._priceMaxTEC.text), this._sortBy);
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - Functions

  _initVariables({List<Address> addresses, int addressIndex, double radius, double priceMin, double priceMax, int sortBy}) {
    setState(() {
      this._addresses = addresses;
      this._addressIndex = addressIndex;
      this._radius = radius;
      this._priceMin = priceMin;
      this._priceMax = priceMax;
      this._sortBy = sortBy;
    });
  }
}
