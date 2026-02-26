import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/choose_game/choose_game_bloc.dart';

@RoutePage()
class ChooseGamePage extends BasePage<ChooseGameBloc, ChooseGameEvent, ChooseGameState> {
  const ChooseGamePage({super.key}) : super(screenName: "ChooseGamePage");

  @override
  void onInitState(BuildContext context) {
    context.read<ChooseGameBloc>().add(const ChooseGameEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}
