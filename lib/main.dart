import 'package:flutter/material.dart';
import 'package:meteo_aquatech/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Météo',
      
      // Désactive la bannière debug
      debugShowCheckedModeBanner: false,

      // --- CONFIGURATION DE LA LANGUE ---
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), 
        Locale('fr'), 
      ],

      // --- PERSONNALISATION DU THÈME ---
      theme: ThemeData(
        // Active les composants visuels modernes de Google (Material 3)
        useMaterial3: true,
        
        // Applique la police "Montserrat" à l'ensemble de l'application via Google Fonts
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}