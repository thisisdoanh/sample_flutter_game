part of 'balance_ball_bloc.dart';

@freezed
sealed class BalanceBallEvent with _$BalanceBallEvent {
  const factory BalanceBallEvent.loadData() = _LoadData;
  const factory BalanceBallEvent.startGame() = _StartGame;
  const factory BalanceBallEvent.updateScore({required int score}) = _UpdateScore;
  const factory BalanceBallEvent.gameOver({required int score}) = _GameOver;
  const factory BalanceBallEvent.restart() = _Restart;
}
