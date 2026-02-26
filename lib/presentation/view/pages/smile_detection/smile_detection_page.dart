import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/smile_detection/smile_detection_bloc.dart';

@RoutePage()
class SmileDetectionPage extends BasePage<SmileDetectionBloc, SmileDetectionEvent, SmileDetectionState> {
  const SmileDetectionPage({super.key}) : super(screenName: "SmileDetectionPage");

  @override
  void onInitState(BuildContext context) {
    context.read<SmileDetectionBloc>().add(const SmileDetectionEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}