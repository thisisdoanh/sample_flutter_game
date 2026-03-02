part of 'catch_the_button_bloc.dart';

@freezed
abstract class CatchTheButtonState extends BaseState with _$CatchTheButtonState {
  const factory CatchTheButtonState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
    @Default(GamePhase.idle) GamePhase gamePhase,
    @Default(0) int score,
    @Default(0) int bestScore,
    @Default(30) int timeLeft,
  }) = _CatchTheButtonState;

  const CatchTheButtonState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}
