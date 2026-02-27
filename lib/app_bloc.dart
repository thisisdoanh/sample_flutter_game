import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:template_bloc/data/model/game_model.dart';

import 'package:template_bloc/di/di.dart';
import 'package:template_bloc/domain/enums/language.dart';
import 'package:template_bloc/domain/usecases/toogle_app_theme_use_case.dart';
import 'package:template_bloc/presentation/base/base_bloc.dart';
import 'package:template_bloc/presentation/base/base_state.dart';
import 'package:template_bloc/presentation/base/page_status.dart';
import 'package:template_bloc/domain/enums/game_route.dart';
import 'package:template_bloc/presentation/resources/colors.dart';
import 'package:template_bloc/shared/utils/share_preference_utils.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

@singleton
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc(this._toggleThemeUseCase) : super(const AppState()) {
    on<AppEvent>((event, emit) async {
      switch (event) {
        case _LoadData():
          final isDark = getIt<PreferenceUtils>().getBool('isDark') ?? false;
          emit(state.copyWith(mode: isDark ? ThemeMode.dark : ThemeMode.light));
          break;
        case _ChangeAppLanguage():
          final Language? language = event.language;
          if (language != null) {
            emit(state.copyWith(currentLanguage: language));
          }
          break;
        case _ToggleAppTheme():
          final isDark = await _toggleThemeUseCase.call(params: ToggleAppThemeParam());
          emit(state.copyWith(mode: isDark ? ThemeMode.dark : ThemeMode.light));
          break;
        case _LoadListGame():
          _handleLoadListGame(emit, event);
          break;
      }
    });
  }

  Future<void> _handleLoadListGame(Emitter<AppState> emit, _LoadListGame event) async {
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

  final ToggleAppThemeUseCase _toggleThemeUseCase;

  int deviceAPILevel = 0;
  bool isFirstOpenApp = true;
}
