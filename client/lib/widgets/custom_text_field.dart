import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final TextEditingController value;
  final int? maxLines;
  final double borderRadius;
  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderWidth;
  final Color disabledBorderColor;
  final double disabledBorderWidth;
  final VoidCallback? handleSuffixOnPressed;
  final String? Function(String?)? validator; // New property for validation

  const CustomTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.obscureText = false,
    required this.enabled,
    required this.value,
    this.borderRadius = 20,
    this.focusedBorderColor = Colors.grey,
    this.focusedBorderWidth = 3,
    this.enabledBorderColor = Colors.grey,
    this.enabledBorderWidth = 3,
    this.disabledBorderColor = Colors.grey,
    this.disabledBorderWidth = 3,
    this.handleSuffixOnPressed,
    this.maxLines = 1,
    this.validator,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    errorText = null;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      // Validate input when the text field loses focus
      if (!_focusNode.hasFocus && widget.validator != null) {
        errorText = widget.validator!(widget.value.text);
      } else {
        errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: TextFormField(
        enabled: widget.enabled,
        obscureText: widget.obscureText,
        obscuringCharacter: "*",
        controller: widget.value,
        maxLines: widget.maxLines,
        focusNode: _focusNode,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
                color: widget.focusedBorderColor,
                width: widget.focusedBorderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
                color: widget.enabledBorderColor,
                width: widget.enabledBorderWidth),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
                color: widget.disabledBorderColor,
                width: widget.disabledBorderWidth),
          ),
          labelText: widget.label,
          suffixIcon: IconButton(
            icon: Icon(widget.suffixIcon),
            onPressed: widget.handleSuffixOnPressed,
          ),
          errorText: errorText,
        ),
      ),
    );
  }
}

class FormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }
}
