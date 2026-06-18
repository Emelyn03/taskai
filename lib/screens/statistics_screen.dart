import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskai/providers/task_provider.dart';
import 'package:taskai/widgets/statistics_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    final totalTasks = provider.totalTasks;
    final categoryStats = [
      _CategoryStat(
        label: 'Trabajo',
        count: provider.countByCategory('Trabajo'),
        icon: Icons.work_outline,
        color: const Color(0xFF4F7DF3),
      ),
      _CategoryStat(
        label: 'Personal',
        count: provider.countByCategory('Personal'),
        icon: Icons.person_outline,
        color: const Color(0xFF8B5CF6),
      ),
      _CategoryStat(
        label: 'Estudio',
        count: provider.countByCategory('Estudio'),
        icon: Icons.school_outlined,
        color: const Color(0xFF22C55E),
      ),
      _CategoryStat(
        label: 'Urgente',
        count: provider.countByCategory('Urgente'),
        icon: Icons.priority_high,
        color: const Color(0xFFEF4444),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen rápido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                StatisticsCard(
                  color: const Color(0xFF4F7DF3),
                  icon: Icons.list_alt,
                  label: 'Total',
                  value: totalTasks.toString(),
                ),
                StatisticsCard(
                  color: const Color(0xFF22C55E),
                  icon: Icons.hourglass_bottom,
                  label: 'Pendientes',
                  value: provider.pendingTasks.toString(),
                ),
                StatisticsCard(
                  color: const Color(0xFF4F7DF3),
                  icon: Icons.check_circle_outline,
                  label: 'Completadas',
                  value: provider.completedTasks.toString(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Por categoría',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: totalTasks == 0
                  ? const Center(
                      child: Text(
                        'No hay tareas para mostrar.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: categoryStats.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final stat = categoryStats[index];
                        final percent = totalTasks == 0 ? 0.0 : stat.count / totalTasks;
                        return _CategoryStatisticsCard(
                          label: stat.label,
                          count: stat.count,
                          percent: percent,
                          icon: stat.icon,
                          color: stat.color,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryStat {
  final String label;
  final int count;
  final IconData icon;
  final Color color;

  _CategoryStat({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
  });
}

class _CategoryStatisticsCard extends StatelessWidget {
  final String label;
  final int count;
  final double percent;
  final IconData icon;
  final Color color;

  const _CategoryStatisticsCard({
    required this.label,
    required this.count,
    required this.percent,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withAlpha(30),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$count tareas',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '${(percent * 100).round()}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: percent,
                color: color,
                backgroundColor: color.withAlpha(40),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
