import 'package:flutter/material.dart';

enum AppLanguage { fr, en }

class AppLocalizations extends ChangeNotifier {
  AppLocalizations({this.language = AppLanguage.fr});

  AppLanguage language;

  void setLanguage(AppLanguage newLanguage) {
    if (newLanguage == language) return;
    language = newLanguage;
    notifyListeners();
  }

  String get(String key) => _values[language]?[key] ?? key;

  static const Map<AppLanguage, Map<String, String>> _values = {
    AppLanguage.fr: {
      'appTitle': 'Batismart Devis',
      'authTitle': 'Connexion',
      'email': 'Email',
      'password': 'Mot de passe',
      'signIn': 'Se connecter',
      'companyProfile': 'Profil entreprise',
      'companyName': 'Nom société',
      'address': 'Adresse',
      'contact': 'Contact',
      'currency': 'Devise',
      'quoteBuilder': 'Création de devis',
      'saveDraft': 'Sauvegarder le brouillon',
      'exportPdf': 'Exporter PDF',
      'generalInfo': 'Informations générales',
      'clientInfo': 'Informations client',
      'projectInfo': 'Informations projet',
      'technicalDescription': 'Description technique',
      'dqe': 'D.Q.E. (Quantitatif)',
      'qualitative': 'Devis qualitatif',
      'planning': 'Planning & Méthodologie',
      'financialSummary': 'Résumé financier',
      'conditions': 'Conditions générales',
    },
    AppLanguage.en: {
      'appTitle': 'Batismart Quote',
      'authTitle': 'Sign in',
      'email': 'Email',
      'password': 'Password',
      'signIn': 'Sign in',
      'companyProfile': 'Company profile',
      'companyName': 'Company name',
      'address': 'Address',
      'contact': 'Contact',
      'currency': 'Currency',
      'quoteBuilder': 'Quote builder',
      'saveDraft': 'Save draft',
      'exportPdf': 'Export PDF',
      'generalInfo': 'General information',
      'clientInfo': 'Client information',
      'projectInfo': 'Project information',
      'technicalDescription': 'Technical description',
      'dqe': 'D.Q.E. (Quantitative)',
      'qualitative': 'Qualitative quote',
      'planning': 'Planning & Methodology',
      'financialSummary': 'Financial summary',
      'conditions': 'General conditions',
    },
  };
}
