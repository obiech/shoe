
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShapePainter extends CustomPainter {
  final double sides;
  final double radius;
  final double radians;
  ShapePainter(this.sides, this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {

    Paint painter(double opacity) {
      var paint = Paint()
        ..color = Color(0xff7D63EB).withOpacity(opacity)
        ..strokeWidth = 5
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;
      return paint;
    }

    Path path(double radius) {
      var path = Path();
      var angle = (math.pi * 2) / sides;

      Offset center = Offset(size.width / 2, size.height / 2);
      Offset startPoint =
          Offset(radius * math.cos(radians), radius * math.sin(radians));

      path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

      for (int i = 1; i <= sides; i++) {
        double x = radius * math.cos(radians + angle * i) + center.dx;
        double y = radius * math.sin(radians + angle * i) + center.dy;
        path.lineTo(x, y);
      }
      path.close();
      return path;
    }
    canvas.drawPath(path(radius), painter(0.1));
    canvas.drawPath(path(radius -20), painter(0.2));
    canvas.drawPath(path(radius -40), painter(0.3));
    canvas.drawPath(path(radius -60), painter(0.2));
    canvas.drawPath(path(radius -80), painter(0.2));
    canvas.drawPath(path(radius -100), painter(0.1));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
