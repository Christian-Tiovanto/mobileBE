import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_be/providers/Locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Indonesian'];

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

   Future<void> _saveLanguagePreference(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);

    final Locale_provider = Provider.of<LocaleProvider>(context, listen: false);
    if (language == 'English') {
      Locale_provider.setLocale(const Locale('en', 'US'));
    } else if (language == 'Indonesian') {
      Locale_provider.setLocale(const Locale('id', 'ID'));
    }
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('selectedLanguage');
    if (savedLanguage != null) {
      setState(() {
        _selectedLanguage = savedLanguage;
      });
    }
  }

  void _changeLanguage(String language) {
    Locale newLocale;
    if (language == 'English') {
      newLocale = const Locale('en', 'US');
    } else if (language == 'Indonesian') {
      newLocale = const Locale('id', 'ID');
    } else {
      return;
    }

    setState(() {
      AppLocalizations.delegate.load(newLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.setting),
        backgroundColor: const Color.fromARGB(255, 227, 132, 36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Language option
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                  _changeLanguage(newValue!);
                  _saveLanguagePreference(newValue);
                  print('Selected Language: $_selectedLanguage');
                },
                items: _languages.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Additional settings can go here...
          ],
        ),
      ),
    );
  }
}