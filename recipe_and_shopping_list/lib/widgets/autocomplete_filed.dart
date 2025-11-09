import 'package:flutter/material.dart';

class AutocompleteField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Set<String> availableOptions;
  final InputDecoration inputDecoration;

  const AutocompleteField({
    super.key,
    required this.onChanged,
    required this.availableOptions,
    required this.inputDecoration,
  });

  @override
  Widget build(BuildContext context) {
    final options = availableOptions.toList();

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        final text = value.text.toLowerCase();
        if (text.isEmpty) return options;
        return options.where((opt) => opt.toLowerCase().contains(text));
      },
      onSelected: onChanged,
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          decoration: inputDecoration,
        );
      },
    );
  }
}
