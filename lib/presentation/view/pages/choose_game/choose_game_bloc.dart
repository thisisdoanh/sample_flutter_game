import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/presentation/router/router.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'choose_game_bloc.freezed.dart';
part 'choose_game_event.dart';
part 'choose_game_state.dart';

@injectable
class ChooseGameBloc extends BaseBloc<ChooseGameEvent, ChooseGameState> {
  ChooseGameBloc(this._appRouter) : super(const ChooseGameState()) {
    on<ChooseGameEvent>((event, emit) async {
      try {
        switch (event) {
          case _LoadData():
            _handleEventLoadData(emit, event);
            break;
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  Future<void> _handleEventLoadData(Emitter<ChooseGameState> emit, _LoadData event) async {}

  final AppRouter _appRouter;
}
