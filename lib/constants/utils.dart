import 'package:flutter/material.dart';

final Color preventiveColor = Color.fromRGBO(42, 157, 143, 1);
final Color preventiveColorLighter = Color.fromRGBO(42, 157, 143, 0.25);
final Color curativeColor = Color.fromRGBO(57, 126, 245, 1);
final Color curativeColorLighter = Color.fromRGBO(57, 126, 245, .25);

Color getInterventionColor(intervention, {bool lighter = false}) {
  if (intervention == 'preventive') {
    return lighter == true ? preventiveColorLighter : preventiveColor;
  } else {
    return lighter == true ? curativeColorLighter : curativeColor;
  }
}

// void showStep({required bool step1, required bool step2, }) {
//       step1 = !step1;
//       step2 = !step2;
// }
// Color getInterventionColor(intervention, {bool lighter = false}) {
//   if (intervention['type'] == 'preventive') {
//     return lighter == true ? preventiveColorLighter : preventiveColor;
//   } else {
//     return lighter == true ? curativeColorLighter : curativeColor;
//   }
// }

extension StringCasingExtension on String {
  String capitalize() => this.length > 0
      ? '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}'
      : '';

  String studly() => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.capitalize())
      .join(" ");
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
