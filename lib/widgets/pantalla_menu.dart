import 'package:flutter/material.dart';

class PantallaMenu extends StatelessWidget {
  static const String route = '/menu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Elimina la fletxa enrrere
        automaticallyImplyLeading: false,
        title: const Text(
          'Menú',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Lletres en negre
          ),
        ),
        elevation: 0, // Elimina l'ombra
        centerTitle: true,
        actions: [
          // Logo a la part superior
          Image.asset(
            'assets/LogoPLC.png',
            width: 150,
            height: 150,
          ),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            width: 250,
            height: 60,
          ),
          // Botó Monitorització TOTAL
          _botonsMenu(
            context,
            'Monitorització de variables',
            '/monitoritzacio_variables', // Ruta de la pantalla de monitorització
          ),
          const SizedBox(
            width: 250,
            height: 60,
          ),
          // Botó Monitorització Posició
          _botonsMenu(
            context,
            'Monitorització de posició',
            '/monitoritzacio_posicio', // Ruta de la pantalla de monitorització de posició
          ),
          const SizedBox(
            width: 250,
            height: 60,
          ),
          // Botó Persianes
          _botonsMenu(
            context,
            'Persianes',
            '/persianes', // Ruta de la pantalla de persianes
          ),
          const SizedBox(
            width: 250,
            height: 60,
          ),
          // Botó Toldos
          _botonsMenu(
            context,
            'Tendalls',
            '/tendalls', // Ruta de la pantalla de tendalls
          ),
          const SizedBox(
            width: 250,
            height: 60,
          ),
          // Botó Dispositius
          _botonsMenu(
            context,
            'Dipòsit',
            '/diposit', // Ruta de la pantalla de dispositius
          ),
        ]),
      ),
    );
  }

  // Funció per crear un botó del menú
  Widget _botonsMenu(BuildContext context, String text, String route) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 90, 92, 92), // Color del botó
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20, // Mida del text del botó
          ),
        ),
      ),
    );
  }
}
