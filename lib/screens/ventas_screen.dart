import 'package:flutter/material.dart';
import '../models/venta.dart';
import '../models/producto.dart';

class VentasScreen extends StatefulWidget {
  @override
  _VentasScreenState createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  List<Venta> ventas = [];

  void _crearVenta() {
    setState(() {
      ventas.add(Venta(
        id: ventas.length + 1,
        productos: [
          Producto(nombre: "Pan francés", precio: 0.5),
          Producto(nombre: "Empanada", precio: 1.2),
        ],
      ));
    });
  }

  void _eliminarVenta(int index) {
    setState(() {
      ventas.removeAt(index);
    });
  }

  void _editarVenta(int index) {
    setState(() {
      ventas[index].productos.add(Producto(nombre: "Pan de yema", precio: 0.8));
      ventas[index] =
          Venta(id: ventas[index].id, productos: ventas[index].productos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ventas")),
      body: ventas.isEmpty
          ? Center(child: Text("No hay ventas registradas."))
          : ListView.builder(
              itemCount: ventas.length,
              itemBuilder: (context, index) {
                final venta = ventas[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("Venta #${venta.id} - Total: S/ ${venta.total.toStringAsFixed(2)}"),
                    subtitle: Text("Productos: ${venta.productos.map((p) => p.nombre).join(', ')}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () => _editarVenta(index)),
                        IconButton(icon: Icon(Icons.delete), onPressed: () => _eliminarVenta(index)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _crearVenta,
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
