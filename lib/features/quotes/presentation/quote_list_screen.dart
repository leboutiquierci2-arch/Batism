import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import 'quote_view_model.dart';

class QuoteListScreen extends StatelessWidget {
  const QuoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.watch<AppLocalizations>();
    final viewModel = context.watch<QuoteViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.get('quoteBuilder')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.secondaryBeige),
            onPressed: () {
              viewModel.createNewQuote();
              Navigator.pushNamed(context, '/quote-form');
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final quote = viewModel.quotes[index];
          return ListTile(
            tileColor: index.isEven ? AppColors.pureWhite : AppColors.lightBeige,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(quote.reference),
            subtitle: Text(quote.clientName.isEmpty ? 'Client' : quote.clientName),
            trailing: Text('${quote.total.toStringAsFixed(2)}'),
            onTap: () {
              viewModel.currentQuote = quote;
              Navigator.pushNamed(context, '/quote-form');
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: viewModel.quotes.length,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.brickBrown,
        onPressed: () {
          viewModel.createNewQuote();
          Navigator.pushNamed(context, '/quote-form');
        },
        child: const Icon(Icons.add, color: AppColors.pureWhite),
      ),
    );
  }
}
