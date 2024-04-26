import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityGamePage extends StatefulWidget {
  @override
  _UnityGamePageState createState() => _UnityGamePageState();
}

class _UnityGamePageState extends State
{
  late UnityWidgetController _unityWidgetController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unity Game Page'),
      ),
      body: Center(
        child: UnityWidget(
          onUnityCreated: onUnityCreated,
          onUnityMessage: onUnityMessage,
          onUnitySceneLoaded: onUnitySceneLoaded,
          fullscreen: true,
        ),
      ),
    );
  }

  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    // Aquí puedes enviar mensajes a Unity o realizar otras acciones cuando Unity se haya creado
  }

  void onUnityMessage(message) {
    // Manejar mensajes recibidos desde Unity
    print('Received message from Unity: $message');
  }

  void onUnitySceneLoaded(sceneName) {
    // Manejar eventos de carga de escena de Unity
    print('Unity scene loaded: $sceneName');
  }

  @override
  void dispose() {
    // Asegúrate de liberar recursos al finalizar
    if (_unityWidgetController != null) {
      _unityWidgetController.dispose();
    }
    super.dispose();
  }
}
