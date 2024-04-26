import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();

  int getSecondsRemaining() {
    return _CountdownTimerState()._secondsRemaining;
  }
}

class _CountdownTimerState extends State {
  Timer? _timer;
  int _secondsRemaining = 4200; // Cambiado para que inicie en 0

  @override
  void initState() {
    super.initState();
    _loadSavedTime(); // Cargar el tiempo almacenado al iniciar
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        _timer?.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
          _saveTime(); // Guardar el tiempo restante mientras se actualiza
        });
      }
    });
  }

  int getSecondsRemaining() {
    return _secondsRemaining;
  }

  void _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _secondsRemaining = prefs.getInt('timer') ??
          43200; // Si no hay tiempo guardado, establecer en 12 horas
    });
    _startTimer(); // Iniciar el temporizador después de cargar el tiempo
  }

  void _saveTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'timer', _secondsRemaining); // Guardar el tiempo restante
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: _secondsRemaining);
    return Positioned(
      top: 5,
      right: -9,
      child: Container(
        width: 100,
        child: Text(
          _formatDuration(duration),
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: 'Sarpanch'),
        ),
      ),
    );
  }
}
