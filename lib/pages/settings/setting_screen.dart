import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/utils/theme_provider.dart';
import 'package:studenthub/utils/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const Color _green = Color(0xFF12B28C);
enum Language { English, Vietnamese }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        backgroundColor: _green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dark_mode,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context)!.english,),
                    onTap: () {
                      languageProvider?.changeLanguage(AppLanguage.English);
                    },
                    selected: languageProvider?.currentLanguage == AppLanguage.English,
                    trailing: languageProvider?.currentLanguage == AppLanguage.English
                        ? const Icon(Icons.check)
                        : null,
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context)!.vietnamese,),
                    onTap: () {
                      languageProvider?.changeLanguage(AppLanguage.Vietnamese);
                    },
                    selected: languageProvider?.currentLanguage == AppLanguage.Vietnamese,
                    trailing: languageProvider?.currentLanguage == AppLanguage.Vietnamese
                        ? const Icon(Icons.check)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

