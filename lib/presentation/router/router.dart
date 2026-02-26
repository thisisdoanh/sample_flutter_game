import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'package:template_bloc/presentation/view/pages/balance_ball/balance_ball_page.dart';
import 'package:template_bloc/presentation/view/pages/catch_the_button/catch_the_button_page.dart';
import 'package:template_bloc/presentation/view/pages/choose_game/choose_game_page.dart';
import 'package:template_bloc/presentation/view/pages/math_calculation/math_calculation_page.dart';
import 'package:template_bloc/presentation/view/pages/memory_card/memory_card_page.dart';
import 'package:template_bloc/presentation/view/pages/memory_flash/memory_flash_page.dart';
import 'package:template_bloc/presentation/view/pages/nfc_tap/nfc_tap_page.dart';
import 'package:template_bloc/presentation/view/pages/qr_code_hunt/qr_code_hunt_page.dart';
import 'package:template_bloc/presentation/view/pages/quick_reaction_game/quick_reaction_game_page.dart';
import 'package:template_bloc/presentation/view/pages/smile_detection/smile_detection_page.dart';
import 'package:template_bloc/presentation/view/pages/splash/splash_page.dart';
import 'package:template_bloc/presentation/view/pages/voice_challenge/voice_challenge_page.dart';

part 'router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page|Dialog|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: BalanceBallRoute.page),
    AutoRoute(page: CatchTheButtonRoute.page),
    AutoRoute(page: ChooseGameRoute.page),
    AutoRoute(page: MathCalculationRoute.page),
    AutoRoute(page: MemoryFlashRoute.page),
    AutoRoute(page: MemoryCardRoute.page),
    AutoRoute(page: NfcTapRoute.page),
    AutoRoute(page: QrCodeHuntRoute.page),
    AutoRoute(page: QuickReactionGameRoute.page),
    AutoRoute(page: SmileDetectionRoute.page),
    AutoRoute(page: VoiceChallengeRoute.page),
  ];
}
