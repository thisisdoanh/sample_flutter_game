part of '../choose_game_page.dart';

class _Header extends BaseSubPage<ChooseGameBloc, ChooseGameEvent, ChooseGameState> {
  @override
  Widget builder(BuildContext context) {
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
            'Pick a',
            style: TextStyle(
              fontSize: 38.sp,
              fontWeight: FontWeight.w900,
              color: AppColors.dark100,
              fontFamily: FontFamily.manrope,
              height: 1.1,
            ),
          ),

          // "Game!" — gradient accent
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => AppColors.warmLN.createShader(bounds),
            child: Text(
              'Game!',
              style: TextStyle(
                fontSize: 38.sp,
                fontWeight: FontWeight.w900,
                fontFamily: FontFamily.manrope,
                color: Colors.white, // overridden by ShaderMask
                height: 1.1,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Subtitle
          Text(
            'Choose your adventure & start playing',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.gray90A8,
              fontFamily: FontFamily.manrope,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),

          // Count badge
          const _CountBadge(),
        ],
      ),
    );
  }
}
