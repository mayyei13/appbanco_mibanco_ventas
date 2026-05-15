import 'package:flutter/material.dart';

// No olvides el modelo del cliente
class ClienteVisita {
  final String nombre;
  final String gestion; 
  String estado; 

  ClienteVisita({
    required this.nombre,
    required this.gestion,
    required this.estado,
  });
}

class CarteraViewModel extends ChangeNotifier {
  // ESTA ES LA LÍNEA QUE TE FALTA O ESTÁ MAL ESCRITA
  final String nombreOficial = "Carlos Pérez"; 

  final List<ClienteVisita> _clientes = [
    ClienteVisita(nombre: "Juan Perez - Bodega El Sol", gestion: "Renovación", estado: "Visitado"),
    ClienteVisita(nombre: "Maria Loayza - Confecciones Mary", gestion: "Cobranza", estado: "Pendiente"),
    ClienteVisita(nombre: "Ferretería Central S.A.C.", gestion: "Nuevo Crédito", estado: "Pendiente"),
    ClienteVisita(nombre: "Jose Tipiani - Puesto 45", gestion: "Cobranza", estado: "Visitado"),
    ClienteVisita(nombre: "Restaurante Sabor Criollo", gestion: "Renovación", estado: "Pendiente"),
  ];

  List<ClienteVisita> get clientes => _clientes;
  int get totalVisitas => _clientes.length;
  int get completados => _clientes.where((c) => c.estado == "Visitado").length;
  int get pendientes => _clientes.where((c) => c.estado == "Pendiente").length;

  void marcarComoVisitado(int index) {
    if (_clientes[index].estado == "Pendiente") {
      _clientes[index].estado = "Visitado";
      notifyListeners();
    }
  }
}