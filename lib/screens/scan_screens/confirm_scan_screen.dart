import 'dart:io';

import 'package:check_drivers/common_widgets/choose_direction.dart';
import 'package:check_drivers/elements/card.dart';
import 'package:check_drivers/screens/scan_screens/scan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class ConfirmScan extends StatelessWidget {
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
            Positioned(
              bottom: 190,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.file(
                  File(MainScan.faceFile.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
  }
}
