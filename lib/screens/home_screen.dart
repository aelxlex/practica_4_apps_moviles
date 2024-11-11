import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/evento_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Eventos'),
      ),
      body: Column(
        children: [
          const Text("Añadir Eventos"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Nombre de Evento'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _fechaController,
              decoration: const InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
              keyboardType: TextInputType.datetime,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción del evento'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final titulo = _tituloController.text;
              final fecha = DateTime.tryParse(_fechaController.text);
              final descripcion = _descripcionController.text;
              

              if (descripcion.isNotEmpty && fecha != null) {
                eventProvider.agregarEvento(titulo, fecha, descripcion);
                _tituloController.clear();
                _fechaController.clear();
                _descripcionController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ingresa un nombre, descripción y fecha válidas')),
                );
              }
            },
            child: const Text('Agregar Evento'),
          ),
          const Text(""),
          const Text("Lista de Eventos:"),
          Expanded(
            child: ListView.builder(
              itemCount: eventProvider.eventos.length,
              itemBuilder: (context, index) {
                final event = eventProvider.eventos[index];
                return ListTile(
                  title: Text(event.titulo),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.fecha.toIso8601String().split('T').first),
                      Text(event.descripcion),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      eventProvider.eliminarEvento(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
