class Producto {
  String nombre;
  double precio;
  String? imagenUrl;

  Producto({
    required this.nombre,
    required this.precio,
    this.imagenUrl,
  });
}
