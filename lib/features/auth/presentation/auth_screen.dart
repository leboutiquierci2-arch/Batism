import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import 'auth_view_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.watch<AppLocalizations>();
    final viewModel = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.get('authTitle')),
        actions: [
          PopupMenuButton<AppLanguage>(
            icon: const Icon(Icons.language, color: AppColors.secondaryBeige),
            onSelected: localization.setLanguage,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: AppLanguage.fr,
                child: Text('Français'),
              ),
              PopupMenuItem(
                value: AppLanguage.en,
                child: Text('English'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: localization.get('email')),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
                onSaved: (value) => viewModel.email = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: localization.get('password')),
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
                onSaved: (value) => viewModel.password = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  viewModel.signIn();
                  if (viewModel.isAuthenticated) {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }
                },
                child: Text(localization.get('signIn')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
