//1-PER EXECUTAR EN CMD:
//2-FICAR RUTA: cd C:\Users\usuario\Desktop\TFG\NodejsServe
//3-EXECUTAR PROGRAMA: Node gateway.js
//En cas de voler fer refresh del cmd: CTRL+C
//EXECUCIÓ EN VISUAL AUTOMÀTICA AMB RUN

const mqtt = require('mqtt');
const admin = require('firebase-admin');
const serviceAccount = require('./ServiceAccountKey.json');

// Inicialitza Firebase
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://visualitzacio-dades-plc---tfg.firebaseio.com"
});

const db = admin.firestore();

const options = {
  username: 'hivemq.webclient.1745944783850',
  password: 'Q7>l%ixn$J&8Yf9cRS6G'
};

// Connecta amb el broker
//const client = mqtt.connect('mqtt://e8a334bf7e8447879d57fb57523227b9.s1.eu.hivemq.cloud:8883',options); 
const client = mqtt.connect('mqtt://localhost:1883');

// Llista de tots els tòpics que vols escoltar
const topics = [
  '/vivendes/vivenda1/sensors/sensors_temperatura_exterior/sensor1',
  '/vivendes/vivenda1/sensors/sensors_temperatura_exterior/sensor2',
  '/vivendes/vivenda1/sensors/sensors_temperatura_exterior/sensor3',
  '/vivendes/vivenda1/sensors/sensors_temperatura_interior/sensor1',
  '/vivendes/vivenda1/sensors/sensors_temperatura_interior/sensor2',
  '/vivendes/vivenda1/sensors/sensors_temperatura_interior/sensor3',
  '/vivendes/vivenda1/sensors/sensor_nivell/sensor1',
  '/vivendes/vivenda1/sensors/sensor_vent/sensor1',
  '/vivendes/vivenda1/sensors/finals_cursa/persiana1',
  '/vivendes/vivenda1/sensors/finals_cursa/persiana2',
  '/vivendes/vivenda1/sensors/finals_cursa/persiana3',
  '/vivendes/vivenda1/sensors/finals_cursa/tendal1',
  '/vivendes/vivenda1/sensors/finals_cursa/tendal2',
  '/vivendes/vivenda1/sensors/finals_cursa/tendal3',
  '/vivendes/vivenda1/sensors/finals_cursa/canaleta1',
];

// Quan el client MQTT es connecta, es fa la subscripció a tots els tòpics
client.on('connect', () => {
  console.log('Connectat al broker MQTT');

  topics.forEach((topic) => {
    client.subscribe(topic, (err) => {
      if (!err) {
        console.log(`Subscrit correctament a: ${topic}`);
      } else {
        console.error(`Error en subscripció a: ${topic}`, err.message);
      }
    });
  });
});

client.on('message', (topic, message) => {
  const data = {
    //mirar una altre forma de passar el missatge amb float
    valor: parseFloat(message.toString()),
    data: new Date()
  };

  db.collection(topic).add(data)
    .then(() => {
      console.log(`Dades enviades correctament a Firestore [${topic}]`, data);
    })
    .catch((error) => {
      console.error(`Error al guardar de [${topic}] a Firestore:`, error);
    });

  //console.log(message.toString());

});

// Escoltar Firestore i enviar al PLC via MQTT

function listenFirestoreCommands(rutactuador, nomdocu) {
  db.collection(rutactuador).doc(nomdocu).onSnapshot((doc) => {
    console.log("Modificació Firebase detectada");

    if (!doc.exists) {
      console.warn(`El document "${nomdocu}" no existeix a la col·lecció "${rutactuador}"`);
      return;
    }

    const data = doc.data();

    if (!data?.ordre) {
      console.warn(`El document "${nomdocu}" no conté el camp "values"`);
      return;
    }

    console.log("Dades rebudes:", data);
    const payload = data.ordre;
    //const payload = JSON.stringify({ ordre: data.values });
    const topicFinal = rutactuador.concat('/', nomdocu);

    console.log("Payload:", payload);
    console.log("Tòpic:", topicFinal);

    client.publish(topicFinal, payload, {}, (err) => {
      if (err) {
        console.error("Error enviant al broker:", err.message);
      } else {
        console.log("Ordre enviada correctament a:", topicFinal);
      }
    });
  });
}

console.log("Abans d'escoltar ordres a Firestore...");

listenFirestoreCommands(`/vivendes/vivenda1/actuadors`, 'actuador');
console.log("Escoltant ordres a Firestore...");
//db.collection("/vivendes/vivenda1/actuadors").doc("actuador").set({ordre:"99"});

//listenFirestoreCommands("/vivendes/vivenda1/actuadors/persianes/persiana1","ordre_directe");
//Bucle pq escolti tots els actuadors
const actuadors = {
  persianes: ['persiana1', 'persiana2', 'persiana3'],
  tendals: ['tendal1', 'tendal2', 'tendal3'],
  canaleta: ['canaleta1']
};

//Object.entries(actuadors).forEach(([tipus, noms]) => {
//noms.forEach((nom) => {
//const ruta = `/vivendes/vivenda1/actuadors/${tipus}/${nom}`;
//listenFirestoreCommands(ruta, 'ordre_directe');
// });
//  });




