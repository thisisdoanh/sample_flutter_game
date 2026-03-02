part of '../choose_game_page.dart';

class _Header extends BaseSubPage<ChooseGameBloc, ChooseGameEvent, ChooseGameState> {
  @override
  Widget builder(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trophy badge
          Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(
              color: AppColors.yellowD700,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.yellowD700.withValues(alpha: 0.45),
                  blurRadius: 18,
                  offset: const Offset(0, 5),
                ),
                const BoxShadow(color: AppColors.yellow9500, offset: Offset(0, 5), blurRadius: 0),
              ],
            ),
            child: Icon(Icons.emoji_events_rounded, color: Colors.white, size: 28.r),
          ),
          SizedBox(height: 16.h),

          // "Pick a"
          Text(
            l10n.pickA,
            style: kTextStyle
                .size(38.sp)
                .withColor(AppColors.dark100)
                .black
                .withHeight(1.1),
          ),

          // "Game!" — color overridden by ShaderMask
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => AppColors.warmLN.createShader(bounds),
            child: Text(
              l10n.gameExclamation,
              style: kTextStyle.size(38.sp).black.withHeight(1.1),
            ),
          ),
          SizedBox(height: 8.h),

          // Subtitle
          Text(
            l10n.chooseAdventure,
            style: kTextStyle.size(14.sp).withColor(AppColors.gray90A8).medium,
          ),
          SizedBox(height: 16.h),

          // Count badge
          const _CountBadge(),
        ],
      ),
    );
  }
}
