import 'package:flutter/material.dart';
import 'moneda.dart'; // Importa la clase Usuario

class MonedaProvider extends ChangeNotifier {
  Moneda? _moneda; // Usuario actualmente autenticado

  // Método para establecer el usuario autenticado
  void setMoneda(Moneda moneda) {
    _moneda = moneda;
    notifyListeners(); // Notificar a los oyentes que el estado ha cambiado
  }

  // Método para obtener el usuario autenticado
  Moneda? get moneda => _moneda;

  // Método para verificar si hay un usuario autenticado
  bool estaAutenticado() => _moneda != null;
}
