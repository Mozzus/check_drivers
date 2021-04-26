import 'dart:io';

import 'package:camera/camera.dart';
import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/screens/scan_screens/scan_car.dart';
import 'package:check_drivers/screens/scan_screens/scan_human.dart';
import 'package:check_drivers/screens/scan_screens/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_face/image_face.dart';

import 'confirm_scan_screen.dart';

class MainScan extends StatefulWidget {
  static File faceFile;
  static bool hasFace = false;
  static Future<void> isReady;

  MainScan({this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  _MainScanState createState() => _MainScanState();
}

class _MainScanState extends State with WidgetsBindingObserver {
  List<CameraDescription> _cameras;
  CameraController _controller;
  CameraDescription _activeCamera;
  int _selected = 0;
  XFile photoFile;
  File checkFaceFile;
  bool _isTapped = false;
  bool _isHuman = true;
  bool _isCar = false;
  bool _isQr = false;

  @override
  void initState() {
    super.initState();
    setupCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _setTapped() {
    setState(() {
      _isTapped = !_isTapped;
    });
  }

  Widget _cameraView() {
    if (_controller == null || !_controller.value.isInitialized) {
      return _activeCamera == null ? Placeholder() : Container();
    }
    var camera = _controller.value;
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;

    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(
          _controller,
        ),
      ),
    );
  }

  Future<void> _takePhoto(BuildContext context) async {
    if (!_controller.value.isInitialized) {
      return null;
    }

    if (_controller.value.isTakingPicture) {
      return null;
    }

    try {
      photoFile = await _controller.takePicture();
      setState(() {
        _modifyPhoto(context);
      });
    } on CameraException catch (e) {
      print(e);
    }
  }

  Future<void> setupCamera() async {
    _cameras = await availableCameras();
    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  selectCamera() async {
    var controller =
        CameraController(_cameras[_selected], ResolutionPreset.medium);
    await controller.initialize();
    return controller;
  }

  void _modifyPhoto(context) async {
    checkFaceFile =
        await FlutterNativeImage.cropImage(photoFile.path, 300, 130, 230, 180);
    MainScan.faceFile =
        await FlutterNativeImage.cropImage(photoFile.path, 110, 70, 600, 350);
  }

  Future<void> checkFace() async {
    try {
      MainScan.hasFace = await ImageFace.hasFace(File(checkFaceFile.path));
    } on PlatformException {}
    if (!mounted) return;
  }

  void _tapOnCar() {
    setState(() {
      _isCar = true;
      _isHuman = false;
      _isQr = false;
    });
  }

  void _tapOnHuman() {
    setState(() {
      _isCar = false;
      _isHuman = true;
      _isQr = false;
    });
  }

  void _tapOnQr() {
    setState(() {
      _isCar = false;
      _isHuman = false;
      _isQr = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                'Фото-скан',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          elevation: 0.0,
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                height: 56,
                child: _isTapped
                    ? TextButton(
                        child: Text('Сделать фото'),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 16),
                          primary: Color(0xFF1B1512),
                          backgroundColor: ColorConstants.tertiaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {})
                    : _isHuman
                        ? TextButton(
                            child: Text('Сделать фото'),
                            style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 16),
                              primary: Color(0xFF1B1512),
                              backgroundColor: Color(0xFFF0C332),
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              Future<void> isReady = _takePhoto(context);
                              _setTapped();

                              isReady.then((_) {
                                Future.delayed(Duration(milliseconds: 500), () {
                                  Future<void> pick = checkFace();
                                  pick.then((value) {
                                    if (MainScan.hasFace == false)
                                      noFaceMessage(context);
                                    else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ConfirmScan(
                                                    faceResult: "1",
                                                  )));
                                    }
                                  });
                                });
                              });
                              Future<void> x =
                                  Future.delayed(Duration(milliseconds: 3000));
                              x.then((value) => _setTapped());
                            },
                          )
                        : _isCar
                            ? TextButton(
                                child: Text('Сделать фото'),
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 16),
                                  primary: Color(0xFF1B1512),
                                  backgroundColor: Color(0xFFF0C332),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                onPressed: () {
                                  Future<void> isReady = _takePhoto(context);
                                  _setTapped();

                                  isReady.then((_) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ConfirmScan(
                                                  carResult: "1",
                                                )));
                                  });
                                  Future<void> x = Future.delayed(
                                      Duration(milliseconds: 3000));
                                  x.then((value) => _setTapped());
                                },
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFEF4D5),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Center(
                                  child: Text(
                                    "Наведите камеру на QR-код",
                                    style: TextStyle(
                                        color: ColorConstants.blackColor,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
              ),
            ),
            Positioned(
              bottom: 92,
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: OutlinedButton(
                          child: Text('Машина'),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Color(0xFFF6F2EF),
                              side: _isCar
                                  ? BorderSide(
                                      color: Color(0xFFF0C332), width: 1)
                                  : BorderSide(
                                      color: Color(0xFFF6F2EF), width: 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          onPressed: () {
                            if (_isQr) {
                              Future<void> x = setupCamera();
                              x.then((value) {
                                _tapOnCar();
                              });
                            }
                            if (_isHuman) _tapOnCar();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: OutlinedButton(
                          child: Text('Человек'),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Color(0xFFF6F2EF),
                              side: _isHuman
                                  ? BorderSide(
                                      color: Color(0xFFF0C332), width: 1)
                                  : BorderSide(
                                      color: Color(0xFFF6F2EF), width: 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          onPressed: () {
                            if (_isQr) {
                              Future<void> x = setupCamera();
                              x.then((value) {
                                _tapOnHuman();
                              });
                            }
                            if (_isCar) _tapOnHuman();
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 48,
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      child: OutlinedButton(
                        child: Text('QR'),
                        style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Color(0xFFF6F2EF),
                            side: _isQr
                                ? BorderSide(color: Color(0xFFF0C332), width: 1)
                                : BorderSide(
                                    color: Color(0xFFF6F2EF), width: 1),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        onPressed: () {
                          if (_isCar || _isHuman) {
                            _controller?.dispose();
                          }
                          _tapOnQr();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 152,
              child: Text(
                'Выберите тип фото',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            _isQr == false
                ? Positioned(
                    bottom: 190,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: _cameraView(),
                        ),
                        _isHuman
                            ? Container(
                                child: ScanHumam(),
                              )
                            : Container(
                                child: ScanCar(),
                              ),
                      ],
                    ),
                  )
                : Positioned(
                    bottom: 190,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: QRScan()),
                  )
          ],
        ));
  }
}

noFaceMessage(BuildContext context) {
  Widget okButton = Container(
    height: 48,
    width: 300,
    child: TextButton(
      child: Text('Сделать новое фото'),
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 16),
        primary: Color(0xFF1B1512),
        backgroundColor: Color(0xFFF0C332),
        shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );

  AlertDialog alert = AlertDialog(
    insetPadding: EdgeInsets.only(left: 20, right: 20),
    titlePadding: EdgeInsets.only(top: 32),
    contentPadding: EdgeInsets.only(bottom: 17, top: 12),
    actionsPadding: EdgeInsets.only(
      left: 51.5,
      right: 51.5,
      bottom: 24,
    ),
    title: Center(
      child: SvgPicture.asset(
        "assets/images/smail.svg",
        height: 48,
        width: 48,
        fit: BoxFit.none,
      ),
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Лицо не обнаружено",
          style: TextStyle(fontSize: 16, color: ColorConstants.redColor),
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
