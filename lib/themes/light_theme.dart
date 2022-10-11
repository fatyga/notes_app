import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get lightTheme => ThemeData.light().copyWith(
    useMaterial3: true,
    textTheme: GoogleFonts.robotoTextTheme(),
    tabBarTheme: const TabBarTheme(labelColor: Colors.black));
