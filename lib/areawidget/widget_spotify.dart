import 'package:flutter/material.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyIntegrationPage extends StatefulWidget {
  @override
  _SpotifyIntegrationPageState createState() => _SpotifyIntegrationPageState();
}

class _SpotifyIntegrationPageState extends State<SpotifyIntegrationPage> {
  @override
  void initState() {
    super.initState();
    _initSpotify();
  }

  Future<void> _initSpotify() async {
    await SpotifySdk.connectToSpotifyRemote(
      clientId: '24613bd8f2c34375b859eb3f699f9db3',
      redirectUrl: 'http://localhost:45309/',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Integration'),
      ),
      body: Center(
        child: Text('Your Spotify content goes here!'),
      ),
    );
  }
}