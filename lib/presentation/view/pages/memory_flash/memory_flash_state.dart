part of 'memory_flash_bloc.dart';

@freezed
abstract class MemoryFlashState extends BaseState with _$MemoryFlashState {
  const factory MemoryFlashState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _MemoryFlashState;

  const MemoryFlashState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}