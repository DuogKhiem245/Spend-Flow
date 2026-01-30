import 'package:flutter/cupertino.dart';

class AnimatedDashedPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;
  final double strokeWidth;
  final double radius;

  AnimatedDashedPainter({
    required this.animation,
    required this.color,
    this.strokeWidth = 2,
    this.radius = 24,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    final double dashWidth = 10.0;
    final double dashSpace = 6.0;
    final double totalDashLength = dashWidth + dashSpace;

    final double offset = -animation.value * totalDashLength;

    for (final metric in path.computeMetrics()) {
      double distance = offset;

      while (distance < metric.length) {
        if (distance + dashWidth > 0) {
          final double start = distance < 0 ? 0 : distance;
          final double end = (distance + dashWidth) > metric.length
              ? metric.length
              : (distance + dashWidth);

          canvas.drawPath(metric.extractPath(start, end), paint);
        }
        distance += totalDashLength;
      }
    }
  }

  @override
  bool shouldRepaint(AnimatedDashedPainter oldDelegate) => true;
}
