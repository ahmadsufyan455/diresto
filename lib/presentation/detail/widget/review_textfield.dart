import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class ReviewTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final int maxLines;
  const ReviewTextField({
    required this.hint,
    required this.controller,
    this.textInputAction,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: textInputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyles.body,
        isDense: true,
      ),
    );
  }
}
