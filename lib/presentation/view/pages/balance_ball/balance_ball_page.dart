import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/balance_ball/balance_ball_bloc.dart';

@RoutePage()
class BalanceBallPage extends BasePage<BalanceBallBloc, BalanceBallEvent, BalanceBallState> {
  const BalanceBallPage({super.key}) : super(screenName: "BalanceBallPage");

  @override
  void onInitState(BuildContext context) {
    context.read<BalanceBallBloc>().add(const BalanceBallEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}