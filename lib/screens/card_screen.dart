import 'dart:io';

import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/elements/card.dart';
import 'package:flutter/material.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatelessWidget {
  final int id;
  CardScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.read<CardModel>();
    return Consumer<CardModel>(builder: (context, card, child) {
      return Scaffold(
          body: DraggableBottomSheet(
        blurBackground: false,
        backgroundWidget: Scaffold(
          backgroundColor: ColorConstants.greyColor,
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
                  card.getById(id).name,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ],
            ),
            elevation: 0.0,
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: item == null
                ? null
                : (item.getById(id).currentPhoto == null
                    ? null
                    : Image.file(
                        File(item.getById(id).currentPhoto.path),
                        fit: BoxFit.cover,
                      )),
          ),
        ),
        previewChild: Container(
          padding: EdgeInsets.only(left: 40, top: 30),
          decoration: BoxDecoration(
              color: ColorConstants.background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(24))),
          child: Container(
            child: Text(
              card.getById(id).name,
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        expandedChild: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: ColorConstants.background,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(24))),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  height: 56,
                  child: TextButton(
                      child: Text('Обновить данные'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 16),
                        primary: Color(0xFF1B1512),
                        backgroundColor: Color(0xFFF0C332),
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        // Метод обновления данных
                        card.getCurrentCardCheck(
                            id, card.getById(id).idOnServer);
                      }),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 100,
                child: Text(
                  card.getById(id).passDate,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 122,
                child: Text(
                  card.getById(id).passTime,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 158,
                child: Text(
                  'Согласованное время прибытия',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.greyColor,
                  ),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 194,
                child: Text(
                  card.getById(id).currentDate,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 216,
                child: Text(
                  card.getById(id).currentTime,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Positioned(
                left: 40,
                bottom: 252,
                child: Text(
                  'Дата создания карточки',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.greyColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 304,
                left: 40,
                child: Text(
                  card.getById(id).name,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        minExtent: 98,
        maxExtent: 388,
      ));
    });
  }
}
