part of '../balance_ball_page.dart';

class _GameHud extends StatelessWidget {
  const _GameHud({required this.score, required this.bestScore});

  final int score;
  final int bestScore;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HudCard(
              icon: Icons.timer_rounded,
              label: l10n.hudTime,
              value: '${score}s',
              color: const Color(0xFF22F3F8),
            ),
            _HudCard(
              icon: Icons.emoji_events_rounded,
              label: l10n.hudBest,
              value: '${bestScore}s',
              color: const Color(0xFFFFD700),
            ),
          ],
        ),
      ),
    );
  }
}

class _HudCard extends StatelessWidget {
  const _HudCard({
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
