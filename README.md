INFROMACIÓN DE PROYECTO: Nombre: Control y visualitzación domótica con Flutter y MQTT
Autor: Marc Gordi Perernau, Universidad: UPC ESEIAAT, Fecha: 14/07/2025

Este repositorio contiene el proyecto del Trabajo de Fin de Grado (TFG), basado en el diseño, simulación y ejecución de un sistema domótico con control y monitorización tanto local como remota. El proyecto se ha dividido en varios componentes para facilitar su comprensión y ejecución.

ESTRUCTURA DEL REPOSITORIO:
El proyecto está organizado en dos subcarpetas principales:
flutter_app/: Aplicación móvil desarrollada con Flutter y Dart.
node_gateway/: Servidor Node.js que actúa como pasarela entre el protocolo MQTT y la base de datos Firebase.

-Aplicación móvil – flutter_app/: Aplicación desarrollada con Flutter que permite visualizar el estado de la vivienda y enviar órdenes de control desde un dispositivo móvil.
REQUISITOS: Tener Flutter instalado: https://docs.flutter.dev/get-started/install
Tener conectado un dispositivo Android o utilizar un emulador o chrome
EJECUCIÓN:Abrir Visual Studio Code
Ir a Archivo > Abrir carpeta y seleccionar la carpeta flutter_app
Abrir el terminal (Ctrl + `) y ejecutar los siguientes comandos: "flutter pub get", y "flutter run"

-Servidor Node.js – node_gateway/: Servidor desarrollado en Node.js que permite enviar y recibir datos entre el PLC y Firebase usando topicos en MQTT.
REQUISITOS: Tener Node.js instalado: https://nodejs.org
EJECUCIÓN:
Abrir Visual Studio Code
Abrir la carpeta node_gateway
Abrir el terminal y ejecutar: "npm install", y "node gateway.js"

DETALLES DE LA ARQUITECTURA:
El sistema está diseñado con una arquitectura de comunicación bidireccional que conecta sensores, el PLC, un broker MQTT, la base de datos Firebase y la aplicación móvil. El archivo .gitignore evita que se suban archivos innecesarios o demasiado grandes, como los paquetes .apk.

Flujo general del sistema:
Sensores / Actuadores ⇄ PLC ⇄ MQTT ⇄ Firebase ⇄ App móvil

