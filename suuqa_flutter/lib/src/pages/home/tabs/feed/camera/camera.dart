import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/feed/camera/details.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;

  Camera({this.cameras});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription> _cameras;
  CameraController _controller;
  bool _didCapture = false;
  File _image;

  @override
  void initState() {
    super.initState();
    this._cameras = widget.cameras;
    if (this._cameras.isNotEmpty) {
      this._controller = new CameraController(this._cameras.first, ResolutionPreset.high);
      this._controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (this._cameras.isNotEmpty) this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = InheritedUser.of(context).user;
    Widget appBar;

    Platform.isIOS
        ? this._didCapture
            ? appBar = CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
                automaticallyImplyLeading: false,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                trailing: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        this._didCapture = false;
                      });
                    }),
              )
            : appBar = CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                automaticallyImplyLeading: false,
              )
        : this._didCapture
            ? appBar = AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          this._didCapture = false;
                        });
                      }),
                ],
              )
            : appBar = AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              );

    return Material(
      color: Colors.black,
      child: AspectRatio(
        aspectRatio: this._cameras.isNotEmpty ? this._controller.value.aspectRatio : MediaQuery.of(context).devicePixelRatio,
        child: Stack(
          children: <Widget>[
            Container(
              child: this._didCapture
                  ? Image.file(
                      this._image,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                    )
                  : widget.cameras.isNotEmpty
                      ? this._controller.value.isInitialized
                          ? CameraPreview(this._controller)
                          : Container(
                              child: Center(
                                child: Text('NOT INIT'),
                              ),
                            )
                      : Container(
                          child: Center(
                            child: Text('NO CAMERA'),
                          ),
                        ),
            ),
            appBar,
            Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  color: Colors.transparent,
                  height: 175.0,
                  child: Center(
                    child: Table(
                      children: [
                        TableRow(children: [
                          this._didCapture
                              ? Container(color: Colors.transparent)
                              : GestureDetector(
                                  onTap: () {
                                    Functions.fromGallery(onSuccess: (image) {
                                      setState(() {
                                        this._image = image;
                                        this._didCapture = true;
                                      });
                                    });
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Center(
                                      child: Icon(
                                        Icons.photo_library,
                                        size: 40.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                          this._didCapture
                              ? Container(color: Colors.transparent)
                              : GestureDetector(
                                  onTap: () async {
                                    if (this._controller != null && this._controller.value.isInitialized) {
                                      await this._takePicture();
                                    }
                                  },
                                  child: Container(
                                    width: 75.0,
                                    height: 75.0,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                                  ),
                                ),
                          this._didCapture
                              ? GestureDetector(
                                  onTap: () {
                                    Functions.navigateAndReplaceWith(
                                        context: context,
                                        w: Details(
                                          image: this._image,
                                          onRestart: () {},
                                        ));
                                  },
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Center(
                                      child: Icon(
                                        Icons.forward,
                                        size: 40.0,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MARK - Functions

  Future<File> _storePicture() async {
    if (!this._controller.value.isInitialized) {
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/Suuqa';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${DateTime.now().millisecondsSinceEpoch.toString()}.png';

    if (this._controller.value.isTakingPicture) {
      return null;
    }

    try {
      await this._controller.takePicture(filePath);
    } on CameraException catch (e) {
      print('Error: ${e.code}\n${e.description}');
      return null;
    }
    return File(filePath);
  }

  Future _takePicture() async {
    File image = await this._storePicture();

    if (mounted) {
      setState(() {
        this._image = image;
        this._didCapture = true;
      });
    }
  }
}
