part of 'memory_flash_bloc.dart';

@freezed
sealed class MemoryFlashEvent with _$MemoryFlashEvent {
  const factory MemoryFlashEvent.loadData() = _LoadData;
}