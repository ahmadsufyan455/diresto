import 'package:flutter/material.dart';

import '../../../utils/text_styles.dart';

class ItemMenu extends StatelessWidget {
  final String name;
  final Color? color;
  const ItemMenu({required this.name, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyles.body,
        ),
      ),
    );
  }
}
