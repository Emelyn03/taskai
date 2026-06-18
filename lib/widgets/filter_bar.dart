import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final String selectedCategory;
  final String selectedStatus;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onStatusSelected;

  const FilterBar({
    super.key,
    required this.selectedCategory,
    required this.selectedStatus,
    required this.onCategorySelected,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categoría',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            _buildChip('Todas', selectedCategory == 'Todas'),
            _buildChip('Trabajo', selectedCategory == 'Trabajo'),
            _buildChip('Personal', selectedCategory == 'Personal'),
            _buildChip('Estudio', selectedCategory == 'Estudio'),
            _buildChip('Urgente', selectedCategory == 'Urgente'),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Estado',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            _buildStatusChip('Todas', selectedStatus == 'Todas'),
            _buildStatusChip('Pendientes', selectedStatus == 'Pendientes'),
            _buildStatusChip('Completadas', selectedStatus == 'Completadas'),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      selectedColor: const Color(0xFF4F7DF3).withAlpha(31),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF4F7DF3) : const Color(0xFF6B7280),
      ),
      onSelected: (_) => onCategorySelected(label),
      side: BorderSide(
        color: selected ? const Color(0xFF4F7DF3) : const Color(0xFFE5E7EB),
      ),
    );
  }

  Widget _buildStatusChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      selectedColor: const Color(0xFF4F7DF3).withAlpha(31),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF4F7DF3) : const Color(0xFF6B7280),
      ),
      onSelected: (_) => onStatusSelected(label),
      side: BorderSide(
        color: selected ? const Color(0xFF4F7DF3) : const Color(0xFFE5E7EB),
      ),
    );
  }
}
