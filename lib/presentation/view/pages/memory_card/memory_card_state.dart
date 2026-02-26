part of 'memory_card_bloc.dart';

@freezed
abstract class MemoryCardState extends BaseState with _$MemoryCardState {
  const factory MemoryCardState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _MemoryCardState;

  const MemoryCardState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}