import 'package:flutter/material.dart';
import 'package:jarrab/core/constant/app_image_asset.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width = 75, this.height = 75});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(12),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.onSurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(AppImageAsset.appLogo, fit: BoxFit.cover),
    );
  }
}
