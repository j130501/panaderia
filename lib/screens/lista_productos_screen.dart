import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detalle_producto_screen.dart';
import 'ventas_screen.dart';
import '../models/producto.dart';

class ListaProductosScreen extends StatefulWidget {
  @override
  _ListaProductosScreenState createState() => _ListaProductosScreenState();
}

class _ListaProductosScreenState extends State<ListaProductosScreen> {
  List<Producto> productos = [];
  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerProductos();
  }

  /// Convierte enlace de Google Drive a enlace directo
  String convertirEnlaceDriveADirecto(String enlaceDrive) {
    final regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(enlaceDrive);
    if (match != null && match.groupCount >= 1) {
      final id = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$id';
    } else {
      return enlaceDrive;
    }
  }

  /// Obtiene los productos desde Firebase Firestore
  Future<void> obtenerProductos() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('productos').get();

      setState(() {
        productos = snapshot.docs.map((doc) {
          final data = doc.data();
          final imagen = convertirEnlaceDriveADirecto(data['imagen'] ?? '');
          return Producto(
            nombre: data['nombre'] ?? 'Sin nombre',
            precio: (data['precio'] ?? 0).toDouble(),
            imagenUrl: imagen,
          );
        }).toList();
        cargando = false;
      });
    } catch (e) {
      print('Error al obtener productos: $e');
      setState(() => cargando = false);
    }
  }

  void _irADetalle(Producto producto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleProductoScreen(producto: producto),
      ),
    );
  }

  void _irAVentas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VentasScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos de la Panadería"),
        actions: [
          IconButton(onPressed: _irAVentas, icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : productos.isEmpty
              ? const Center(child: Text("No hay productos disponibles."))
              : ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final p = productos[index];
                    return ListTile(
                      leading: p.imagenUrl != null && p.imagenUrl!.isNotEmpty
                          ? Image.network(
                              p.imagenUrl!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            )
                          : const Icon(Icons.image_not_supported),
                      title: Text(p.nombre),
                      subtitle: Text("S/ ${p.precio.toStringAsFixed(2)}"),
                      onTap: () => _irADetalle(p),
                    );
                  },
                ),
    );
  }
}
