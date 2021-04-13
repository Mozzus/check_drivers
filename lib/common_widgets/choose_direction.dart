import 'package:check_drivers/elements/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseDirection extends StatefulWidget {
  ChooseDirection({Key key}) : super(key: key);

  @override
  _ChooseDirectionState createState() => _ChooseDirectionState();
}

class _ChooseDirectionState extends State<ChooseDirection> {
  bool _isEnter = true;
  bool _isExit = false;

  void _tapOnCar() {
    setState(() {
      _isExit = true;
      _isEnter = false;
    });
  }

  void _tapOnHuman() {
    setState(() {
      _isExit = false;
      _isEnter = true;
    });
  }

  void _tapOnQr() {
    setState(() {
      _isExit = false;
      _isEnter = false;
    });
  }

  Widget build(BuildContext context) {
    // var item = context.read<CardModel>();

    return Container(
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
              width: MediaQuery.of(context).size.width / 2 - 25,
              child: OutlinedButton(
                child: Text('Въезд'),
                style: OutlinedButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Color(0xFFF6F2EF),
                    side: _isEnter
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
        ],
      ),
    );
  }
}
