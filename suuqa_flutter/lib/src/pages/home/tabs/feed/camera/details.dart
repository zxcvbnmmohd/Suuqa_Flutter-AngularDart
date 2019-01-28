import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/section.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Details extends StatefulWidget {
  final File image;
  final Function onRestart;

  Details({this.image, this.onRestart});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController _titleTEC = TextEditingController();
  TextEditingController _descTEC = TextEditingController();
  MoneyMaskedTextController _priceTEC =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: '\$');
  TextEditingController _categoryTEC = TextEditingController();
  TextEditingController _addressTEC = TextEditingController();
  TextEditingController _sizeTEC = TextEditingController();
  FocusNode _titleFN = FocusNode();
  FocusNode _descFN = FocusNode();
  FocusNode _categoryFN = FocusNode();
  FocusNode _priceFN = FocusNode();
  FocusNode _addressFN = FocusNode();
  FocusNode _sizeFN = FocusNode();

  List<File> _images = [];
  int _categoryIndex = 0;
//  int _addressIndex = 0;
  Address _address;
  bool _forDelivery = false;
  double _feeService = 2.0;
  double _feeDelivery = 0.0;

  @override
  void initState() {
    super.initState();
    this._images.add(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context).user;

    List<Widget> w = [
      Section(text: 'Add Photos'),
      Container(
        height: 75.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this._images.length < 6 ? this._images.length + 1 : this._images.length,
            itemBuilder: (context, index) {
              if (this._images.length == index) {
                return GestureDetector(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(Config.pathUploadPhoto),
                        fit: BoxFit.cover,
                      ))),
                  onTap: () {
                    Functions.addPhoto(
                        context: context,
                        onSuccess: (file) {
                          setState(() {
                            this._images.add(file);
                          });
                        });
                  },
                );
              } else if (index == 5) {
                return GestureDetector(
                  child: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      color: Config.wColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(image: FileImage(this._images[index]), fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      this._images.removeAt(index);
                    });
                  },
                );
              } else {
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 25.0),
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      color: Config.wColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      image: DecorationImage(image: FileImage(this._images[index]), fit: BoxFit.cover),
                    ),
                  ),
                  onTap: () {
                    if (this._images.length != 1) {
                      setState(() {
                        this._images.removeAt(index);
                      });
                    }
                  },
                );
              }
            }),
      ),
      Section(text: 'Details'),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: <Widget>[
            TextView(
              controller: this._titleTEC,
              focusNode: this._titleFN,
              hintText: 'Title',
              hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              color: Config.tColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              autoCorrect: true,
              onSubmitted: (s) {
                FocusScope.of(context).requestFocus(this._descFN);
              },
              keyboardAppearance: Brightness.light,
            ),
            TextView(
              controller: this._descTEC,
              focusNode: this._descFN,
              hintText: 'Description',
              hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.w600),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              color: Config.tColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
              autoCorrect: true,
              maxLines: 5,
              onSubmitted: (s) {},
              keyboardAppearance: Brightness.light,
            ),
            TextView(
              controller: this._categoryTEC,
              focusNode: this._categoryFN,
              hintText: 'Category',
              hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              color: Config.tColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              autoCorrect: true,
              onSubmitted: (s) {
                FocusScope.of(context).requestFocus(this._priceFN);
              },
              keyboardAppearance: Brightness.light,
              onTap: () {
                Platform.isIOS ? CupertinoPicker(

                ) : Container();
              },
            ),
            TextView(
              controller: this._priceTEC,
              focusNode: this._priceFN,
              hintText: 'Price',
              hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              color: Config.tColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              autoCorrect: true,
              onSubmitted: (s) {
                this._getAddress(context: context);
              },
              keyboardAppearance: Brightness.light,
            ),
            TextView(
              controller: this._addressTEC,
              focusNode: this._addressFN,
              hintText: 'Meet Up At',
              hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              color: Config.tColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              autoCorrect: true,
              onSubmitted: (s) {},
              keyboardAppearance: Brightness.light,
              onTap: () {
                this._getAddress(context: context);
              },
            ),
            this._forDelivery
                ? TextView(
                    controller: this._sizeTEC,
                    focusNode: this._sizeFN,
                    hintText: 'Size',
                    hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 20.0, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    textCapitalization: TextCapitalization.words,
                    color: Config.tColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                    autoCorrect: true,
                    onSubmitted: (s) {},
                    keyboardAppearance: Brightness.light,
                  )
                : Container(),
          ],
        ),
      ),
      this._forDelivery
          ? this._sizeTEC.text.length == 0 ? Container() : this._postButton(userID: cUser.userID)
          : this._addressTEC.text.length == 0 ? Container() : this._postButton(userID: cUser.userID),
    ];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
        title: 'Details',
        leading: IconButton(
            icon: Icon(Icons.close),
            color: Config.tColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Details',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }

  // MARK - Functions

  _getAddress({BuildContext context}) {
    Functions.showAutoComplete(onSuccess: (p) {
      setState(() {
        this._addressTEC.text = p.name;
        this._address = new Address(
            type: 'Pick Up Spot',
            short: p.name,
            long: p.address,
            instructions: 'Stay Safe',
            geoPoint: Address().toGeoPoint(p.latitude, p.longitude));
      });
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  Widget _postButton({String userID}) {
    return Container(
        margin: EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0, bottom: 25.0),
        child: Button(
          outline: false,
          text: 'POST',
          color: Config.pColor,
          onTap: () {
            Map<String, dynamic> m = {
              'user': APIs().users.usersCollection.document(userID),
              'type': 'Product',
              'title': this._titleTEC.text,
              'description': this._descTEC.text,
              'category': Config.categories[this._categoryIndex],
              'views': 0,
              'isSelling': true,
              'createdAt': DateTime.now(),
              'updatedAt': DateTime.now(),
            };

            if (this._forDelivery) {
              m['forDelivery'] = this._forDelivery;
              m['address'] = Address().toMap(this._address);
              m['total'] = double.parse(this._priceTEC.text) + this._feeDelivery + this._feeService;
              m['deliveryInfo'] = {
                'size': this._sizeTEC.text,
                'subtotal': double.parse(this._priceTEC.text),
                'deliveryFee': this._feeDelivery,
                'serviceFee': this._feeService
              };
            } else {
              m['forDelivery'] = this._forDelivery;
              m['address'] = Address().toMap(this._address);
              m['total'] = double.parse(this._priceTEC.text.split('\$')[1]);
            }

            this._post(
                images: this._images,
                m: m,
                onSuccess: (productID) {
//                  Map<String, dynamic> m = {productID: 'isSelling'};
//                  Services().crud.update(
//                      ref: APIs().users.usersCollection.document(userID).collection('products').document('statuses'),
//                      m: m,
//                      onSuccess: () {
                  Navigator.pop(context);
//                      },
//                      onFailure: (e) {
//                        print(e);
//                      });
                },
                onFailure: (e) {
                  print(e);
                });
          },
        ));
  }

  _post({List<File> images, Map<String, dynamic> m, Function onSuccess(String s), Function onFailure(String e)}) {
    String productID = APIs().products.productsSellingCollection.document().documentID;

    List<String> imageURLs = [];
    int uploadCount = 0;

    images.forEach((image) {
      Services().storage.upload(
          path: '/products/$productID/${uploadCount++}.png',
          file: image,
          onSuccess: (url) {
            imageURLs.add(url);

            if (uploadCount == images.length) {
              m['images'] = imageURLs;

              Services().crud.create(
                  ref: APIs().products.productsSellingCollection.document(productID),
                  map: m,
                  onSuccess: () {
                    onSuccess(productID);
                  },
                  onFailure: (e) {
                    onFailure(e);
                  });
            }
          },
          onFailure: (e) {});
    });
  }
}
