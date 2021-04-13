import 'dart:io';

import 'package:check_drivers/elements/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ScanHumam extends StatefulWidget {
  @override
  _ScanHumamState createState() => _ScanHumamState();
}

class _ScanHumamState extends State<ScanHumam> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      CustomPaint(
        painter: HolePainter(),
        child: Container(),
      ),
      Container(
        child: SvgPicture.asset(
          "assets/images/plechi.svg",
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Positioned(
        bottom: 182,
        child: Container(
          child: SvgPicture.asset(
            "assets/images/oval.svg",
          ),
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // child: MainScan.hasFace
        //     ? Image.file(
        //         File(MainScan.faceFile.path),
        //         fit: BoxFit.fitHeight,
        //       )
        //     : null,
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
    var smallCircle = Alignment.bottomCenter.inscribe(
        Size(250, 290), Rect.fromLTWH(size.width / 2, size.height - 190, 0, 0));

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRRect(RRect.fromRectAndRadius(smallRect, Radius.circular(8))),
        Path()
          ..addOval(smallCircle)
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
