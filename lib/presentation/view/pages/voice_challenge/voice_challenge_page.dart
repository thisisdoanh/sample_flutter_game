import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/presentation/view/pages/voice_challenge/voice_challenge_bloc.dart';

@RoutePage()
class VoiceChallengePage extends BasePage<VoiceChallengeBloc, VoiceChallengeEvent, VoiceChallengeState> {
  const VoiceChallengePage({super.key}) : super(screenName: "VoiceChallengePage");

  @override
  void onInitState(BuildContext context) {
    context.read<VoiceChallengeBloc>().add(const VoiceChallengeEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return const SizedBox();
  }
}