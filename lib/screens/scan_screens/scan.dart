import 'dart:io';

import 'package:camera/camera.dart';
import 'package:check_drivers/common_widgets/choose_scan.dart';
import 'package:check_drivers/elements/card.dart';
import 'package:check_drivers/elements/item.dart';
import 'package:check_drivers/screens/scan_screens/scan_human.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_face/image_face.dart';
import 'package:provider/provider.dart';

import 'confirm_scan_screen.dart';

class MainScan extends StatefulWidget {
  static File faceFile;
  static bool hasFace = false;

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
        _showBottomSheet(context);
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

  void _showBottomSheet(context) async {
    checkFaceFile =
        await FlutterNativeImage.cropImage(photoFile.path, 300, 130, 230, 180);
    MainScan.faceFile =
        await FlutterNativeImage.cropImage(photoFile.path, 50, 60, 600, 350);
    pickFace();
  }

  Future<void> pickFace() async {
    try {
      print('start check');
      MainScan.hasFace = await ImageFace.hasFace(File(checkFaceFile.path));
      print('end check');
    } on PlatformException {
      print('Failed to get faces');
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    var item = context.read<CardModel>();
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
                    print("ITEM LENGTH IS --------" +
                        item.getLength().toString());
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
                height: 50,
                child: TextButton(
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
                    _takePhoto(context);
                    item.add(new Item());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ConfirmScan()));
                    // if (MainScan.hasFace == false)
                    //   showAlertDialog(context);
                    // else {
                    // item.currentPhoto(MainScan.faceFile);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomeScreen()));
                    // }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 92,
              child: ChooseScan(),
            ),
            Positioned(
              left: 20,
              bottom: 152,
              child: Text(
                'Выберите тип фото',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            // Positioned(
            //   bottom: 190,
            //   child: Container(
            //     height: MediaQuery.of(context).size.height,
            //     width: MediaQuery.of(context).size.width,
            //     child: _cameraView(),
            //   ),
            // ),
            Positioned(
              bottom: 190,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: _cameraView(),
                  ),
                  Container(
                    child: ScanHumam(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// showAlertDialog(BuildContext context) {
//   var item = context.select<CardModel, Item>((value) => value.getById(0));

//   Widget okButton = Container(
//     height: 48,
//     width: 300,
//     child: TextButton(
//       child: Text('Сделать новое фото'),
//       style: TextButton.styleFrom(
//         textStyle: TextStyle(fontSize: 16),
//         primary: Color(0xFF1B1512),
//         backgroundColor: Color(0xFFF0C332),
//         shape: new RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     ),
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     insetPadding: EdgeInsets.only(left: 20, right: 20),
//     titlePadding: EdgeInsets.only(top: 32),
//     contentPadding: EdgeInsets.only(bottom: 17, top: 12),
//     actionsPadding: EdgeInsets.only(
//       left: 51.5,
//       right: 51.5,
//       bottom: 24,
//     ),
//     title: Center(
//       child: SvgPicture.asset(
//         "assets/images/smail.svg",
//         height: 48,
//         width: 48,
//         fit: BoxFit.none,
//       ),
//     ),
//     content: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Лицо не обнаружено",
//           style: TextStyle(fontSize: 16, color: ColorConstants.redColor),
//         ),
//       ],
//     ),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Consumer<CardModel>(builder: (context, cart, child) {
//         if (cart.getById(0).hasFace) return alert;
//       });
//     },
//   );
// }
