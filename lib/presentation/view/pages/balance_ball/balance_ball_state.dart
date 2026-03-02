part of 'balance_ball_bloc.dart';

enum GamePhase { idle, playing, gameOver }

@freezed
abstract class BalanceBallState extends BaseState with _$BalanceBallState {
  const factory BalanceBallState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
    @Default(GamePhase.idle) GamePhase gamePhase,
    @Default(0) int score,
    @Default(0) int bestScore,
  }) = _BalanceBallState;

  const BalanceBallState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}
