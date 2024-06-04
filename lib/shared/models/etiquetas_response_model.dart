class EtiquetasResponse {
  final List<String> etiquetas;

  EtiquetasResponse({required this.etiquetas});

  factory EtiquetasResponse.fromJson(Map<String, dynamic> json) {
    return EtiquetasResponse(
      etiquetas: List<String>.from(json['etiquetas']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'etiquetas': etiquetas,
    };
  }
}