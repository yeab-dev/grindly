import 'package:flutter/material.dart';

class TField extends StatefulWidget {
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
  State<TField> createState() => _TFieldState();
}

class _TFieldState extends State<TField> {
  late bool _obscure;

  bool get _isPasswordField {
    final label = widget.labelText.toLowerCase().trim();
    return label == 'password' || label == 'confirm password';
  }

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return SizedBox(
      width: width * widget.widthFactor,
      child: TextFormField(
        errorBuilder: (context, error) {
          return Text(
            error.toString(),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          );
        },
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: _isPasswordField
              ? IconButton(
                  icon: Icon(
                    color: theme.colorScheme.primary,
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                )
              : null,
        ),
        keyboardType: widget.keyboardType,
        obscureText: _isPasswordField ? _obscure : widget.obscureText,
        validator:
            widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
      ),
    );
  }
}
