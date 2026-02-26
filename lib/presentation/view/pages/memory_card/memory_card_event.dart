part of 'memory_card_bloc.dart';

@freezed
sealed class MemoryCardEvent with _$MemoryCardEvent {
  const factory MemoryCardEvent.loadData() = _LoadData;
}