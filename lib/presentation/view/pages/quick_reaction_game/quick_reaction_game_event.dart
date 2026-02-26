part of 'quick_reaction_game_bloc.dart';

@freezed
sealed class QuickReactionGameEvent with _$QuickReactionGameEvent {
  const factory QuickReactionGameEvent.loadData() = _LoadData;
}