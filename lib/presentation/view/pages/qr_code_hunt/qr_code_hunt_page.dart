import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/qr_code_hunt/qr_code_hunt_bloc.dart';

@RoutePage()
class QrCodeHuntPage extends BasePage<QrCodeHuntBloc, QrCodeHuntEvent, QrCodeHuntState> {
  const QrCodeHuntPage({super.key}) : super(screenName: "QrCodeHuntPage");

  @override
  void onInitState(BuildContext context) {
    context.read<QrCodeHuntBloc>().add(const QrCodeHuntEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}