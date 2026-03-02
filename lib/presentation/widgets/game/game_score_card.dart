import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_bloc/shared/extension/text_style.dart';

/// Card điểm số dùng chung trong màn hình Game Over.
/// Hiển thị icon + số điểm lớn + label nhỏ với màu accent tùy game.
class GameScoreCard extends StatelessWidget {
  const GameScoreCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22.r, color: color),
          SizedBox(height: 6.h),
          Text(value, style: kTextStyle.size(24.sp).withColor(color).black),
          Text(
            label,
            style: kTextStyle
                .size(9.sp)
                .withColor(color.withValues(alpha: 0.6))
                .bold
                .withLetterSpacing(1.2),
          ),
        ],
      ),
    );
  }
}
