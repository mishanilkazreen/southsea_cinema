import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

const String prefAddress = 'user_address';
const String prefEmail = 'user_email';
const String prefPatronNumber = 'user_patron_number';
const String prefReceiveNews = 'user_receive_news';

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
    _loadSettings();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _patronNumberController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final String? savedAddress = await prefs.getString(prefAddress);
    final String? savedEmail = await prefs.getString(prefEmail);
    final String? savedPatronNumber = await prefs.getString(prefPatronNumber);
    final bool? savedReceiveNews = await prefs.getBool(prefReceiveNews);

    String address = '';
    if (savedAddress != null) {
      address = savedAddress;
    }

    String email = '';
    if (savedEmail != null) {
      email = savedEmail;
    }

    String patronNumber = '';
    if (savedPatronNumber != null) {
      patronNumber = savedPatronNumber;
    }

    bool receiveNews = false;
    if (savedReceiveNews != null) {
      receiveNews = savedReceiveNews;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _addressController.text = address;
      _emailController.text = email;
      _patronNumberController.text = patronNumber;
      _receiveNews = receiveNews;
    });
  }

  Future<void> _saveSettings() async {
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();
    final String patronNumber = _patronNumberController.text.trim();

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString(prefAddress, address);
    await prefs.setString(prefEmail, email);
    await prefs.setString(prefPatronNumber, patronNumber);
    await prefs.setBool(prefReceiveNews, _receiveNews);

    if (!mounted) {
      return;
    }
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
