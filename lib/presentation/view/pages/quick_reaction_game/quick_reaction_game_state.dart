part of 'quick_reaction_game_bloc.dart';

@freezed
abstract class QuickReactionGameState extends BaseState with _$QuickReactionGameState {
  const factory QuickReactionGameState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _QuickReactionGameState;

  const QuickReactionGameState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}