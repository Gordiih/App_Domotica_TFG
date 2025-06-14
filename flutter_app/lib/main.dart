//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'widgets/pantalla_menu.dart';
import 'widgets/pantalla_inici.dart';
import 'widgets/pantalla_configuracio_horaria.dart';
import 'widgets/pantalla_monitoritzacio_posicio.dart';
import 'widgets/pantalla_monitoritzacio_variables.dart';
import 'widgets/pantalla_persianes.dart';
import 'widgets/pantalla_tendalls.dart';
import 'widgets/pantalla_diposit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: const Color.fromARGB(255, 141, 137, 124),
        scaffoldBackgroundColor:
            const Color.fromARGB(255, 165, 168, 168), // Fons gris clar global
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(
              255, 165, 168, 168), // Color gris clar per a totes les AppBar
          titleTextStyle: TextStyle(
            color: Colors.black, // Lletres en negre
            fontWeight: FontWeight.bold, // Lletres més gruixudes
            fontSize: 20, // Mida del text
          ),
        ),
      ),
      //home: const PantallaInici(),
      //RUTES:
      //si usuari loggejat va a la pantalla de visualització, sinó a la de login
      /* initialRoute: FirebaseAuth.instance.currentUser != null
          ? PantallaVisualitzacio.route
          : PantallaInici.route,*/
      initialRoute: PantallaInici.route,
      //rutes de l'aplicació
      routes: {
        PantallaInici.route: (context) => const PantallaInici(),
        PantallaMenu.route: (context) => PantallaMenu(),
        PantallaConfiguracioHoraria.route: (context) =>
            const PantallaConfiguracioHoraria(),
        PantallaMonitoritzacioVariables.route: (context) =>
            const PantallaMonitoritzacioVariables(),
        PantallaMonitoritzacioPosicio.route: (context) =>
            const PantallaMonitoritzacioPosicio(),
        PantallaPersianes.route: (context) => const PantallaPersianes(),
        PantallaTendalls.route: (context) => const PantallaTendalls(),
        PantallaDiposit.route: (context) => const PantallaDiposit(),
      },
    );
  }
}
