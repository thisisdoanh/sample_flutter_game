import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/data/pref/pref_store.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'balance_ball_bloc.freezed.dart';
part 'balance_ball_event.dart';
part 'balance_ball_state.dart';

@injectable
class BalanceBallBloc extends BaseBloc<BalanceBallEvent, BalanceBallState> {
  BalanceBallBloc(this._pref) : super(const BalanceBallState()) {
    on<BalanceBallEvent>((event, emit) async {
      try {
        switch (event) {
          case _LoadData():
            emit(state.copyWith(bestScore: _pref.getBalanceBallBestScore()));
            break;
          case _StartGame():
            emit(state.copyWith(gamePhase: GamePhase.playing, score: 0));
            break;
          case _UpdateScore():
            emit(state.copyWith(score: event.score));
            break;
          case _GameOver():
            final best = event.score > state.bestScore ? event.score : state.bestScore;
            if (best > state.bestScore) {
              await _pref.saveBalanceBallBestScore(best);
            }
            emit(
              state.copyWith(gamePhase: GamePhase.gameOver, score: event.score, bestScore: best),
            );
            break;
          case _Restart():
            emit(state.copyWith(gamePhase: GamePhase.idle));
            break;
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  final PrefStore _pref;
}
