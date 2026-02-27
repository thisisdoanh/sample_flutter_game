import 'package:flutter/material.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/base/base_state.dart';

abstract class BaseSubPage<B extends BaseBloc<E, S>, E, S extends BaseState>
    extends BasePage<B, E, S> {
  const BaseSubPage({super.key, super.screenName});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
