// fonts.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle primaryTextStyle = TextStyle(
    fontFamily: GoogleFonts.varelaRound().fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle secondaryTextStyle = TextStyle(
    fontFamily: GoogleFonts.openSans().fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
