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

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? _timer;
  int _secondsRemaining = 0; // Inicialmente establecido en 0

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
        // Aquí puedes activar la alarma
        _activateAlarm();
      } else {
        setState(() {
          _secondsRemaining--;
          _saveTime(); // Guardar el tiempo restante mientras se actualiza
        });
      }
    });
  }

  void _activateAlarm() {
    // Aquí colocas la lógica para activar la alarma
    print('¡Alarma activada!');
  }

  void _showNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Ya son las 14:15!'),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _loadSavedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime savedTime =
        DateTime.fromMillisecondsSinceEpoch(prefs.getInt('timer') ?? 0);
    DateTime now = DateTime.now();

    // Calculamos el tiempo restante hasta las 14:15 del día siguiente
    DateTime nextAlarmTime = DateTime(now.year, now.month, now.day, 14, 17);
    if (now.isAfter(nextAlarmTime)) {
      nextAlarmTime = nextAlarmTime.add(Duration(days: 1));
    }

    _secondsRemaining = nextAlarmTime.difference(now).inSeconds;
    _startTimer(); // Iniciar el temporizador después de cargar el tiempo
  }

  void _saveTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timer',
        DateTime.now().millisecondsSinceEpoch + (_secondsRemaining * 1000));
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
