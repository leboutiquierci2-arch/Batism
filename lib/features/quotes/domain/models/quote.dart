import 'lot.dart';

class Quote {
  Quote({
    required this.id,
    required this.clientName,
    required this.projectType,
    required this.reference,
    required this.date,
    required this.lots,
  });

  final String id;
  String clientName;
  String projectType;
  String reference;
  DateTime date;
  List<Lot> lots;

  double get total => lots.fold(0, (sum, lot) => sum + lot.total);
}
