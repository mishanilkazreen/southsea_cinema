import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _patronNumberController;
  bool _receiveNews = false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
    _patronNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _patronNumberController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your settings have been saved.')));
  }

  void _cancelChanges() {
    _addressController.clear();
    _emailController.clear();
    _patronNumberController.clear();
    setState(() {
      _receiveNews = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle subtitleStyle = TextStyle(
      color: cinemaFontWhite,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('MY SETTINGS', style: cinemaSectionTitleStyle),
            const SizedBox(height: 16),

            // Address
            const Text('Address', style: subtitleStyle),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your address',
              ),
            ),
            const SizedBox(height: 16),

            // Email Address
            const Text('Email Address', style: subtitleStyle),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 16),

            // Patron Number
            const Text('Patron Number', style: subtitleStyle),
            const SizedBox(height: 8),
            TextField(
              controller: _patronNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your patron number',
              ),
            ),
            const SizedBox(height: 16),

            // Preferences
            const Text('Preferences', style: subtitleStyle),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Receive news by email',
                    style: TextStyle(color: cinemaFontWhite),
                  ),
                ),
                Switch(
                  value: _receiveNews,
                  onChanged: (bool value) {
                    setState(() {
                      _receiveNews = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              spacing: 16.0,
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'CANCEL',
                    onPressed: _cancelChanges,
                  ),
                ),
                Expanded(
                  child: PrimaryButton(
                    label: 'SAVE SETTINGS',
                    onPressed: _saveSettings,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
