import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'quick_reaction_game_bloc.freezed.dart';
part 'quick_reaction_game_event.dart';
part 'quick_reaction_game_state.dart';

@injectable
class QuickReactionGameBloc extends BaseBloc<QuickReactionGameEvent, QuickReactionGameState> {
  QuickReactionGameBloc() : super(const QuickReactionGameState()) {
    on<QuickReactionGameEvent>((event, emit) async {
        try {
          switch(event) {
            case _LoadData():
              _handleEventLoadData(emit, event);
              break;
          }
        } catch(e,s) {
            handleError(emit, ErrorConverter.convert(e, s));
        }
    });
  }

  Future<void> _handleEventLoadData(Emitter<QuickReactionGameState> emit, _LoadData event) async {}
}