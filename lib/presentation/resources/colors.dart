import 'package:flutter/material.dart';

class AppColors {
  static Color primaryDefault = const Color(0xff1877F2);

  //success
  static Color successDefault = const Color(0xff00ba88);
  static Color successDark = const Color(0xff00966d);
  static Color successDarkmode = const Color(0xff34eab9);
  static Color successLight = const Color(0xfff2fffb);

  //error
  static Color errorDefault = const Color(0xffed2e7e);
  static Color errorDark = const Color(0xffc30052);
  static Color errorDarkmode = const Color(0xffff84b7);
  static Color errorLight = const Color(0xfffff3f8);

  //warning
  static Color warningDefault = const Color(0xfff4b740);
  static Color warningDark = const Color(0xff946220);
  static Color warningDarkmode = const Color(0xffffd789);

  //grayscale
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color titleActive = const Color(0xff050505);
  static Color disableInput = const Color(0xffeef1f4);
  static Color bodyText = const Color(0xff4e4b66);
  static Color placeHolder = const Color(0xffa0a3bd);
  static Color secondaryButton = const Color(0xffeef1f4);
  static Color buttonText = const Color(0xff667080);

  static Color bodyDarkmode = const Color(0xffB0B3B8);
  static Color inputBackground = const Color(0xff3A3B3C);
  static Color darkModeBackground = const Color(0xff1C1E21);
  static Color darkModeTitle = const Color(0xffE4E6EB);

  static LinearGradient primaryLN = const LinearGradient(
    begin: Alignment(0.06, 0.58),
    end: Alignment(1.00, 0.60),
    colors: [Color(0xFF22F2F7), Color(0xFF29F478)],
  );

  static LinearGradient warmLN = const LinearGradient(
    colors: [Color(0xFFFF5757), Color(0xFFFF9F1C)],
  );

  static const Color dark100 = Color(0xFF121212);
  static const Color dark200 = Color(0xFF3A3E4A);
  static const Color dark300 = Color(0xFF5C6370);
  static const Color dark400 = Color(0xFF868B92);
  static const Color dark500 = Color(0xFFBCC0C3);

  static const Color black1 = Color(0xFF333333);

  static const Color light100 = Color(0xFFFFFFFF);
  static const Color light200 = Color(0xFFEDEFF1);
  static const Color light300 = Color(0xFFDDE1E4);

  static const Color semanticRed50 = Color(0xFFFDDCDC);
  static const Color semanticRed100 = Color(0xFFF56363);
  static const Color semanticRed200 = Color(0xFFE92323);
  static const Color semanticBlue100 = Color(0xFF165AF9);
  static const Color semanticBlue200 = Color(0xFF474FEA);
  static const Color semanticGreen100 = Color(0xFF329218);

  static const Color mint100 = Color(0xFF329218);
  static const Color mint200 = Color(0xFFD5FDF1);
  static const Color mint300 = Color(0xFF22F3F8);
  static const Color mint400 = Color(0xFF087B77);

  static const Color transparent = Colors.transparent;

  // White / off-white
  static const Color white7D8 = Color(0xFFBEC7D8);
  static const Color white4C1 = Color(0xFFBCC4C1);
  static const Color whiteF8F0 = Color(0xFFFFF8F0);

  // Gray
  static const Color gray90A8 = Color(0xFF9590A8);

  // Black / very dark
  static const Color black21 = Color(0xFF212121);
  static const Color black1E = Color(0xFF1E1E1E);
  static const Color blackD23 = Color(0xFF1A1D23);
  static const Color black82 = Color(0xFF828282);
  static const Color black426 = Color(0xFF1F2426);
  static const Color black348 = Color(0xFF364348);

  // Yellow / gold
  static const Color yellowD700 = Color(0xFFFFD700);
  static const Color yellow9500 = Color(0xFFB89500);

  // Orange
  static const Color orange9F1C = Color(0xFFFF9F1C);
  static const Color orangeEDD5 = Color(0xFFFFEDD5);
  static const Color orangeB347 = Color(0xFFFFB347);
  static const Color orangeA500 = Color(0xFFF5A500);
  static const Color orange6600 = Color(0xFFCC6600);
  static const Color orange7500 = Color(0xFFE87500);
  static const Color orange4E00 = Color(0xFFA84E00);

  // Red
  static const Color red5757 = Color(0xFFFF5757);
  static const Color red6D6 = Color(0xFFF6D6D6);
  static const Color red323 = Color(0xFFE92323);
  static const Color red030 = Color(0xFFF13030);
  static const Color red484 = Color(0xFFFF8484);
  static const Color red450 = Color(0xFF450000);
  static const Color redC0C = Color(0xFF6C0C0C);
  static const Color redD4D = Color(0xFFFF4D4D);
  static const Color red3030 = Color(0xFFC23030);
  static const Color red4500 = Color(0xFFFF4500);
  static const Color red2800 = Color(0xFFBD2800);

  // Pink
  static const Color pink177B = Color(0xFFE5177B);
  static const Color pink0D55 = Color(0xFFA00D55);

  // Purple
  static const Color purple5DE5 = Color(0xFF9B5DE5);
  static const Color purple2EB3 = Color(0xFF6A2EB3);
  static const Color purple2FBE = Color(0xFF7B2FBE);
  static const Color purple0FA3 = Color(0xFF520FA3);

  // Blue
  static const Color blueCFB = Color(0xFFD7FCFB);
  static const Color blue7DC = Color(0xFF0CD7DC);
  static const Color blueAF6 = Color(0xFFD6DAF6);
  static const Color blue2FD = Color(0xFF26B2FD);
  static const Color blue3DC = Color(0xFF0163DC);
  static const Color blue7FF = Color(0xFF7CB7FF);
  static const Color blueA8CC = Color(0xFF00A8CC);
  static const Color blue86FF = Color(0xFF3A86FF);
  static const Color blue5CE8 = Color(0xFF1A5CE8);

  // Teal
  static const Color teal6F88 = Color(0xFF006F88);

  // Green
  static const Color greenD6A0 = Color(0xFF06D6A0);
  static const Color green789 = Color(0xFF22F789);
  static const Color greenBD5 = Color(0xFFB2FBD5);
  static const Color green82A = Color(0xFF00782A);
  static const Color green54B = Color(0xFF00B54B);
  static const Color green92A = Color(0xFF00292A);
  static const Color greenEED = Color(0xFFE1FEED);
  static const Color greenAA6 = Color(0xFF6CFAA6);
  static const Color greenAB76 = Color(0xFF0DAB76);
  static const Color green7050 = Color(0xFF097050);
  static const Color green9870 = Color(0xFF039870);
}
