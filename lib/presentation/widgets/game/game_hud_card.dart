import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_bloc/shared/extension/text_style.dart';

/// Card dùng chung trong HUD của các game.
/// Hiển thị icon + label nhỏ + giá trị lớn với màu accent tùy game.
class GameHudCard extends StatelessWidget {
  const GameHudCard({
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 10)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.r, color: color),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: kTextStyle
                    .size(9.sp)
                    .withColor(color.withValues(alpha: 0.7))
                    .bold
                    .withLetterSpacing(1.2),
              ),
              Text(value, style: kTextStyle.size(16.sp).withColor(color).extraBold),
            ],
          ),
        ],
      ),
    );
  }
}
