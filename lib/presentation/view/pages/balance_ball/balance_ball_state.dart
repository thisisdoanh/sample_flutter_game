part of 'balance_ball_bloc.dart';

@freezed
abstract class BalanceBallState extends BaseState with _$BalanceBallState {
  const factory BalanceBallState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _BalanceBallState;

  const BalanceBallState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}