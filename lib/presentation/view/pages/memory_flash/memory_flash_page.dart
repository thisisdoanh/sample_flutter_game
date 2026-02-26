import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/memory_flash/memory_flash_bloc.dart';

@RoutePage()
class MemoryFlashPage extends BasePage<MemoryFlashBloc, MemoryFlashEvent, MemoryFlashState> {
  const MemoryFlashPage({super.key}) : super(screenName: "MemoryFlashPage");

  @override
  void onInitState(BuildContext context) {
    context.read<MemoryFlashBloc>().add(const MemoryFlashEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}