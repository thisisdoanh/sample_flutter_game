part of '../catch_the_button_page.dart';

class _GameHud extends StatelessWidget {
  const _GameHud({required this.score, required this.bestScore, required this.timeLeft});

  final int score;
  final int bestScore;
  final int timeLeft;

  // Đổi màu timer khi gần hết giờ để tạo cảm giác khẩn cấp
  Color get _timeColor {
    if (timeLeft <= 5) return const Color(0xFFFF5757);
    if (timeLeft <= 10) return const Color(0xFFFF9F1C);
    return const Color(0xFF29F478);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GameHudCard(
              icon: Icons.touch_app_rounded,
              label: l10n.hudTaps,
              value: '$score',
              color: const Color(0xFF9B5DE5),
            ),
            // Timer lớn ở giữa
            _TimerDisplay(timeLeft: timeLeft, color: _timeColor),
            GameHudCard(
              icon: Icons.emoji_events_rounded,
              label: l10n.hudBest,
              value: '$bestScore',
              color: const Color(0xFFFFD700),
            ),
          ],
        ),
      ),
    );
  }
}

// Timer hiển thị nổi bật ở giữa HUD
class _TimerDisplay extends StatelessWidget {
  const _TimerDisplay({required this.timeLeft, required this.color});

  final int timeLeft;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 12)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hourglass_bottom_rounded, size: 14.r, color: color),
          SizedBox(height: 2.h),
          Text(
            '${timeLeft}s',
            style: kTextStyle.size(20.sp).withColor(color).extraBold,
          ),
        ],
      ),
    );
  }
}

