import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleTranslateAPI {
  final String apiKey;
  final String targetLanguage;

  GoogleTranslateAPI({required this.apiKey, required this.targetLanguage});

  Future<String> translate(String text, String sourceLanguage) async {
    final response = await http.post(
      Uri.parse('https://translation.googleapis.com/language/translate/v2'),
      body: {
        'q': text,
        'source': sourceLanguage,
        'target': targetLanguage,
        'format': 'text',
        'key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final translatedText = data['data']['translations'][0]['translatedText'];
      return translatedText;
    } else {
      throw Exception('Failed to load translation');
    }
  }
}

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({Key? key}) : super(key: key);

  @override
  _WidgetScreenState createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  final GoogleTranslateAPI translator = GoogleTranslateAPI(
    apiKey: '1696a7404311c4d656353542022530757a1a44aa',
    targetLanguage: 'fr', // Changez 'fr' en la langue cible de votre choix
  );

  String originalText = 'This is the Widget Screen';
  String translatedText = '';
  String selectedLanguage = 'fr'; // Langue par défaut

  @override
  void initState() {
    super.initState();
    translateText();
  }

  void translateText() async {
    try {
      final result = await translator.translate(originalText, 'en');
      setState(() {
        translatedText = result;
      });
    } catch (e) {
      print('Error translating text: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Google Translate', style: TextStyle(color: Colors.white)), // Définir la couleur du texte de l'AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (text) {
                setState(() {
                  originalText = text;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter text to translate...',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                translateText();
              },
              items: <String>['fr', 'es', 'de', 'it', 'ja', 'ko', 'zh'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Translated Text:',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              translatedText,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
