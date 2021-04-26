import 'dart:io';

import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/elements/logic/card.dart';
import 'package:check_drivers/elements/models/item.dart';
import 'package:check_drivers/screens/scan_screens/scan.dart';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class ConfirmScan extends StatefulWidget {
  final String qrCodeResult;
  final String nfcCertificate;
  final String faceResult;
  final String carResult;

  ConfirmScan(
      {Key key,
      this.qrCodeResult,
      this.nfcCertificate,
      this.faceResult,
      this.carResult})
      : super(key: key);

  @override
  _ConfirmScanState createState() => _ConfirmScanState();
}

class _ConfirmScanState extends State<ConfirmScan> {
  String certificate;
  bool _isEnter = true;
  bool _isExit = false;
  List<String> parseQR;
  String numberOfCar = "QR некорректен";
  String numberOfDoc = "QR некорректен";

  void _tapOnExit() {
    setState(() {
      _isExit = true;
      _isEnter = false;
    });
  }

  void _tapOnEnter() {
    setState(() {
      _isExit = false;
      _isEnter = true;
    });
  }

  Future<void> startScaning() async {
    NDEFMessage message = await NFC.readNDEF(once: true).first;
    setState(() {
      certificate = message.data;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.qrCodeResult != null) {
      if (widget.qrCodeResult.contains(",")) {
        parseQR = widget.qrCodeResult.split(", ");
        numberOfCar = parseQR[0];
        numberOfDoc = parseQR[1];
      }
    }

    // Проверка на наличие NFC
    NFC.isNDEFSupported.then((bool isSupported) {
      setState(() {
        if (widget.nfcCertificate != null) {
          startScaning();
        }
      });
    });
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
                    Navigator.pop(context);
                  },
                ),
              ),
              Text(
                "Фото-скан",
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
                child: TextButton(
                  child: Text('Отправить'),
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16),
                    primary: Color(0xFF1B1512),
                    backgroundColor: Color(0xFFF0C332),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Item cardItem = new Item();
                    cardItem.isGotFromAPI = false;
                    if (_isEnter)
                      cardItem.isEnter = true;
                    else
                      cardItem.isEnter = false;
                    if (widget.faceResult != null) cardItem.type = "driver";
                    if (widget.carResult != null) cardItem.type = "car";
                    if (MainScan.faceFile != null) {
                      final bytes =
                          File(MainScan.faceFile.path).readAsBytesSync();
                      cardItem.image = cardItem.base64Encode(bytes);
                    }
                    item.add(cardItem);
                    if (widget.qrCodeResult != null) {
                      Item cardItem2 = new Item();
                      item.add(cardItem2);
                      cardItem.typeOfCheck = "qr";
                      cardItem2.typeOfCheck = "qr";
                      item.postCertificateDriverCheck(item.getLength() - 1,
                          numberOfCar, cardItem.direction);
                      item.postCertificateCarCheck(item.getLength() - 2,
                          numberOfDoc, cardItem2.direction);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else if (widget.nfcCertificate != null) {
                      cardItem.typeOfCheck = "nfc";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else {
                      Future.delayed(Duration(milliseconds: 1000))
                          .then((value) {
                        item.setImageToCard(MainScan.faceFile, cardItem);
                        item.postFaceCarCheck(item.getLength() - 1,
                            cardItem.type, cardItem.direction, cardItem.image);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 92,
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10),
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        child: OutlinedButton(
                          child: Text('Выезд'),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Color(0xFFF6F2EF),
                              side: _isExit
                                  ? BorderSide(
                                      color: Color(0xFFF0C332), width: 1)
                                  : BorderSide(
                                      color: Color(0xFFF6F2EF), width: 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          onPressed: () {
                            _tapOnExit();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        child: OutlinedButton(
                          child: Text('Въезд'),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Color(0xFFF6F2EF),
                              side: _isEnter
                                  ? BorderSide(
                                      color: Color(0xFFF0C332), width: 1)
                                  : BorderSide(
                                      color: Color(0xFFF6F2EF), width: 1),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          onPressed: () {
                            _tapOnEnter();
                          },
                        ),
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
                'Какое действие на фото?',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            widget.nfcCertificate == null
                ? Positioned(
                    bottom: 190,
                    child: widget.qrCodeResult == null
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: MainScan.faceFile == null
                                ? null
                                : Image.file(
                                    File(MainScan.faceFile?.path),
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height - 230,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black.withOpacity(0.8),
                            child: Center(
                              child: Container(
                                  height: 222,
                                  width: 320,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Гос.номер',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: ColorConstants.greyColor,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          numberOfCar,
                                          style: TextStyle(
                                            fontSize: 28,
                                            color: ColorConstants.blackColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 24.0),
                                        child: Text(
                                          '№ водительского удостоверения',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: ColorConstants.greyColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          numberOfDoc,
                                          style: TextStyle(
                                            fontSize: 28,
                                            color: ColorConstants.blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                            ),
                          ),
                  )
                : Positioned(
                    bottom: 190,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 230,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.8),
                      child: Center(
                        child: Container(
                            height: 222,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 36.0, top: 36.0, right: 36.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Идентификатор карты',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.greyColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: certificate == null
                                        ? Center(
                                            child: Text(
                                              "Поднесите устройство к метке",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color:
                                                    ColorConstants.blackColor,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            certificate,
                                            style: TextStyle(
                                              fontSize: 28,
                                              color: ColorConstants.blackColor,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
          ],
        ));
  }
}
