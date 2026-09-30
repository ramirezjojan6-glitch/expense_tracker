import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/page_title.dart';
import '../state/app_state.dart';
import '../widgets/glass_card.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _category;
  DateTime _date = DateTime(2026, 9, 28);

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String get _dateLabel =>
      '${_months[_date.month - 1]} ${_date.day}, ${_date.year}';

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickCategory() async {
    final names = appState.categoryLimits.map((c) => c.name).toList();
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Select category',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            for (final n in names)
              ListTile(
                title: Text(n),
                onTap: () => Navigator.pop(context, n),
              ),
          ],
        ),
      ),
    );
    if (choice != null) setState(() => _category = choice);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0 || _category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter an amount and pick a category')),
      );
      return;
    }
    appState.addExpense(
      description: _noteController.text.trim(),
      category: _category!,
      amount: amount,
      date: _date,
    );
    setState(() {
      _amountController.clear();
      _noteController.clear();
      _category = null;
      _date = DateTime(2026, 9, 28);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense added')),
    );
  }

  void _showScanPlaceholder(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature coming soon')),
    );
  }

  Widget _buildScanButton({required String label, required IconData icon}) {
    return IconButton(
      tooltip: label,
      onPressed: () => _showScanPlaceholder(label),
      icon: Icon(icon),
      style: IconButton.styleFrom(
        foregroundColor: AppColors.teal,
        backgroundColor: Colors.white.withValues(alpha: 0.55),
        minimumSize: const Size(40, 40),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? prefixText,
    String? hintText,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixText: prefixText,
          hintText: hintText,
        ),
        style: const TextStyle(fontSize: 13, color: AppColors.darkTeal),
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _save,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Save expense',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.darkTeal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: PageTitle('Add expense')),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: _buildScanButton(
                  label: 'QR scan',
                  icon: Icons.qr_code_scanner,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: _buildScanButton(
                  label: 'Quick scan',
                  icon: Icons.document_scanner_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Amount'),
                _buildInputField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  prefixText: '₱',
                  hintText: '0.00',
                ),
                const SizedBox(height: 14),
                const _FieldLabel('Category'),
                _TapField(
                  text: _category ?? 'Select category',
                  trailing: Icons.keyboard_arrow_down,
                  onTap: _pickCategory,
                ),
                const SizedBox(height: 14),
                const _FieldLabel('Date'),
                _TapField(
                  text: _dateLabel,
                  trailing: Icons.calendar_today_outlined,
                  onTap: _pickDate,
                ),
                const SizedBox(height: 14),
                const _FieldLabel('Note'),
                _buildInputField(
                  controller: _noteController,
                  minLines: 3,
                  maxLines: 4,
                  hintText: 'e.g. Lunch at school',
                ),
                const SizedBox(height: 20),
                _buildSaveButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.teal,
        ),
      ),
    );
  }
}

class _TapField extends StatelessWidget {
  final String text;
  final IconData trailing;
  final VoidCallback onTap;

  const _TapField({
    required this.text,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
              Icon(trailing, size: 18, color: AppColors.teal),
            ],
          ),
        ),
      ),
    );
  }
}