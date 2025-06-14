import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PantallaMonitoritzacioVariables extends StatelessWidget {
  static const String route = '/monitoritzacio_variables';
  const PantallaMonitoritzacioVariables({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pantalla de Monitorització',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          Image.asset(
            'assets/LogoPLC.png',
            width: 150,
            height: 150,
          ),
        ],
      ),
      body: _bodybuilder(),
    );
  }

  Widget _bodybuilder() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Temperatura Exterior',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensors_temperatura_exterior/sensor1',
            'Sensor 1'),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensors_temperatura_exterior/sensor2',
            'Sensor 2'),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensors_temperatura_exterior/sensor3',
            'Sensor 3'),
        const SizedBox(height: 20),
        const Text('Temperatura Interior',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensors_temperatura_interior/sensor1',
            'Sensor 1'),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensors_temperatura_interior/sensor2',
            'Sensor 2'),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensors_temperatura_interior/sensor3',
            'Sensor 3'),
        const SizedBox(height: 20),
        const Text('Sensor Nivell',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _sensorContainer('vivendes/vivenda1/sensors/sensor_nivell/sensor1',
            'Sensor Nivell 1'),
        const SizedBox(height: 20),
        const Text('Sensor Vent',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        _sensorContainer(
            'vivendes/vivenda1/sensors/sensor_vent/sensor1', 'Sensor Vent 1'),
      ],
    );
  }

  Widget _sensorContainer(String collectionPath, String sensorName) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(collectionPath)
              .orderBy('data', descending: true)
              .limit(1)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('$sensorName: No hi ha dades disponibles');
            } else {
              final data =
                  snapshot.data!.docs.first.data() as Map<String, dynamic>;
              final valor = data['valor'] ?? 'Desconegut';
              final dataHora = (data['data'] as Timestamp).toDate();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sensorName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Valor: $valor',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Data: ${dataHora.day.toString().padLeft(2, '0')}/${dataHora.month.toString().padLeft(2, '0')}/${dataHora.year} '
                    '${dataHora.hour.toString().padLeft(2, '0')}:${dataHora.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
