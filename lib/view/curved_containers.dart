import 'package:flutter/material.dart';

class CustomCurvePaintFirst extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.6,
        size.width * 0.33, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.66, size.height * 0.73,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomCurvePaintSecond extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.6,
        size.width * 0.33, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.66, size.height * 0.73,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomCurvePaintLast extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.58,
        size.width * 0.33, size.height * 0.62);
    path.quadraticBezierTo(size.width * 0.66, size.height * 0.68,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
