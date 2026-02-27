import 'package:auto_route/auto_route.dart';
import 'package:bouncy_button/bouncy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_bloc/data/model/game_model.dart';
import 'package:template_bloc/domain/enums/game_route.dart';
import 'package:template_bloc/gen/fonts.gen.dart';
import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/base/base_sub_page.dart';
import 'package:template_bloc/presentation/resources/colors.dart';
import 'package:template_bloc/presentation/router/router.dart';
import 'package:template_bloc/presentation/view/pages/choose_game/choose_game_bloc.dart';
import 'package:template_bloc/presentation/widgets/app_container.dart';
import 'package:template_bloc/presentation/widgets/background_bubbles.dart';

part 'widget/count_badge.dart';
part 'widget/game_card.dart';
part 'widget/header.dart';

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

@RoutePage()
class ChooseGamePage extends BasePage<ChooseGameBloc, ChooseGameEvent, ChooseGameState> {
  const ChooseGamePage({super.key}) : super(screenName: 'ChooseGamePage');

  @override
  void onInitState(BuildContext context) {
    context.read<ChooseGameBloc>().add(const ChooseGameEvent.loadData());
    context.read<ChooseGameBloc>().add(const ChooseGameEvent.loadListGame());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return AppContainer(
      backgroundWidget: const BackgroundBubbles(),
      child: SafeArea(
        child: BlocBuilder<ChooseGameBloc, ChooseGameState>(
          builder: (context, state) {
            final games = state.games;
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _Header()),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 40.h),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => _GameCard(gameModel: games[index]),
                      childCount: games.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14.w,
                      mainAxisSpacing: 18.h,
                      mainAxisExtent: 200.h,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
