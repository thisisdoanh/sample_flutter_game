part of 'catch_the_button_bloc.dart';

@freezed
sealed class CatchTheButtonEvent with _$CatchTheButtonEvent {
  const factory CatchTheButtonEvent.loadData() = _LoadData;
  const factory CatchTheButtonEvent.startGame() = _StartGame;
  const factory CatchTheButtonEvent.tapButton() = _TapButton;
  const factory CatchTheButtonEvent.tick() = _Tick;
  const factory CatchTheButtonEvent.restart() = _Restart;
}
