import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskai/providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4F7DF3),
                    ),
                    child: const Center(
                      child: Text(
                        'ER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Emelyn Reyes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'emelyn.reyes@email.com',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Notificaciones'),
                      subtitle: const Text('Recibir alertas de tareas y plazos.'),
                      value: notificationsEnabled,
                      onChanged: (value) => setState(() => notificationsEnabled = value),
                    ),
                    const Divider(height: 0),
                    SwitchListTile(
                      title: const Text('Modo oscuro'),
                      subtitle: Text(isDarkMode ? 'Activo' : 'Desactivado'),
                      value: isDarkMode,
                      onChanged: (value) {
                        context.read<ThemeProvider>().setDarkMode(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.language_outlined),
                      title: Text('Idioma'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.privacy_tip_outlined),
                      title: Text('Privacidad'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('Acerca de'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                  onPressed: () {},
                  child: const Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
