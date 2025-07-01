import 'package:flutter/material.dart';

class TField extends StatelessWidget {
  final String labelText;
  final double widthFactor;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const TField({
    super.key,
    required this.labelText,
    this.widthFactor = 0.4,
    required this.keyboardType,
    required this.obscureText,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width * widthFactor,
      child: TextFormField(
        errorBuilder: (context, error) {
          return Text(
            error ?? '',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          );
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator:
            validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return '$labelText is required';
              }
              return null;
            },
      ),
    );
  }
}
