import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

Future<String?> showTextInputDialog(
  BuildContext context, {
  required String title,
  required String label,
  String initialValue = '',
  TextInputType keyboardType = TextInputType.text,
}) {
  final controller = TextEditingController(text: initialValue);
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        keyboardType: keyboardType,
        autofocus: true,
        decoration: InputDecoration(labelText: label),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, controller.text.trim()),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

Future<String?> showChoiceDialog(
  BuildContext context, {
  required String title,
  required List<String> options,
  String? initialValue,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: RadioGroup<String>(
        groupValue: initialValue,
        onChanged: (value) => Navigator.pop(context, value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final o in options)
              RadioListTile<String>(
                value: o,
                title: Text(o),
                activeColor: AppColors.teal,
              ),
          ],
        ),
      ),
    ),
  );
}