class Etapasresponse{
  final int id;
  final String nombre;
  final String duracion;

  Etapasresponse(this.id,
      this.nombre,
      this.duracion);

  Etapasresponse.fromJson(Map<String, dynamic> json)
      :   id = json['id'],
        nombre = json['nombre'],
        precio = double.parse(json['duracion']);

//Si sale con comillas sería: precio = precio = double.parse(json['precio']);
//Igual si es con int o fecha se ocupa en parse



}