part of 'voice_challenge_bloc.dart';

@freezed
sealed class VoiceChallengeEvent with _$VoiceChallengeEvent {
  const factory VoiceChallengeEvent.loadData() = _LoadData;
}