import 'package:flutter/material.dart';

/// A selectable training option widget with custom styling.
///
/// Displays a training option as a card with an icon/image, label and radio button.
class TrainingOption extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;
  final Color color;
  final IconData? icon;
  final Image? iconImage;
  final String? assetImagePath;

  /// Creates a training option.
  ///
  /// The [label] is displayed as the option title.
  /// The [value] is the value associated with this option.
  /// The [groupValue] is the currently selected value in the radio group.
  /// The [onChanged] callback is called when this option is selected.
  /// The [color] is used for highlighting when selected.
  /// 
  /// Only one of [icon], [iconImage], or [assetImagePath] should be provided.
  const TrainingOption({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.color,
    this.icon,
    this.iconImage,
    this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onChanged?.call(value),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: groupValue == value
                ? color.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: groupValue == value ? color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              if (iconImage != null)
                SizedBox(width: 32, height: 32, child: iconImage!)
              else if (assetImagePath != null)
                Image.asset(assetImagePath!, width: 32, height: 32, color: Colors.black)
              else if (icon != null)
                Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: groupValue == value ? color : Colors.black87,
                  fontWeight:
                      groupValue == value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}