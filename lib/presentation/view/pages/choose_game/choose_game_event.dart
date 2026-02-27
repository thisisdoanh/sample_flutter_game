part of 'choose_game_bloc.dart';

@freezed
sealed class ChooseGameEvent with _$ChooseGameEvent {
  const factory ChooseGameEvent.loadData() = _LoadData;
  const factory ChooseGameEvent.loadListGame() = _LoadListGame;

}