import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_screen.dart';
import 'features/auth/presentation/auth_view_model.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'features/profile/presentation/profile_view_model.dart';
import 'features/quotes/data/quote_repository.dart';
import 'features/quotes/presentation/quote_form_screen.dart';
import 'features/quotes/presentation/quote_list_screen.dart';
import 'features/quotes/presentation/quote_view_model.dart';

class BatismartApp extends StatelessWidget {
  const BatismartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLocalizations()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        Provider(create: (_) => QuoteRepository()),
        ChangeNotifierProvider(
          create: (context) => QuoteViewModel(
            repository: context.read<QuoteRepository>(),
          ),
        ),
      ],
      child: Consumer<AppLocalizations>(
        builder: (context, localization, _) {
          return MaterialApp(
            title: localization.get('appTitle'),
            theme: AppTheme.light(),
            routes: {
              '/': (_) => const AuthScreen(),
              '/profile': (_) => const ProfileScreen(),
              '/quotes': (_) => const QuoteListScreen(),
              '/quote-form': (_) => const QuoteFormScreen(),
            },
          );
        },
      ),
    );
  }
}
