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
            GameHudCard(
              icon: Icons.timer_rounded,
              label: l10n.hudTime,
              value: '${score}s',
              color: const Color(0xFF22F3F8),
            ),
            GameHudCard(
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
