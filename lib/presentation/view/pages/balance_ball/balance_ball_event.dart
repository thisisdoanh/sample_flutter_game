part of 'balance_ball_bloc.dart';

@freezed
sealed class BalanceBallEvent with _$BalanceBallEvent {
  const factory BalanceBallEvent.loadData() = _LoadData;
}