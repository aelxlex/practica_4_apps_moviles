import 'package:flutter/material.dart';
import '../models/evento.dart';

class EventProvider with ChangeNotifier {
  List<Evento> _eventos = [];

  List<Evento> get eventos => _eventos;

  void agregarEvento(String titulo, DateTime fecha, String descripcion) {
    _eventos.add(Evento(descripcion: descripcion, fecha: fecha, titulo: titulo));
    notifyListeners();
  }

  void eliminarEvento(int index) {
    _eventos.removeAt(index);
    notifyListeners();
  }
}
