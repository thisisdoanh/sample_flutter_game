part of '../balance_ball_page.dart';

class _GameStartScreen extends StatelessWidget {
  const _GameStartScreen({required this.bestScore, required this.onStart});

  final int bestScore;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0D1B2A).withValues(alpha: 0.95),
            const Color(0xFF1A1A2E).withValues(alpha: 0.98),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ball icon
            Container(
              width: 90.r,
              height: 90.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  center: Alignment(-0.3, -0.4),
                  colors: [Color(0xFFFF8484), Color(0xFFFF5757), Color(0xFFE03030)],
                  stops: [0.0, 0.6, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5757).withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(Icons.sports_soccer, size: 44.r, color: Colors.white),
            ),
            SizedBox(height: 28.h),

            // Title (color overridden by ShaderMask)
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF22F3F8), Color(0xFF00A8CC)],
              ).createShader(bounds),
              child: Text(
                l10n.balanceBallTitle,
                style: kTextStyle.size(30.sp).black.withLetterSpacing(3),
              ),
            ),
            SizedBox(height: 10.h),

            Text(
              l10n.balanceBallDescription,
              textAlign: TextAlign.center,
              style: kTextStyle
                  .size(14.sp)
                  .withColor(Colors.white.withValues(alpha: 0.6))
                  .regular
                  .withHeight(1.6),
            ),
            SizedBox(height: 24.h),

            // Best score badge
            if (bestScore > 0)
              Container(
                margin: EdgeInsets.only(bottom: 24.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.emoji_events_rounded,
                        size: 18.r, color: const Color(0xFFFFD700)),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.bestScoreLabel(bestScore),
                      style: kTextStyle
                          .size(14.sp)
                          .withColor(const Color(0xFFFFD700))
                          .bold,
                    ),
                  ],
                ),
              ),

            // Start button
            GestureDetector(
              onTap: onStart,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 18.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF22F3F8), Color(0xFF00A8CC)],
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF22F3F8).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow_rounded, size: 24.r, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.startGame,
                      style: kTextStyle
                          .size(16.sp)
                          .withColor(Colors.white)
                          .black
                          .withLetterSpacing(2),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.screen_rotation_rounded,
                    size: 14.r, color: Colors.white.withValues(alpha: 0.35)),
                SizedBox(width: 6.w),
                Text(
                  l10n.gyroscopeControlled,
                  style: kTextStyle
                      .size(11.sp)
                      .withColor(Colors.white.withValues(alpha: 0.35))
                      .regular,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
