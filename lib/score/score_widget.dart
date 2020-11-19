import 'dart:math';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:warmd/common/criterias.dart';
import 'package:warmd/generated/locale_keys.g.dart';

const _levelColors = [
  Color(0xFF00A31D),
  Color(0xFF00CD51),
  Color(0xFFD7F617),
  Color(0xFFF9A500),
  Color(0xFFF95A00),
  Color(0xFFFB464A),
];

Color _scoreRatioToColor(double scoreRatio) => _levelColors[(5 * scoreRatio).round()];

class ScoreWidget extends StatefulWidget {
  final CriteriasState state;

  const ScoreWidget(this.state);

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
    final scoreRatio = min(1.0, widget.state.co2EqTonsPerYear() / 25);

    return Stack(
      children: [
        Container(
          height: 180,
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: CustomPaint(
              painter: _ScoreArcPainter(scoreRatio),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.state.co2EqTonsPerYear().toStringAsFixed(1) + ' ',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: _scoreRatioToColor(scoreRatio), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: LocaleKeys.scoreUnit.tr(),
                    style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScoreArcPainter extends CustomPainter {
  final double scoreRatio;

  const _ScoreArcPainter(this.scoreRatio);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 50;

    var startPoint = Offset(size.width / 10, size.height / 1.1);
    var controlPoint1 = Offset(size.width / 15, 0);
    var controlPoint2 = Offset(size.width - size.width / 15, 0);
    var endPoint = Offset(size.width - size.width / 10, size.height / 1.1);

    var completePath = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, endPoint.dx, endPoint.dy);

    final metric = completePath.computeMetrics().first;
    final separatorLength = metric.length / 20;
    final segmentLength = (metric.length - (5 * separatorLength)) / 6;

    final splittedPaths = <Path>[];
    var distance = 0.0;
    while (distance < metric.length) {
      splittedPaths.add(metric.extractPath(distance, distance + segmentLength));
      distance += segmentLength + separatorLength;
    }

    splittedPaths.asMap().forEach((i, path) {
      paint.color = _levelColors[i];
      canvas.drawPath(
        path,
        paint,
      );
    });

    final roundCenter = metric.extractPath(metric.length * scoreRatio, metric.length * scoreRatio).getBounds().bottomLeft;
    paint.color = _scoreRatioToColor(scoreRatio);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(roundCenter, size.width / 20, paint);
    paint.color = Colors.white;
    canvas.drawCircle(roundCenter, size.width / 27, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
