class Like {
  final int envia;
  final int recibe;

  Like({
    required this.envia,
    required this.recibe,
  });

  // Método para convertir un objeto Dart a JSON
  Map<String, dynamic> toJson() {
    return {
      'envia': envia,
      'recibe': recibe,
    };
  }
}
