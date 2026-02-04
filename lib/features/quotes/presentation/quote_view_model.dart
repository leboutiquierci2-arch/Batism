import 'package:flutter/material.dart';

import '../data/quote_repository.dart';
import '../domain/models/lot.dart';
import '../domain/models/lot_line.dart';
import '../domain/models/quote.dart';

class QuoteViewModel extends ChangeNotifier {
  QuoteViewModel({required this.repository});

  final QuoteRepository repository;

  Quote? currentQuote;

  List<Quote> get quotes => repository.all();

  void createNewQuote() {
    currentQuote = Quote(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      clientName: '',
      projectType: 'Construction neuve',
      reference: 'DEV-${DateTime.now().millisecondsSinceEpoch}',
      date: DateTime.now(),
      lots: _defaultLots(),
    );
    notifyListeners();
  }

  void saveQuote() {
    if (currentQuote == null) return;
    repository.add(currentQuote!);
    notifyListeners();
  }

  List<Lot> _defaultLots() {
    return [
      Lot(code: 'LOT 0', title: 'Installation du chantier', lines: [
        LotLine(designation: 'Installation de chantier', unit: 'Forfait', quantity: 1, unitPrice: 0),
      ]),
      Lot(code: 'LOT 1', title: 'Terrassement', lines: [
        LotLine(designation: 'Terrassement général', unit: 'm³', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 2', title: 'Gros œuvre (Fondations, Élévations, Dalles)', lines: [
        LotLine(designation: 'Fondations', unit: 'm³', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 3', title: 'Toiture', lines: [
        LotLine(designation: 'Couverture', unit: 'm²', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 4', title: 'Menuiseries', lines: [
        LotLine(designation: 'Menuiseries extérieures', unit: 'Forfait', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 5', title: 'Électricité (courant fort / faible)', lines: [
        LotLine(designation: 'Installation électrique', unit: 'Forfait', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 6', title: 'Plomberie', lines: [
        LotLine(designation: 'Installation plomberie', unit: 'Forfait', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 7', title: 'Finitions', lines: [
        LotLine(designation: 'Enduits et peintures', unit: 'm²', quantity: 0, unitPrice: 0),
      ]),
      Lot(code: 'LOT 8', title: 'Aménagement extérieur', lines: [
        LotLine(designation: 'Clôture', unit: 'm', quantity: 0, unitPrice: 0),
      ]),
    ];
  }
}
