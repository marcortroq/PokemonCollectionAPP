import 'package:flutter/material.dart';
import 'packs.dart';

void main() {
  runApp(MaterialApp(
    home: OpenPack(),
  ));
}

class OpenPack extends StatefulWidget {
  @override
  _OpenPackState createState() => _OpenPackState();
}

class _OpenPackState extends State<OpenPack> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la nueva pantalla al tocar en cualquier parte de la pantalla
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Packs()),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Open Pack'),
        ),
        body: Center(
          child: Text(
            'Tap anywhere to go to the new screen',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Screen'),
      ),
      body: Center(
        child: Text(
          'This is the new screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
