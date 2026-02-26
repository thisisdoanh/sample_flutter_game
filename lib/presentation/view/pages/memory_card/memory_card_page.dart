import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/memory_card/memory_card_bloc.dart';

@RoutePage()
class MemoryCardPage extends BasePage<MemoryCardBloc, MemoryCardEvent, MemoryCardState> {
  const MemoryCardPage({super.key}) : super(screenName: "MemoryCardPage");

  @override
  void onInitState(BuildContext context) {
    context.read<MemoryCardBloc>().add(const MemoryCardEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}