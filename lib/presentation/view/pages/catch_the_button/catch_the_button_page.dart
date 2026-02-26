import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/catch_the_button/catch_the_button_bloc.dart';

@RoutePage()
class CatchTheButtonPage extends BasePage<CatchTheButtonBloc, CatchTheButtonEvent, CatchTheButtonState> {
  const CatchTheButtonPage({super.key}) : super(screenName: "CatchTheButtonPage");

  @override
  void onInitState(BuildContext context) {
    context.read<CatchTheButtonBloc>().add(const CatchTheButtonEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}