import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:template_bloc/l10n/app_localizations.dart';
import 'package:template_bloc/presentation/base/base_page.dart';
import 'package:template_bloc/shared/common/game_phase.dart';
import 'package:template_bloc/presentation/view/pages/balance_ball/balance_ball_bloc.dart';
import 'package:template_bloc/presentation/widgets/app_container.dart';
import 'package:template_bloc/presentation/widgets/game/game_background.dart';
import 'package:template_bloc/presentation/widgets/game/game_hud_card.dart';
import 'package:template_bloc/presentation/widgets/game/game_new_best_badge.dart';
import 'package:template_bloc/presentation/widgets/game/game_score_card.dart';
import 'package:template_bloc/shared/extension/text_style.dart';

part 'widget/game_canvas.dart';
part 'widget/game_hud.dart';
part 'widget/game_over_screen.dart';
part 'widget/game_start_screen.dart';

@RoutePage()
class BalanceBallPage extends BasePage<BalanceBallBloc, BalanceBallEvent, BalanceBallState> {
  const BalanceBallPage({super.key}) : super(screenName: 'BalanceBallPage');

  @override
  void onInitState(BuildContext context) {
    context.read<BalanceBallBloc>().add(const BalanceBallEvent.loadData());
    super.onInitState(context);
  }

  @override
  Widget builder(BuildContext context) {
    return AppContainer(
      child: Stack(
        children: [
          // ── Game canvas (only rebuilds on gamePhase change) ──────────────
          BlocBuilder<BalanceBallBloc, BalanceBallState>(
            buildWhen: (prev, curr) => prev.gamePhase != curr.gamePhase,
            builder: (context, state) => _GameCanvas(
              gamePhase: state.gamePhase,
              onScoreUpdate: (s) =>
                  context.read<BalanceBallBloc>().add(BalanceBallEvent.updateScore(score: s)),
              onGameOver: (s) =>
                  context.read<BalanceBallBloc>().add(BalanceBallEvent.gameOver(score: s)),
            ),
          ),

          // ── HUD (only shown while playing) ───────────────────────────────
          BlocBuilder<BalanceBallBloc, BalanceBallState>(
            buildWhen: (prev, curr) =>
                prev.score != curr.score ||
                prev.gamePhase != curr.gamePhase ||
                prev.bestScore != curr.bestScore,
            builder: (context, state) {
              if (state.gamePhase != GamePhase.playing) return const SizedBox();
              return _GameHud(score: state.score, bestScore: state.bestScore);
            },
          ),

          // ── Start screen ─────────────────────────────────────────────────
          BlocBuilder<BalanceBallBloc, BalanceBallState>(
            buildWhen: (prev, curr) =>
                prev.gamePhase != curr.gamePhase || prev.bestScore != curr.bestScore,
            builder: (context, state) {
              if (state.gamePhase != GamePhase.idle) return const SizedBox();
              return _GameStartScreen(
                bestScore: state.bestScore,
                onStart: () =>
                    context.read<BalanceBallBloc>().add(const BalanceBallEvent.startGame()),
              );
            },
          ),

          // ── Game over screen ─────────────────────────────────────────────
          BlocBuilder<BalanceBallBloc, BalanceBallState>(
            buildWhen: (prev, curr) => prev.gamePhase != curr.gamePhase,
            builder: (context, state) {
              if (state.gamePhase != GamePhase.gameOver) return const SizedBox();
              return _GameOverScreen(
                score: state.score,
                bestScore: state.bestScore,
                onRestart: () =>
                    context.read<BalanceBallBloc>().add(const BalanceBallEvent.restart()),
              );
            },
          ),

          // ── Back button ──────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16.r,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
