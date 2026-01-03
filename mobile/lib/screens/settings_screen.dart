import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _haUrlController;
  late TextEditingController _apiUrlController;

  @override
  void initState() {
    super.initState();
    final settings = context.read<SettingsProvider>();
    _haUrlController = TextEditingController(text: settings.haWebhookUrl);
    _apiUrlController = TextEditingController(text: settings.customApiBaseUrl);
  }

  @override
  void dispose() {
    _haUrlController.dispose();
    _apiUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Music Recognition'),
          SwitchListTile(
            title: const Text('Auto-Log Matches'),
            subtitle: const Text('Automatically record play when a song is recognized'),
            value: settings.autoLogEnabled,
            onChanged: (val) => settings.setAutoLogEnabled(val),
          ),
          SwitchListTile(
            title: const Text('Use Home Assistant'),
            subtitle: const Text('Route recognition through HA for gatekeeping'),
            value: settings.useHomeAssistant,
            onChanged: (val) => settings.setUseHomeAssistant(val),
          ),
          if (settings.useHomeAssistant)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _haUrlController,
                decoration: const InputDecoration(
                  labelText: 'HA Webhook URL',
                  hintText: 'http://your-ha-ip:8123/api/webhook/...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) => settings.setHaWebhookUrl(val),
              ),
            ),
          const Divider(),
          const _SectionHeader(title: 'Server Connection'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _apiUrlController,
              decoration: const InputDecoration(
                labelText: 'Custom API Base URL',
                hintText: 'http://your-server-ip:8080 (Leave empty for default)',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => settings.setCustomApiBaseUrl(val),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Note: Restarting the app may be required for API URL changes to take full effect.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
