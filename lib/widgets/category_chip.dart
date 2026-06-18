import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String category;
  const CategoryChip({super.key, required this.category});

  Color get color {
    switch (category) {
      case 'Trabajo':
        return const Color(0xFF4F7DF3);
      case 'Personal':
        return const Color(0xFF8B5CF6);
      case 'Estudio':
        return const Color(0xFF22C55E);
      case 'Urgente':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }
  Color get _categoryBackgroundColor {
    switch (category) {
      case 'Trabajo':
        return const Color(0x1F4F7DF3);
      case 'Personal':
        return const Color(0x1F8B5CF6);
      case 'Estudio':
        return const Color(0x1622C55E);
      case 'Urgente':
        return const Color(0x1FEF4444);
      default:
        return const Color(0x1F6B7280);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _categoryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
