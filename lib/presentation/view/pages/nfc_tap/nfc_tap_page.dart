import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/nfc_tap/nfc_tap_bloc.dart';

@RoutePage()
class NfcTapPage extends BasePage<NfcTapBloc, NfcTapEvent, NfcTapState> {
  const NfcTapPage({super.key}) : super(screenName: "NfcTapPage");

  @override
  void onInitState(BuildContext context) {
    context.read<NfcTapBloc>().add(const NfcTapEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}