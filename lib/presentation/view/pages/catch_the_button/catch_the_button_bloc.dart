import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/data/pref/pref_store.dart';
import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/shared/common/error_converter.dart';
import 'package:template_bloc/shared/common/game_phase.dart';

part 'catch_the_button_bloc.freezed.dart';
part 'catch_the_button_event.dart';
part 'catch_the_button_state.dart';

// Tổng số giây mỗi ván chơi
const _kGameDuration = 30;

@injectable
class CatchTheButtonBloc extends BaseBloc<CatchTheButtonEvent, CatchTheButtonState> {
  CatchTheButtonBloc(this._pref) : super(const CatchTheButtonState()) {
    on<CatchTheButtonEvent>((event, emit) async {
      try {
        switch (event) {
          case _LoadData():
            emit(state.copyWith(bestScore: _pref.getCatchTheButtonBestScore()));
            break;
          case _StartGame():
            _cancelTimer();
            emit(state.copyWith(gamePhase: GamePhase.playing, score: 0, timeLeft: _kGameDuration));
            _startTimer();
            break;
          case _TapButton():
            if (state.gamePhase != GamePhase.playing) break;
            emit(state.copyWith(score: state.score + 1));
            break;
          case _Tick():
            if (state.gamePhase != GamePhase.playing) break;
            final newTime = state.timeLeft - 1;
            if (newTime <= 0) {
              _cancelTimer();
              final best =
                  state.score > state.bestScore ? state.score : state.bestScore;
              if (best > state.bestScore) {
                await _pref.saveCatchTheButtonBestScore(best);
              }
              emit(state.copyWith(
                gamePhase: GamePhase.gameOver,
                timeLeft: 0,
                bestScore: best,
              ));
            } else {
              emit(state.copyWith(timeLeft: newTime));
            }
            break;
          case _Restart():
            _cancelTimer();
            emit(state.copyWith(gamePhase: GamePhase.idle));
            break;
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  final PrefStore _pref;
  Timer? _gameTimer;

  void _startTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const CatchTheButtonEvent.tick());
    });
  }

  void _cancelTimer() {
    _gameTimer?.cancel();
    _gameTimer = null;
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}
