import 'package:flutter/material.dart';

class PantallaDiposit extends StatelessWidget {
  static const String route = '/diposit';
  const PantallaDiposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dipòsit',
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
    );
  }
}
