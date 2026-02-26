import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/quick_reaction_game/quick_reaction_game_bloc.dart';

@RoutePage()
class QuickReactionGamePage extends BasePage<QuickReactionGameBloc, QuickReactionGameEvent, QuickReactionGameState> {
  const QuickReactionGamePage({super.key}) : super(screenName: "QuickReactionGamePage");

  @override
  void onInitState(BuildContext context) {
    context.read<QuickReactionGameBloc>().add(const QuickReactionGameEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}