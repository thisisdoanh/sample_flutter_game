import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/math_calculation/math_calculation_bloc.dart';

@RoutePage()
class MathCalculationPage extends BasePage<MathCalculationBloc, MathCalculationEvent, MathCalculationState> {
  const MathCalculationPage({super.key}) : super(screenName: "MathCalculationPage");

  @override
  void onInitState(BuildContext context) {
    context.read<MathCalculationBloc>().add(const MathCalculationEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}