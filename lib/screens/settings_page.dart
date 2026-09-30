import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../state/app_state.dart';
import '../widgets/glass_card.dart';
import '../widgets/dialogs.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _editProfile(BuildContext context) async {
    final nameController = TextEditingController(text: appState.profileName);
    final roleController = TextEditingController(text: appState.profileRole);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              appState.updateProfile(
                name: nameController.text.trim(),
                role: roleController.text.trim(),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _editChoice(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String initialValue,
    required ValueChanged<String> onSelected,
  }) async {
    final result = await showChoiceDialog(
      context,
      title: title,
      options: options,
      initialValue: initialValue,
    );
    if (result != null) onSelected(result);
  }

  Future<void> _editCurrency(BuildContext context) => _editChoice(
    context,
    title: 'Currency',
    options: const [
      'Philippine peso (₱)',
      'US dollar (\$)',
      'Euro (€)',
      'Japanese yen (¥)',
    ],
    initialValue: appState.currency,
    onSelected: appState.updateCurrency,
  );

  Future<void> _editAppearance(BuildContext context) => _editChoice(
    context,
    title: 'Appearance',
    options: const ['Light mode', 'Dark mode'],
    initialValue: appState.appearance,
    onSelected: appState.updateAppearance,
  );

  Future<void> _editDataBackup(BuildContext context) => _editChoice(
    context,
    title: 'Data & backup',
    options: const ['Save to cloud', 'Local only'],
    initialValue: appState.dataBackup,
    onSelected: appState.updateDataBackup,
  );

  Future<void> _editMonthlyBudget(BuildContext context) async {
    final result = await showTextInputDialog(
      context,
      title: 'Monthly budget',
      label: 'Amount',
      initialValue: appState.monthlyBudget.toStringAsFixed(0),
      keyboardType: TextInputType.number,
    );
    final value = double.tryParse(result ?? '');
    if (value != null && value > 0) appState.updateMonthlyBudget(value);
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: const Text(
          'ExpenseTracker\nVersion 1.0\nBuilt as a school project.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return GlassCard(
      onTap: () => _editProfile(context),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appState.profileName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                appState.profileRole,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 18, color: AppColors.teal),
        ],
      ),
    );
  }

  Widget _buildSettingsRow(BuildContext context, _SettingRow row, bool isLast) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: row.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(
                    bottom: BorderSide(
                      color: Colors.black.withValues(alpha: 0.06),
                    ),
                  ),
          ),
          child: Row(
            children: [
              Icon(row.icon, size: 18, color: AppColors.teal),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  row.title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.darkTeal,
                  ),
                ),
              ),
              Text(
                row.value,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, size: 16, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final rows = [
          _SettingRow(
            title: 'Currency',
            value: appState.currency,
            icon: Icons.attach_money,
            onTap: () => _editCurrency(context),
          ),
          _SettingRow(
            title: 'Monthly budget',
            value: '₱${appState.monthlyBudget.toStringAsFixed(0)}',
            icon: Icons.pie_chart_outline,
            onTap: () => _editMonthlyBudget(context),
          ),
          _SettingRow(
            title: 'Appearance',
            value: appState.appearance,
            icon: Icons.dark_mode_outlined,
            onTap: () => _editAppearance(context),
          ),
          _SettingRow(
            title: 'Data & backup',
            value: appState.dataBackup,
            icon: Icons.cloud_outlined,
            onTap: () => _editDataBackup(context),
          ),
          _SettingRow(
            title: 'About',
            value: 'Version 1.0',
            icon: Icons.info_outline,
            onTap: () => _showAbout(context),
          ),
        ];

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle('Settings'),
              const SizedBox(height: 10),
              _buildProfileHeader(context),
              const SizedBox(height: 16),
              GlassCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < rows.length; i++)
                      _buildSettingsRow(context, rows[i], i == rows.length - 1),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingRow {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingRow({
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });
}
