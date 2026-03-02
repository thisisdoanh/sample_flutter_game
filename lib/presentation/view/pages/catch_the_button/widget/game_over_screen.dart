part of '../catch_the_button_page.dart';

class _GameOverScreen extends StatelessWidget {
  const _GameOverScreen({
    required this.score,
    required this.bestScore,
    required this.onRestart,
  });

  final int score;
  final int bestScore;
  final VoidCallback onRestart;

  bool get _isNewBest => score >= bestScore && score > 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      color: Colors.black.withValues(alpha: 0.82),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Icon ───────────────────────────────────────────────────────
                Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF9B5DE5).withValues(alpha: 0.15),
                    border: Border.all(
                      color: const Color(0xFF9B5DE5).withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.touch_app_rounded, size: 38.r, color: const Color(0xFF9B5DE5)),
                ),
                SizedBox(height: 20.h),

                Text(
                  l10n.gameOverTitle,
                  style: kTextStyle.size(28.sp).withColor(Colors.white).black.withLetterSpacing(3),
                ),
                SizedBox(height: 6.h),
                Text(
                  l10n.catchGameOverSubtitle,
                  style: kTextStyle
                      .size(13.sp)
                      .withColor(Colors.white.withValues(alpha: 0.5))
                      .regular,
                ),
                SizedBox(height: 32.h),

                // ── Score cards ─────────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _ScoreCard(
                        label: l10n.scoreYourTaps,
                        value: '$score',
                        color: const Color(0xFF9B5DE5),
                        icon: Icons.touch_app_rounded,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _ScoreCard(
                        label: l10n.hudBest,
                        value: '$bestScore',
                        color: const Color(0xFFFFD700),
                        icon: Icons.emoji_events_rounded,
                      ),
                    ),
                  ],
                ),

                if (_isNewBest) ...[
                  SizedBox(height: 16.h),
                  Container(
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
                  ),
                ],

                SizedBox(height: 32.h),

                // ── Play again button ────────────────────────────────────────────
                GestureDetector(
                  onTap: onRestart,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9B5DE5), Color(0xFFE040FB)],
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9B5DE5).withValues(alpha: 0.4),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.replay_rounded, size: 22.r, color: Colors.white),
                        SizedBox(width: 10.w),
                        Text(
                          l10n.playAgain,
                          style: kTextStyle
                              .size(16.sp)
                              .withColor(Colors.white)
                              .black
                              .withLetterSpacing(1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

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
          Text(value, style: kTextStyle.size(28.sp).withColor(color).black),
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
