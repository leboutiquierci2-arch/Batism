class LotLine {
  LotLine({
    required this.designation,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
  });

  final String designation;
  final String unit;
  double quantity;
  double unitPrice;

  double get amount => quantity * unitPrice;
}
