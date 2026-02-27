part of '../choose_game_page.dart';

class _CountBadge extends BaseSubPage<ChooseGameBloc, ChooseGameEvent, ChooseGameState> {
  const _CountBadge();

  @override
  Widget builder(BuildContext context) {
    final count = context.read<ChooseGameBloc>().state.games.length;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.orangeEDD5,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: AppColors.orangeB347, width: 2),
        boxShadow: const [
          BoxShadow(color: AppColors.orangeA500, offset: Offset(0, 3), blurRadius: 0),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.gamepad_rounded, size: 16.r, color: AppColors.orange6600),
          SizedBox(width: 6.w),
          Text(
            '$count Games Available',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.orange6600,
              fontFamily: FontFamily.manrope,
            ),
          ),
        ],
      ),
    );
  }
}
