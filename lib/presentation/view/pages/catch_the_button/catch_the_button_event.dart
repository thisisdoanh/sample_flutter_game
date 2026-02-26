part of 'catch_the_button_bloc.dart';

@freezed
sealed class CatchTheButtonEvent with _$CatchTheButtonEvent {
  const factory CatchTheButtonEvent.loadData() = _LoadData;
}