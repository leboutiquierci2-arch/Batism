import 'lot_line.dart';

class Lot {
  Lot({
    required this.code,
    required this.title,
    required this.lines,
  });

  final String code;
  final String title;
  final List<LotLine> lines;

  double get total => lines.fold(0, (sum, line) => sum + line.amount);
}
