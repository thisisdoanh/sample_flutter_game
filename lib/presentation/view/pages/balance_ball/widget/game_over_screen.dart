part of '../balance_ball_page.dart';

class _GameOverScreen extends StatelessWidget {
  const _GameOverScreen({required this.score, required this.bestScore, required this.onRestart});

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
                // Icon
                Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFF5757).withValues(alpha: 0.15),
                    border: Border.all(
                      color: const Color(0xFFFF5757).withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Icon(Icons.sports_soccer, size: 38.r, color: const Color(0xFFFF5757)),
                ),
                SizedBox(height: 20.h),

                Text(
                  l10n.gameOverTitle,
                  style: kTextStyle.size(28.sp).withColor(Colors.white).black.withLetterSpacing(3),
                ),
                SizedBox(height: 6.h),
                Text(
                  l10n.gameOverSubtitle,
                  style: kTextStyle
                      .size(13.sp)
                      .withColor(Colors.white.withValues(alpha: 0.5))
                      .regular,
                ),
                SizedBox(height: 32.h),

                // Score cards
                Row(
                  children: [
                    Expanded(
                      child: GameScoreCard(
                        label: l10n.scoreYourTime,
                        value: '${score}s',
                        color: const Color(0xFF22F3F8),
                        icon: Icons.timer_rounded,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GameScoreCard(
                        label: l10n.hudBest,
                        value: '${bestScore}s',
                        color: const Color(0xFFFFD700),
                        icon: Icons.emoji_events_rounded,
                      ),
                    ),
                  ],
                ),

                if (_isNewBest) ...[
                  SizedBox(height: 16.h),
                  const GameNewBestBadge(),
                ],

                SizedBox(height: 32.h),

                // Play again button
                GestureDetector(
                  onTap: onRestart,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF22F3F8), Color(0xFF00A8CC)],
                      ),
                      borderRadius: BorderRadius.circular(100.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF22F3F8).withValues(alpha: 0.35),
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
