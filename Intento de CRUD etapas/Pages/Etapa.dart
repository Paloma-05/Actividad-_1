import 'dart:convert';
import 'package:app_9ids2/Models/EtapasResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';


idServicio




class Etapa extends StatefulWidget {
  final int idEtapa;
  const Etapa({super.key, required this.idEtapa});

  @override
  State<Etapa> createState() => _EtapaState();
}

class _EtapaState extends State<Etapa> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController txtCodigo = TextEditingController();
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtDescripcion = TextEditingController();
  TextEditingController txtPrecio = TextEditingController();

  void fnDatosEtapa() async {
    final response = await http.post(
      Uri.parse('http://192.168.0.7:8000/api/etapas'),
      body: jsonEncode(<String, dynamic>{
        "id": widget.idEtapa,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    final servicioResponse = Etapasresponse.fromJson(responseJson);
    txtNombre.text = etapaResponse.nombre;
    txtDuracion.text = etapaResponse.duracion.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.idEtapa != 0) {
      fnDatosEtapa();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etapa Nuevo"),
      ),
      //backgroundColor: Color(0xFF00836E), // Color de fondo del AppBar
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: txtNombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor llene este campo!';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: txtDuracion,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Duracion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor llene este campo!';
                  }
                },
              ),

              /////////////////BOTON DE ACTUALIZAR//////////////////////
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    //try {   //Este Try es para cachar el error
                    final response = await http.post(
                      Uri.parse('http://192.168.0.7:8000/api/etapa/guardar'),
                      body: jsonEncode(<String, dynamic>{
                        "id": widget.idEtapa,
                        "nombre": txtNombre.text,
                        "duracion": txtDuracion.text,
                      }),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Accept': 'application/json'
                      },
                    );

                    print(response.body);

                    // Verifica que el código de estado sea 200 y el cuerpo de la respuesta contenga 'Ok'
                    if (response.statusCode == 200 &&
                        response.body.trim() == 'Ok') {
                      Navigator.pop(context);
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Ooops...!',
                        text: 'Error al guardar',
                      );
                    }
                    /*} catch (e) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Ooops...!',
                  text: 'Exception: $e',
                );
              }*/
                  }
                },
                child: Text('Guardar'),
              ),




              /////////////////BOTON DE BORRAR//////////////////////

              Visibility(
                visible: widget.idServicio != 0,
                child: TextButton(
                  onPressed: () async {
                      final response = await http.delete(
                        //Uri.parse('http://192.168.0.7:8000/api/servicio/eliminar/id=${widget.idServicio}'),
                        Uri.parse('http://192.168.0.7:8000/api/etapa/eliminar/${widget.idEtapa}'),
                        body: jsonEncode(<String, dynamic>{
                          'id': widget.idEtapa
                        }),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Accept': 'application/json',
                        },
                      );

                      print(response.body);

                      if (response.statusCode == 200 && response.body.trim() == 'Ok') {
                        Navigator.pop(context);
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Ooops...!',
                          text: 'Error al borrar: ${response.body}',
                        );
                      }

                  },
                  child: Text('Borrar'),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }


}
