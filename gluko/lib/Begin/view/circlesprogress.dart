import 'package:flutter/material.dart';
class RingPainter extends CustomPainter {
  RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.background,
    required this.color,
    required this.titulo
  });

  final double progress;
  final double strokeWidth;
  final Color background;
  final Color color;
  final String titulo;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final startAngle = -3.416 / 2;
    final sweepAngle = 2 * 3.416 * progress;

    final backgroundPaint = Paint()
      ..color = background
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: 0.0,
        endAngle: 3.416 * 2,
        stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.red],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, progressPaint);

    final textSpan = TextSpan(
      text: '${titulo}',
      style: TextStyle(fontSize: radius / 2, color: Colors.black, fontWeight: FontWeight.w300),
    );
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: size.width);
    final textCenter = Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, textCenter);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

// ...
}