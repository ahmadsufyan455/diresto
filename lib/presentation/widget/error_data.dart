import 'package:diresto/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ErrorData extends StatelessWidget {
  final String message;
  final VoidCallback onRefresh;
  const ErrorData({required this.message, required this.onRefresh, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/error_data.png', width: 100.0),
          const SizedBox(height: 16.0),
          Text(
            message,
            style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: onRefresh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Try Again',
                  style: TextStyles.body.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4.0),
                Icon(
                  Icons.refresh_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
