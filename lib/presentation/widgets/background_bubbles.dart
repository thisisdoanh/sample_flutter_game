import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_bloc/presentation/resources/colors.dart';

class BackgroundBubbles extends StatelessWidget {
  const BackgroundBubbles({super.key, this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(color: backgroundColor ?? AppColors.whiteF8F0),
          ),
        ),
        // Top-right large bubble
        Positioned(
          top: -50.r,
          right: -40.r,
          child: Container(
            width: 180.r,
            height: 180.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.red5757.withValues(alpha: 0.12),
            ),
          ),
        ),
        // Top-right inner bubble
        Positioned(
          top: 20.r,
          right: 20.r,
          child: Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.orange9F1C.withValues(alpha: 0.15),
            ),
          ),
        ),
        // Bottom-left large bubble
        Positioned(
          bottom: 60.r,
          left: -60.r,
          child: Container(
            width: 200.r,
            height: 200.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.purple5DE5.withValues(alpha: 0.10),
            ),
          ),
        ),
        // Bottom-right accent
        Positioned(
          bottom: 100.r,
          right: -20.r,
          child: Container(
            width: 100.r,
            height: 100.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blueA8CC.withValues(alpha: 0.12),
            ),
          ),
        ),
        // Mid-left small dot
        Positioned(
          top: 280.r,
          left: 10.r,
          child: Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greenD6A0.withValues(alpha: 0.18),
            ),
          ),
        ),
      ],
    );
  }
}
