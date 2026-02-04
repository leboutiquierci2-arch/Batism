import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_localizations.dart';
import 'profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.watch<AppLocalizations>();
    final viewModel = context.watch<ProfileViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.get('companyProfile')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: viewModel.formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: localization.get('companyName')),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Requis' : null,
                onSaved: (value) => viewModel.companyName = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: localization.get('address')),
                onSaved: (value) => viewModel.address = value ?? '',
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: localization.get('contact')),
                onSaved: (value) => viewModel.contact = value ?? '',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: localization.get('currency')),
                value: viewModel.currency,
                items: const [
                  DropdownMenuItem(value: 'FCFA', child: Text('FCFA')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                ],
                onChanged: (value) => viewModel.currency = value ?? 'FCFA',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  viewModel.save();
                  Navigator.pushReplacementNamed(context, '/quotes');
                },
                child: const Text('Continuer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
