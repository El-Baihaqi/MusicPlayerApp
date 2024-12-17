import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepotipai_/Themes/Theme_Provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          //bayangan
          BoxShadow(
            color: isDarkMode ? Colors.black : Colors.grey.shade300,
            blurRadius: 15,
            offset: Offset(4, 4),
          ),

          //cahaya
          BoxShadow(
            color: isDarkMode ? Colors.grey.shade800 : Colors.white,
            blurRadius: 15,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      child: child,
    );
  }
}
