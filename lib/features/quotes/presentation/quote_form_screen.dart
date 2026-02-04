import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/section_header.dart';
import '../domain/models/lot.dart';
import 'quote_view_model.dart';
import 'widgets/lot_table.dart';

class QuoteFormScreen extends StatefulWidget {
  const QuoteFormScreen({super.key});

  @override
  State<QuoteFormScreen> createState() => _QuoteFormScreenState();
}

class _QuoteFormScreenState extends State<QuoteFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localization = context.watch<AppLocalizations>();
    final viewModel = context.watch<QuoteViewModel>();
    final quote = viewModel.currentQuote;

    if (quote == null) {
      return const Scaffold(
        body: Center(child: Text('Aucun devis en cours.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.get('quoteBuilder')),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionHeader(title: localization.get('generalInfo')),
            const SizedBox(height: 12),
            _buildGeneralInfo(context, quote),
            const SizedBox(height: 16),
            SectionHeader(title: localization.get('technicalDescription')),
            const SizedBox(height: 12),
            _buildTechnicalDescription(),
            const SizedBox(height: 16),
            SectionHeader(title: localization.get('dqe')),
            const SizedBox(height: 12),
            ...quote.lots.map((lot) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: LotTable(
                    lot: lot,
                    onChanged: () => setState(() {}),
                  ),
                )),
            SectionHeader(title: localization.get('qualitative')),
            const SizedBox(height: 12),
            _buildQualitativeSection(),
            const SizedBox(height: 16),
            SectionHeader(title: localization.get('planning')),
            const SizedBox(height: 12),
            _buildPlanningSection(),
            const SizedBox(height: 16),
            SectionHeader(title: localization.get('financialSummary')),
            const SizedBox(height: 12),
            _buildSummary(quote.lots),
            const SizedBox(height: 16),
            SectionHeader(title: localization.get('conditions')),
            const SizedBox(height: 12),
            _buildConditionsSection(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      viewModel.saveQuote();
                      Navigator.pop(context);
                    },
                    child: Text(localization.get('saveDraft')),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(localization.get('exportPdf')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfo(BuildContext context, quote) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1.1 Informations du client', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Nom / Société'),
          onChanged: (value) => quote.clientName = value,
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Adresse'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Contact'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 16),
        Text('1.2 Informations du projet', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: quote.projectType,
          decoration: const InputDecoration(labelText: 'Type de projet'),
          items: const [
            DropdownMenuItem(value: 'Construction neuve', child: Text('Construction neuve')),
            DropdownMenuItem(value: 'Extension', child: Text('Extension')),
            DropdownMenuItem(value: 'Rénovation', child: Text('Rénovation')),
          ],
          onChanged: (value) => quote.projectType = value ?? quote.projectType,
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Pays'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Ville'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Quartier'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: quote.reference,
          decoration: const InputDecoration(labelText: 'Référence du devis'),
          onChanged: (value) => quote.reference = value,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: quote.date.toIso8601String().split('T').first,
          decoration: const InputDecoration(labelText: 'Date'),
        ),
        const SizedBox(height: 16),
        Text('1.3 Objectif du devis', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Étude préliminaire')),
            Chip(label: Text('Offre définitive')),
            Chip(label: Text('Réajustement budgétaire')),
            Chip(label: Text('Appel d’offres')),
          ],
        ),
      ],
    );
  }

  Widget _buildTechnicalDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('2.1 Caractéristiques du terrain', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Superficie totale (m²)'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Forme'),
          items: const [
            DropdownMenuItem(value: 'Rectangulaire', child: Text('Rectangulaire')),
            DropdownMenuItem(value: 'Trapèze', child: Text('Trapèze')),
            DropdownMenuItem(value: 'Irrégulière', child: Text('Irrégulière')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Accessibilité'),
          items: const [
            DropdownMenuItem(value: 'Bonne', child: Text('Bonne')),
            DropdownMenuItem(value: 'Moyenne', child: Text('Moyenne')),
            DropdownMenuItem(value: 'Difficile', child: Text('Difficile')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Nature du sol'),
          items: const [
            DropdownMenuItem(value: 'Sableux', child: Text('Sableux')),
            DropdownMenuItem(value: 'Latéritique', child: Text('Latéritique')),
            DropdownMenuItem(value: 'Argileux', child: Text('Argileux')),
            DropdownMenuItem(value: 'Rocheux', child: Text('Rocheux')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Enclavement')),
            Chip(label: Text('Servitudes')),
            Chip(label: Text('Zone inondable')),
            Chip(label: Text('Voisinage proche')),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Étude de sol')),
            Chip(label: Text('Plan topographique')),
            Chip(label: Text('Étude hydrologique')),
          ],
        ),
        const SizedBox(height: 16),
        Text('2.2 Caractéristiques du bâtiment', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Surface au sol (m²)'),
        ),
        const SizedBox(height: 12),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Surface totale plancher (m²)'),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Nombre d’étages'),
          items: const [
            DropdownMenuItem(value: 'R+0', child: Text('R+0')),
            DropdownMenuItem(value: 'R+1', child: Text('R+1')),
            DropdownMenuItem(value: 'R+2', child: Text('R+2')),
            DropdownMenuItem(value: '+', child: Text('+')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Hauteur sous plafond'),
          items: const [
            DropdownMenuItem(value: '2,7 m', child: Text('2,7 m')),
            DropdownMenuItem(value: '3 m', child: Text('3 m')),
            DropdownMenuItem(value: 'Autre', child: Text('Autre')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Type de structure'),
          items: const [
            DropdownMenuItem(value: 'Béton armé', child: Text('Béton armé')),
            DropdownMenuItem(value: 'Métallique', child: Text('Métallique')),
            DropdownMenuItem(value: 'Mixte', child: Text('Mixte')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Style architectural'),
          items: const [
            DropdownMenuItem(value: 'Moderne', child: Text('Moderne')),
            DropdownMenuItem(value: 'Traditionnel', child: Text('Traditionnel')),
            DropdownMenuItem(value: 'Contemporain', child: Text('Contemporain')),
            DropdownMenuItem(value: 'Économique', child: Text('Économique')),
          ],
          onChanged: (_) {},
        ),
        const SizedBox(height: 16),
        Text('2.3 Répartition des pièces', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        _numberField('Chambres'),
        const SizedBox(height: 12),
        _numberField('Salons'),
        const SizedBox(height: 12),
        _numberField('Cuisine'),
        const SizedBox(height: 12),
        _numberField('Salles d’eau'),
        const SizedBox(height: 12),
        _numberField('Toilettes'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Buanderie')), 
            Chip(label: Text('Couloirs')),
            Chip(label: Text('Escaliers')), 
          ],
        ),
        const SizedBox(height: 12),
        _numberField('Balcons / Terrasses'),
        const SizedBox(height: 12),
        _numberField('Garage / Carport'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Jardin')),
            Chip(label: Text('Cour')),
            Chip(label: Text('Piscine')),
            Chip(label: Text('Clôture')),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text('Chambre gardien')),
            Chip(label: Text('Magasin')),
            Chip(label: Text('Bureau')),
            Chip(label: Text('Atelier')),
            Chip(label: Text('Cuisine extérieure')),
          ],
        ),
      ],
    );
  }

  Widget _buildQualitativeSection() {
    return Column(
      children: [
        _textArea('Normes & Exigences'),
        const SizedBox(height: 12),
        _textArea('Fondations'),
        const SizedBox(height: 12),
        _textArea('Murs & Élévations'),
        const SizedBox(height: 12),
        _textArea('Toiture'),
        const SizedBox(height: 12),
        _textArea('Électricité'),
        const SizedBox(height: 12),
        _textArea('Plomberie'),
        const SizedBox(height: 12),
        _textArea('Finitions'),
      ],
    );
  }

  Widget _buildPlanningSection() {
    return Column(
      children: [
        _textArea('Planning par phase (semaines)'),
        const SizedBox(height: 12),
        _textArea('Méthodologie d’exécution détaillée'),
      ],
    );
  }

  Widget _buildSummary(List<Lot> lots) {
    final total = lots.fold(0.0, (sum, lot) => sum + lot.total);
    final tva = total * 0.18;
    final ttc = total + tva;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...lots.map((lot) => ListTile(
              title: Text('${lot.code} - ${lot.title}'),
              trailing: Text(lot.total.toStringAsFixed(2)),
            )),
        const Divider(),
        ListTile(
          title: const Text('TOTAL HT'),
          trailing: Text(total.toStringAsFixed(2)),
        ),
        ListTile(
          title: const Text('TVA (18%)'),
          trailing: Text(tva.toStringAsFixed(2)),
        ),
        ListTile(
          title: const Text('TOTAL TTC'),
          trailing: Text(ttc.toStringAsFixed(2)),
        ),
      ],
    );
  }

  Widget _buildConditionsSection() {
    return Column(
      children: [
        _textArea('Validité du devis'),
        const SizedBox(height: 12),
        _textArea('Modalités de paiement'),
        const SizedBox(height: 12),
        _textArea('Garantie'),
        const SizedBox(height: 12),
        _textArea('Pénalités / Retards'),
      ],
    );
  }

  Widget _textArea(String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      maxLines: 4,
    );
  }

  Widget _numberField(String label) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }
}
