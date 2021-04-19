import 'package:flutter/material.dart';

class ScanCar extends StatefulWidget {
  @override
  _ScanCarState createState() => _ScanCarState();
}

class _ScanCarState extends State<ScanCar> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      CustomPaint(
        painter: HolePainter(),
        child: Container(),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    ]);
  }
}

class HolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black.withOpacity(0.5);
    var smallRect = Alignment.bottomCenter.inscribe(
        Size(500, 900), Rect.fromLTWH(size.width / 2 - 35, size.height, 20, 0));
    var recatangle = Alignment.bottomCenter.inscribe(
        Size(320, 93), Rect.fromLTWH(size.width / 2, size.height - 227, 0, 0));

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(RRect.fromRectAndRadius(smallRect, Radius.circular(8))),
        Path()
          ..addRect(recatangle)
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
