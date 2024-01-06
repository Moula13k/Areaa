import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailSenderWidget extends StatefulWidget {
  @override
  _EmailSenderWidgetState createState() => _EmailSenderWidgetState();
}

class _EmailSenderWidgetState extends State<EmailSenderWidget> {
  TextEditingController toController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: toController.text,
      queryParameters: {
        'subject': subjectController.text,
        'body': bodyController.text,
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    backgroundColor: Colors.black,
        title: Text('Email Sender', style: TextStyle(color: Colors.white)), // Définir la couleur du texte de l'AppBar
        
      ),
      body: Container(
        color: Colors.black, // Définir la couleur de fond sur noir
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: toController,
              decoration: InputDecoration(labelText: 'To'),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: bodyController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: sendEmail,
              child: Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}