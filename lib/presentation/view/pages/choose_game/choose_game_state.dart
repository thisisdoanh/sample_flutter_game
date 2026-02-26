part of 'choose_game_bloc.dart';

@freezed
abstract class ChooseGameState extends BaseState with _$ChooseGameState {
  const factory ChooseGameState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _ChooseGameState;

  const ChooseGameState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}