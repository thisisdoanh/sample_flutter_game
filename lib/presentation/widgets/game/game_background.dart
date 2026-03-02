import 'package:flutter/material.dart';

/// Widget nền chung cho tất cả các game.
/// Vẽ gradient tối từ trên xuống + lưới ô vuông tạo cảm giác cyber/sci-fi.
///
/// [scrollY] khác 0 sẽ làm lưới dịch chuyển theo camera (dùng cho game có scroll).
/// Mỗi game có thể truyền bộ màu riêng để tạo phong cách khác nhau.
class GameBackground extends StatelessWidget {
  const GameBackground({
    super.key,
    required this.topColor,
    required this.bottomColor,
    required this.gridColor,
    this.gridAlpha = 0.4,
    this.scrollY = 0.0,
  });

  final Color topColor;
  final Color bottomColor;
  final Color gridColor;
  final double gridAlpha;

  /// Camera offset — lưới sẽ cuộn theo giá trị này.
  /// Để 0.0 nếu nền tĩnh.
  final double scrollY;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GameBgPainter(
        topColor: topColor,
        bottomColor: bottomColor,
        gridColor: gridColor,
        gridAlpha: gridAlpha,
        scrollY: scrollY,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _GameBgPainter extends CustomPainter {
  const _GameBgPainter({
    required this.topColor,
    required this.bottomColor,
    required this.gridColor,
    required this.gridAlpha,
    required this.scrollY,
  });

  final Color topColor;
  final Color bottomColor;
  final Color gridColor;
  final double gridAlpha;
  final double scrollY;

  static const double _gridSpacing = 40.0;

  @override
  void paint(Canvas canvas, Size size) {
    // ── Gradient nền ──────────────────────────────────────────────────────────
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [topColor, bottomColor],
        ).createShader(rect),
    );

    // ── Lưới dịch chuyển theo scrollY ─────────────────────────────────────────
    final gridPaint = Paint()
      ..color = gridColor.withValues(alpha: gridAlpha)
      ..strokeWidth = 0.5;

    final offsetY = scrollY % _gridSpacing;
    for (double y = -offsetY; y < size.height; y += _gridSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 0; x < size.width; x += _gridSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(_GameBgPainter old) =>
      old.scrollY != scrollY ||
      old.topColor != topColor ||
      old.bottomColor != bottomColor ||
      old.gridColor != gridColor ||
      old.gridAlpha != gridAlpha;
}
