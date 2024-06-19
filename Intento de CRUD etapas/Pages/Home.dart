  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:app_9ids2/Pages/Servicio.dart';
  import 'package:http/http.dart' as http;
  import 'package:app_9ids2/Models/ServiciosResponse.dart';

  class Home extends StatefulWidget {
    const Home({super.key});

    @override
    State<Home> createState() => _HomeState();
  }

  class _HomeState extends State<Home> {
    List<Serviciosresponse> servicios = [];

    Widget _listViewServicios() {
      return ListView.builder(
        itemCount: servicios.length,
        itemBuilder: (context, index) {
          var servicio = servicios[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Servicio(idServicio: servicio.id),
                ),
              );
            },
            title: Text(servicio.codigo.toString()),
            subtitle: Text(servicio.descripcion),
          );
        },
      );
    }

    void fnObtenerServicios() async {
      try {
        var response = await http.get(
          Uri.parse('http://192.168.0.7:8000/api/servicios'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          print(response.body);

          Iterable mapServicios = jsonDecode(response.body);
          servicios = List<Serviciosresponse>.from(
            mapServicios.map((model) => Serviciosresponse.fromJson(model)),
          );

          setState(() {});
        } else {
          print('Error: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching services: $e');
      }
    }



/////////////////////////////////////Metodo de obtener Etapas//////////////////////////////////////////////////////////////////////////////
    void fnDatosEtapa() async {
      try {
        var response = await http.get(
          Uri.parse('http://192.168.0.7:8000/api/etapas'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          print(response.body);

          Iterable mapServicios = jsonDecode(response.body);
          servicios = List<Serviciosresponse>.from(
            mapServicios.map((model) => Serviciosresponse.fromJson(model)),
          );

          setState(() {});
        } else {
          print('Error: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error fetching services: $e');
      }
    }




    @override
    void initState() {
      super.initState();
      fnObtenerServicios();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Servicios'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {
                fnObtenerServicios();
              },
              itemBuilder: (BuildContext context) {
                return {'Actualizar lista'}.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            ),
          ],
        ),

        //Aqui esta el de Etapas, aqui se puede agregar otro boton
        body: _listViewServicios(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Servicio(idServicio: 0),
              ),
            );
          },
          child: Icon(Icons.add_business),
        ),
      );
    }


 
      body: Stack(
        children: [
          // Tu contenido principal aquí
          Center(child: Text('Contenido Principal')),
          // Primer botón flotante
          Positioned(
            bottom: 80.0,
            right: 10.0,

            floatingActionButton: FloatingActionButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Servicio(idServicio: 0),
              ),
            );
          },
          child: Icon(Icons.add_business),
        ),
          // Segundo botón flotante
          Positioned(
            bottom: 20.0,
            right: 10.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Servicio(idEtapa: 0),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          ),


        ],
      ),
  


    }


}


body: _listViewServicios(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Servicio(idServicio: 0),
              ),
            );
          },
          child: Icon(Icons.add_business),
        ),
