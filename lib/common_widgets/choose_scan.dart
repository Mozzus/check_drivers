import 'package:check_drivers/elements/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseScan extends StatefulWidget {
  ChooseScan({Key key}) : super(key: key);

  @override
  _ChooseScan createState() => _ChooseScan();
}

class _ChooseScan extends State<ChooseScan> {
  bool _isHuman = true;
  bool _isCar = false;
  bool _isQr = false;

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

  Widget build(BuildContext context) {
    // var item = context.read<CardModel>();

    return Container(
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
                        ? BorderSide(color: Color(0xFFF0C332), width: 1)
                        : BorderSide(color: Color(0xFFF6F2EF), width: 1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                onPressed: () {
                  // item.changeItemType("Car");
                  _tapOnCar();
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
                        ? BorderSide(color: Color(0xFFF0C332), width: 1)
                        : BorderSide(color: Color(0xFFF6F2EF), width: 1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                onPressed: () {
                  // item.changeItemType("Driver");
                  _tapOnHuman();
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
                      : BorderSide(color: Color(0xFFF6F2EF), width: 1),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)))),
              onPressed: () {
                _tapOnQr();
              },
            ),
          ),
        ],
      ),
    );
  }
}
