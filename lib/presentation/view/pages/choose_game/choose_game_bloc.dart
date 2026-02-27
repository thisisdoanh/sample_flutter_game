import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:template_bloc/data/model/game_model.dart';
import 'package:template_bloc/domain/enums/game_route.dart';

import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/presentation/resources/colors.dart';
import 'package:template_bloc/shared/common/error_converter.dart';

part 'choose_game_bloc.freezed.dart';
part 'choose_game_event.dart';
part 'choose_game_state.dart';

@injectable
class ChooseGameBloc extends BaseBloc<ChooseGameEvent, ChooseGameState> {
  ChooseGameBloc() : super(const ChooseGameState()) {
    on<ChooseGameEvent>((event, emit) async {
      try {
        switch (event) {
          case _LoadData():
            _handleEventLoadData(emit, event);
            break;
          case _LoadListGame():
            _handleLoadListGame(emit, event);
            break;
        }
      } catch (e, s) {
        handleError(emit, ErrorConverter.convert(e, s));
      }
    });
  }

  Future<void> _handleEventLoadData(Emitter<ChooseGameState> emit, _LoadData event) async {}

  Future<void> _handleLoadListGame(Emitter<ChooseGameState> emit, _LoadListGame event) async {
    const list = [
      GameModel(
        name: 'Balance Ball',
        description: 'Keep it\nsteady!',
        icon: Icons.sports_soccer,
        cardColor: AppColors.red5757,
        shadowColor: AppColors.red3030,
        targetRoute: GameRoute.balanceBall,
      ),
      GameModel(
        name: 'Catch Button',
        description: 'Tap before\nit escapes!',
        icon: Icons.touch_app,
        cardColor: AppColors.orange7500,
        shadowColor: AppColors.orange4E00,
        targetRoute: GameRoute.catchButton,
      ),
      GameModel(
        name: 'Math Challenge',
        description: 'Solve it\nsuper fast!',
        icon: Icons.calculate,
        cardColor: AppColors.purple5DE5,
        shadowColor: AppColors.purple2EB3,
        targetRoute: GameRoute.mathChallenge,
      ),
      GameModel(
        name: 'Memory Flash',
        description: 'Remember\nthe sequence!',
        icon: Icons.flash_on,
        cardColor: AppColors.blueA8CC,
        shadowColor: AppColors.teal6F88,
        targetRoute: GameRoute.memoryFlash,
      ),
      GameModel(
        name: 'Memory Card',
        description: 'Match all\nthe pairs!',
        icon: Icons.style,
        cardColor: AppColors.greenAB76,
        shadowColor: AppColors.green7050,
        targetRoute: GameRoute.memoryCard,
      ),
      GameModel(
        name: 'NFC Tap',
        description: 'Tap tags\nto score!',
        icon: Icons.nfc,
        cardColor: AppColors.pink177B,
        shadowColor: AppColors.pink0D55,
        targetRoute: GameRoute.nfcTap,
      ),
      GameModel(
        name: 'QR Hunt',
        description: 'Scan codes\nto win!',
        icon: Icons.qr_code_scanner,
        cardColor: AppColors.blue86FF,
        shadowColor: AppColors.blue5CE8,
        targetRoute: GameRoute.qrHunt,
      ),
      GameModel(
        name: 'Quick Reaction',
        description: 'Test your\nreflexes!',
        icon: Icons.bolt,
        cardColor: AppColors.red4500,
        shadowColor: AppColors.red2800,
        targetRoute: GameRoute.quickReaction,
      ),
      GameModel(
        name: 'Smile Detection',
        description: 'Smile your\nway to win!',
        icon: Icons.face,
        cardColor: AppColors.greenD6A0,
        shadowColor: AppColors.green9870,
        targetRoute: GameRoute.smileDetection,
      ),
      GameModel(
        name: 'Voice Challenge',
        description: 'Use your\nvoice!',
        icon: Icons.mic,
        cardColor: AppColors.purple2FBE,
        shadowColor: AppColors.purple0FA3,
        targetRoute: GameRoute.voiceChallenge,
      ),
    ];
    emit(state.copyWith(games: list));
  }
}
