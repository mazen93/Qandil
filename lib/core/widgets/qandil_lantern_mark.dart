import 'package:flutter/material.dart';

import 'qandil_logo.dart';

/// Adapter widget delegating to the official SVG-backed [QandilLogo] widget.
///
/// Supports both dark UI colorway (Ivory body + Lantern `#F2A93B` star) and
/// light UI colorway (Night `#0F2A2E` body + Lantern Deep `#D98A12` star).
class QandilLanternMark extends StatelessWidget {
  const QandilLanternMark({
    super.key,
    this.size = 36,
    this.forceDarkColorway,
  });

  final double size;
  final bool? forceDarkColorway;

  @override
  Widget build(BuildContext context) {
    final colorway = switch (forceDarkColorway) {
      true => QandilLogoColorway.onDark,
      false => QandilLogoColorway.onLight,
      null => QandilLogoColorway.auto,
    };

    return QandilLogo(
      height: size,
      colorway: colorway,
    );
  }
}
