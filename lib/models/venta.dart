import 'producto.dart';

class Venta {
  int id;
  List<Producto> productos;
  double total;

  Venta({required this.id, required this.productos})
      : total = productos.fold(0, (sum, p) => sum + p.precio);
}
