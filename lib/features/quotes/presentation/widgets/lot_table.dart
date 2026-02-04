import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/lot.dart';

class LotTable extends StatelessWidget {
  const LotTable({super.key, required this.lot, required this.onChanged});

  final Lot lot;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${lot.code} - ${lot.title}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.5),
          },
          border: TableBorder.all(color: AppColors.secondaryBeige),
          children: [
            _headerRow(context),
            ...lot.lines.asMap().entries.map((entry) {
              final index = entry.key;
              final line = entry.value;
              return TableRow(
                decoration: BoxDecoration(
                  color: index.isEven ? AppColors.pureWhite : AppColors.lightBeige,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(line.designation),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(line.unit),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: line.quantity.toStringAsFixed(2),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        line.quantity = double.tryParse(value) ?? 0;
                        onChanged();
                      },
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: line.unitPrice.toStringAsFixed(2),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        line.unitPrice = double.tryParse(value) ?? 0;
                        onChanged();
                      },
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Total ${lot.total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreen,
                ),
          ),
        ),
      ],
    );
  }

  TableRow _headerRow(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: AppColors.darkGreen, fontWeight: FontWeight.bold);
    return TableRow(
      decoration: const BoxDecoration(color: AppColors.lightBeige),
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Désignation', style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Unité', style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Quantité', style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('P.U.', style: style),
        ),
      ],
    );
  }
}
