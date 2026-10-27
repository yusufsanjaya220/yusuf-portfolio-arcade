import 'package:flutter/material.dart';

enum AppLanguage { id, en }

class LocaleController extends ChangeNotifier {
  static final LocaleController instance = LocaleController._internal();
  LocaleController._internal();

  AppLanguage _currentLanguage = AppLanguage.id;

  AppLanguage get language => _currentLanguage;
  bool get isId => _currentLanguage == AppLanguage.id;

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == AppLanguage.id ? AppLanguage.en : AppLanguage.id;
    notifyListeners();
  }

  void setLanguage(AppLanguage lang) {
    if (_currentLanguage != lang) {
      _currentLanguage = lang;
      notifyListeners();
    }
  }

  // Common UI labels
  String get navHome => isId ? "START" : "START";
  String get navAbout => isId ? "PLAYER PROFILE" : "PLAYER PROFILE";
  String get navExperience => isId ? "QUEST LOG" : "QUEST LOG";
  String get navSkills => isId ? "SKILL TREE" : "SKILL TREE";
  String get navCertifications => isId ? "ACHIEVEMENTS" : "ACHIEVEMENTS";
  String get navContact => isId ? "CONTINUE?" : "CONTINUE?";

  String get pressStart => isId ? "PRESS START" : "PRESS START";
  String get viewProfile => isId ? "LIHAT PROFIL" : "VIEW PROFILE";
  String get playMiniGame => isId ? "MAINKAN GAME" : "PLAY MINI GAME";
  String get downloadCv => isId ? "UNDUH CV (PDF)" : "DOWNLOAD CV (PDF)";
  String get copyEmail => isId ? "SALIN EMAIL" : "COPY EMAIL";
  String get emailCopied => isId ? "Email Berhasil Disalin!" : "Email Copied to Clipboard!";
  String get verifyCredential => isId ? "VERIFIKASI" : "VERIFY";
  String get close => isId ? "TUTUP" : "CLOSE";
  String get sound => isId ? "SUARA" : "SOUND";
  String get soundOn => isId ? "ON" : "ON";
  String get soundOff => isId ? "MUTE" : "MUTE";
  String get score => isId ? "SKOR" : "SCORE";
  String get highScore => isId ? "SKOR TERTINGGI" : "HIGH SCORE";
  String get wave => isId ? "GELOMBANG" : "WAVE";
  String get lives => isId ? "NYAWA" : "LIVES";
  String get pause => isId ? "JEDA" : "PAUSE";
  String get resume => isId ? "LANJUT" : "RESUME";
  String get restart => isId ? "MAIN LAGI" : "PLAY AGAIN";
  String get backToProfile => isId ? "KEMBALI KE PROFIL" : "BACK TO PROFILE";
  String get exitGame => isId ? "KELUAR GAME" : "EXIT GAME";
  String get openForOpportunities => isId ? "TERBUKA UNTUK PELUANG" : "OPEN FOR OPPORTUNITIES";
}
