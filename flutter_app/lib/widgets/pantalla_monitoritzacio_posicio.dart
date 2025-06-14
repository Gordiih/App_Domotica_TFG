import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaMonitoritzacioPosicio extends StatefulWidget {
  static const String route = '/monitoritzacio_posicio';

  const PantallaMonitoritzacioPosicio({super.key});

  @override
  State<PantallaMonitoritzacioPosicio> createState() =>
      _PantallaMonitoritzacioPosicioState();
}

class _PantallaMonitoritzacioPosicioState
    extends State<PantallaMonitoritzacioPosicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monitorització Posició',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Text en negreta
          ),
        ),
        elevation: 0, // Elimina l'ombra de l'AppBar
        centerTitle: true, // Centra el títol
        actions: [
          Image.asset(
            'assets/LogoPLC.png', // Logo a la part superior dreta
            width: 150,
            height: 150,
          ),
        ],
      ),
      body: _bodybuilder(),
    );
  }

  // Contingut principal de la pantalla
  Widget _bodybuilder() {
    return ListView(
      padding: const EdgeInsets.all(16), // Espai al voltant de la llista
      children: [
        const Text(
          'Persianes',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // Títol de la secció
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/persiana1',
          'fc_abaix',
          'fc_adalt',
          'Persiana 1',
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/persiana2',
          'fc_abaix',
          'fc_adalt',
          'Persiana 2',
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/persiana3',
          'fc_abaix',
          'fc_adalt',
          'Persiana 3',
        ),
        const SizedBox(height: 20), // Espai entre seccions
        const Text(
          'Tendals',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // Títol de la secció
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/tendal1',
          'fc_abaix',
          'fc_adalt',
          'Tendal 1',
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/tendal2',
          'fc_abaix',
          'fc_adalt',
          'Tendal 2',
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/tendal3',
          'fc_abaix',
          'fc_adalt',
          'Tendal 3',
        ),
        const SizedBox(height: 20), // Espai entre seccions
        const Text(
          'Canaleta',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // Títol de la secció
        ),
        _filaInterruptors(
          'vivendes/vivenda1/sensors/finals_cursa/canaleta1',
          'fc_desguas',
          'fc_diposit',
          'Canaleta',
        ),
      ],
    );
  }

  //Widget que crea una fila per cada interruptor (document)
  Widget _filaInterruptors(
      String topic, String document1, String document2, String sensorName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centra les columnes
      children: [
        _interruptorSensor(topic, document1, '$sensorName - ABAIX'),
        const SizedBox(width: 20), // Espai entre les columnes
        _interruptorSensor(topic, document2, '$sensorName - ADALT'),
      ],
    );
  }

  //Widget que mira l'estat de l'interruptor a Firebase
  Widget _interruptorSensor(String topic, String document, String label) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection(
              topic) // Accedeix a la col·lecció especificada pel `topic`.
          .doc(document) // Accedeix al document especificat.
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Mostra un indicador de càrrega
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Mostra un missatge d'error
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text(
              '$label: No hi ha dades'); // Mostra un missatge si no hi ha dades
        } else {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final isOn = data['valor'] == 1; // Comprova si el valor és 1 (ON)

          return Column(
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 14)), // Mostra el nom del sensor
              Switch(
                value: isOn, // Estat del sensor (ON/OFF)
                onChanged: null, // Desactiva la modificació de l'interruptor
              ),
            ],
          );
        }
      },
    );
  }
}
