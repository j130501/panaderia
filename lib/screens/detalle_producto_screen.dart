import 'package:flutter/material.dart';
import '../models/producto.dart';

class DetalleProductoScreen extends StatelessWidget {
  final Producto producto;

  DetalleProductoScreen({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle del Producto")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: ListTile(
            title: Text(producto.nombre, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            subtitle: Text("Precio: S/ ${producto.precio.toStringAsFixed(2)}", style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
