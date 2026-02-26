part of 'voice_challenge_bloc.dart';

@freezed
abstract class VoiceChallengeState extends BaseState with _$VoiceChallengeState {
  const factory VoiceChallengeState({
    @Default(PageStatus.Loaded) PageStatus pageStatus,
    String? pageErrorMessage,
  }) = _VoiceChallengeState;

  const VoiceChallengeState._({
    super.pageStatus = PageStatus.Loaded,
    super.pageErrorMessage,
  });
}