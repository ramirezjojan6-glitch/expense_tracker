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

  void _stub(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle('Add expense'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _stub('Receipt scanning coming soon'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 18,
                            color: AppColors.teal,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AUTO',
                                  style: TextStyle(
                                    fontSize: 8,
                                    letterSpacing: 0.5,
                                    color: Colors.black45,
                                  ),
                                ),
                                Text(
                                  'Scan receipt',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.darkTeal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _stub('QR scanning coming soon'),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: AppColors.teal,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Amount'),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixText: '₱',
                      hintText: '0.00',
                    ),
                    style: const TextStyle(fontSize: 13, color: AppColors.darkTeal),
                  ),
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _noteController,
                    minLines: 3,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'e.g. Lunch at school',
                    ),
                    style: const TextStyle(fontSize: 13, color: AppColors.darkTeal),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
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
                ),
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