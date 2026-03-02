import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_bloc/l10n/app_localizations.dart';
import 'package:template_bloc/shared/extension/text_style.dart';

/// Badge "NEW BEST RECORD!" hiển thị khi người chơi lập kỷ lục mới.
/// Dùng chung cho tất cả các game.
class GameNewBestBadge extends StatelessWidget {
  const GameNewBestBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFF9F1C)],
        ),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 16.r, color: Colors.white),
          SizedBox(width: 6.w),
          Text(
            l10n.newBestRecord,
            style: kTextStyle
                .size(12.sp)
                .withColor(Colors.white)
                .extraBold
                .withLetterSpacing(1),
          ),
        ],
      ),
    );
  }
}
