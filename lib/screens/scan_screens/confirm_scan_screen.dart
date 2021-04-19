import 'dart:io';

import 'package:check_drivers/common_widgets/choose_direction.dart';
import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/elements/card.dart';
import 'package:check_drivers/screens/scan_screens/scan.dart';
import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class ConfirmScan extends StatefulWidget {
  final String qrCodeResult;
  final String nfcCertificate;

  ConfirmScan({Key key, this.qrCodeResult, this.nfcCertificate})
      : super(key: key);

  @override
  _ConfirmScanState createState() => _ConfirmScanState();
}

class _ConfirmScanState extends State<ConfirmScan> {
  String certificate;

  Future<void> startScaning() async {
    NDEFMessage message = await NFC.readNDEF(once: true).first;
    setState(() {
      certificate = message.data;
    });
  }

  @override
  void initState() {
    super.initState();
    // Check if the device supports NFC reading
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
                    if (item.getLength() != 0) item.removeLastItem();
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
                    item.setImageToCard(
                      MainScan.faceFile,
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 92,
              child: ChooseDirection(),
            ),
            // Positioned(
            //   left: 20,
            //   bottom: 152,
            //   child: Consumer<CardModel>(builder: (context, cart, child) {
            //     return Text(
            //       cart.getLength().toString(),
            //       style: TextStyle(fontSize: 14, color: Colors.black),
            //     );
            //   }),
            // ),
            //
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
                                          widget.qrCodeResult,
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
