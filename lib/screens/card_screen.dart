import 'package:check_drivers/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';

class CardScreen extends StatelessWidget {
  CardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                ),
              ),
              Text(
                'АE 3822',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          elevation: 0.0,
          toolbarHeight: 50,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: Container(),
      ),
      previewChild: Container(
        padding: EdgeInsets.only(left: 40, top: 30),
        decoration: BoxDecoration(
            color: ColorConstants.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(24))),
        child: Container(
          child: Text(
            'А354МК|185',
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.w600),
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
                    onPressed: () {}),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 100,
              child: Text(
                '01 мая 2021',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 122,
              child: Text(
                '14:40-14:45',
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
                '01 мая 2021',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 216,
              child: Text(
                '14:34:43',
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
                'А354МК|185',
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
  }
}
