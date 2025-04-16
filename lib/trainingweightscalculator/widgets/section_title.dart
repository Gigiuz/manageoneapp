import 'package:flutter/material.dart';

/// Widget for displaying a section title with consistent styling.
class SectionTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  /// Creates a section title with the given [title].
  /// 
  /// The [padding] and [style] parameters can be used to customize the appearance.
  const SectionTitle({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        title,
        style: style ?? const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold, 
          color: Colors.black,
        ),
      ),
    );
  }
}