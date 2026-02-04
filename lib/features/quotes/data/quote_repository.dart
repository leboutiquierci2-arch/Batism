import '../domain/models/quote.dart';

class QuoteRepository {
  final List<Quote> _quotes = [];

  List<Quote> all() => List.unmodifiable(_quotes);

  void add(Quote quote) {
    _quotes.add(quote);
  }

  void update(Quote quote) {
    final index = _quotes.indexWhere((item) => item.id == quote.id);
    if (index >= 0) {
      _quotes[index] = quote;
    }
  }
}
