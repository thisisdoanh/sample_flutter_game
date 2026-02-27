part of '../choose_game_page.dart';

class _GameCard extends BaseSubPage<ChooseGameBloc, ChooseGameEvent, ChooseGameState> {
  const _GameCard({required this.gameModel});
  final GameModel gameModel;

  @override
  Widget builder(BuildContext context) {
    return BouncyButton.primary(
      onPressed: () {
        _navigateToGame(context, gameModel.targetRoute);
      },
      interaction: const BouncyButtonInteraction(
        enableHapticFeedback: true,
        hapticFeedbackType: HapticFeedbackType.vibrate,
      ),
      style: BouncyButtonStyle(
        height: 190.h,
        backgroundColor: gameModel.cardColor,
        borderRadius: BorderRadius.circular(24.r),
        shadowColor: gameModel.shadowColor,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container (frosted white circle)
          Container(
            width: 58.r,
            height: 58.r,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.28),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
            ),
            child: Icon(gameModel.icon, size: 30.r, color: Colors.white),
          ),
          SizedBox(height: 12.h),

          // Game name
          Text(
            gameModel.name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontFamily: FontFamily.manrope,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.h),

          // Description
          Text(
            gameModel.description,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white.withValues(alpha: 0.82),
              fontFamily: FontFamily.manrope,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),

          // Play pill
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PLAY',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: FontFamily.manrope,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(width: 3.w),
                Icon(Icons.arrow_forward_ios_rounded, size: 8.r, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToGame(BuildContext context, GameRoute targetRoute) {
    final route = switch (targetRoute) {
      GameRoute.balanceBall => const BalanceBallRoute(),
      GameRoute.catchButton => const CatchTheButtonRoute(),
      GameRoute.mathChallenge => const MathCalculationRoute(),
      GameRoute.memoryFlash => const MemoryFlashRoute(),
      GameRoute.memoryCard => const MemoryCardRoute(),
      GameRoute.nfcTap => const NfcTapRoute(),
      GameRoute.qrHunt => const QrCodeHuntRoute(),
      GameRoute.quickReaction => const QuickReactionGameRoute(),
      GameRoute.smileDetection => const SmileDetectionRoute(),
      GameRoute.voiceChallenge => const VoiceChallengeRoute(),
    };
    context.router.push(route);
  }
}
