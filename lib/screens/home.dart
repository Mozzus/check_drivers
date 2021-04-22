import 'dart:io';

import 'package:check_drivers/constants/colors.dart';
import 'package:check_drivers/constants/my_flutter_app_icons.dart';
import 'package:check_drivers/elements/card.dart';
import 'package:check_drivers/elements/models/item.dart';
import 'package:check_drivers/screens/card_screen.dart';
import 'package:check_drivers/screens/scan_screens/confirm_scan_screen.dart';
import 'package:check_drivers/screens/scan_screens/scan.dart';
import 'package:check_drivers/screens/settings.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card = context.watch<CardModel>();

    return Scaffold(
      backgroundColor: ColorConstants.homeBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Электронный пропуск',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              child: Container(
                height: 40,
                width: 24,
                child: SvgPicture.asset(
                  "assets/images/home/settings.svg",
                  height: 24,
                  width: 24,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ],
        ),
        elevation: 0.0,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          card.get10cardsCheck();
          return null;
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              InfoCard(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                itemCount: card.getLength(),
                itemBuilder: (context, position) => _CardItem(position),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 96,
        color: ColorConstants.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 56,
              width: MediaQuery.of(context).size.width / 2 - 30,
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/home/nfc.svg",
                      height: 24,
                      width: 24,
                      fit: BoxFit.none,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'NFC',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Color(0xFFF6F2EF),
                    side: BorderSide(color: Color(0xFFF6F2EF), width: 1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45)))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmScan(
                                nfcCertificate: "1",
                              )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 56,
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: OutlinedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/home/camera2.svg",
                        height: 24,
                        width: 24,
                        fit: BoxFit.none,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Фото',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Color(0xFFF6F2EF),
                      side: BorderSide(color: Color(0xFFF6F2EF), width: 1),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScan()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
          child: ScrollOnExpand(
            child: Card(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: false,
                      tapBodyToCollapse: false,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: ColorConstants.background,
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Text(
                              "Обозначение цветами",
                              style: TextStyle(
                                color: ColorConstants.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              iconColor: ColorConstants.greyColor,
                              expandIcon: MyFlutterApp.eye,
                              collapseIcon: MyFlutterApp.eye_slash,
                              iconSize: 20,
                              iconPadding: EdgeInsets.only(right: 26),
                              hasIcon: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    collapsed: Container(),
                    expanded: Container(
                      margin: EdgeInsets.only(
                        top: 2,
                      ),
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.greenColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Доступ разрешен",
                                    style: TextStyle(
                                        color: ColorConstants.greenColor,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.orangeColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Доступ разрешен с ограничениями",
                                      style: TextStyle(
                                          color: ColorConstants.orangeColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.redColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Доступ запрещен",
                                      style: TextStyle(
                                          color: ColorConstants.redColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.greyColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Данные отсутствуют",
                                      style: TextStyle(
                                          color: ColorConstants.greyColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

//
// Карточка
//
class _CardItem extends StatelessWidget {
  final int id;

  _CardItem(this.id, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    var item = context.select<CardModel, Item>(
        (value) => value.getLength() == 0 ? null : value.getById(id));
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CardScreen(
                      id: id,
                    )));
      },
      child: Consumer<CardModel>(builder: (context, card, child) {
        return item.isGotFromAPI
            ?

            //
            // Карточка полученная от сервера
            //
            Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 16),
                decoration: BoxDecoration(
                  color: ColorConstants.greenColor,
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: new LinearGradient(stops: [
                    0.01,
                    0.01
                  ], colors: [
                    Color(int.parse(card.getById(id).statusColor)),
                    Colors.white
                  ]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorConstants.homeBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: item.statusResult ==
                                                    "Доступ разрешен"
                                                ? SvgPicture.asset(
                                                    "assets/images/home/camera_green.svg",
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.none,
                                                  )
                                                : item.statusResult ==
                                                        "Доступ запрещен"
                                                    ? SvgPicture.asset(
                                                        "assets/images/home/camera_red.svg",
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.none,
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/images/home/camera_yellow.svg",
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.none,
                                                      ),
                                          ),
                                          Image.asset(
                                            "assets/images/home/line.png",
                                            height: 18,
                                            width: 2,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorConstants.homeBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: item.statusResult ==
                                                    "Доступ разрешен"
                                                ? SvgPicture.asset(
                                                    "assets/images/home/pin_green.svg",
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.none,
                                                  )
                                                : item.statusResult ==
                                                        "Доступ запрещен"
                                                    ? SvgPicture.asset(
                                                        "assets/images/home/pin_red.svg",
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.none,
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/images/home/pin_yellow.svg",
                                                        height: 20,
                                                        width: 20,
                                                        fit: BoxFit.none,
                                                      ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 16),
                                        height: 98,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              card.getById(id).name,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0),
                                              child: Text(
                                                card.getById(id).currentDate +
                                                    " " +
                                                    card
                                                        .getById(id)
                                                        .currentTime,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ColorConstants.greyColor,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    card.getById(id).passTime,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: ColorConstants
                                                          .blackColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2.0),
                                                    child: Text(
                                                      card.getById(id).passDate,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: ColorConstants
                                                            .greyColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            height: 90,
                            width: 102,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: item == null
                                ? null
                                : (item.currentPhoto == null
                                    ? null
                                    : Image.file(
                                        File(item.currentPhoto.path),
                                        fit: BoxFit.fitWidth,
                                      )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            :
            //
            // Дефолтно серая карточка
            //
            Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 16),
                decoration: BoxDecoration(
                  color: ColorConstants.greenColor,
                  borderRadius: BorderRadius.circular(8.0),
                  gradient: new LinearGradient(
                      stops: [0.01, 0.01],
                      colors: [ColorConstants.greyColor, Colors.white]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorConstants.homeBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/home/camera_grey.svg",
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/images/home/line.png",
                                            height: 18,
                                            width: 2,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  ColorConstants.homeBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/home/pin_grey.svg",
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 16),
                                        height: 98,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/home/loading.svg",
                                              fit: BoxFit.none,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 2.0),
                                              child: Text(
                                                item.passDate,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      ColorConstants.greyColor,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Запрос",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: ColorConstants
                                                          .blackColor,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2.0),
                                                    child: Text(
                                                      "в обработке",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: ColorConstants
                                                            .greyColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            height: 90,
                            width: 102,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: item == null
                                ? null
                                : (item.currentPhoto == null
                                    ? null
                                    : Image.file(
                                        File(item.currentPhoto.path),
                                        fit: BoxFit.fitWidth,
                                      )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
