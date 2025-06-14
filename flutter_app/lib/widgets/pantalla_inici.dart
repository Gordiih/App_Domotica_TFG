import '/widgets/tap.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pantalla_menu.dart';
//import 'package:firebase_core/firebase_core.dart';

class PantallaInici extends StatefulWidget {
  static const String route = '/logo';

  const PantallaInici({super.key});

  @override
  State<PantallaInici> createState() => _PantallaIniciState();
}

class _PantallaIniciState extends State<PantallaInici> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  //validar el formulari i gestionar-lo.
  final TextEditingController _emailControler =
          TextEditingController(), //capturar i gestionar  valors introduïts en camps de text (Email).
      _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailControler.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'MONITORITZACIÓ SISTEMA DOMÒTIC',
            style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold // Lletres en negre
                ),
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 165, 168, 168), // Mateix to gris que el body
        elevation: 0, // Elimina l'ombra de l'AppBar
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 165, 168, 168),
          ),
          // Logo i text d'inici
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: _popupBuilder,
                  );
                },
                child: Image.asset(
                  'assets/LogoPLC.png',
                  fit: BoxFit.contain,
                  width: 350,
                  height: 350,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'INICI SESSIÓ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              const TapAnimat(), // Tap animat al centre del logo
            ],
          ),
        ],
      ),
    );
  }

//Widget pel pop-up de login
  Widget _popupBuilder(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                //decoració del camp de text
                labelText: 'usuari',
                hintText:
                    "nom d'usuari", //text d'ajuda per escriure el camp de text
              ),
              controller: _emailControler, //controlador del camp de text
              keyboardType: TextInputType.emailAddress, //tipus de teclat
              textInputAction:
                  TextInputAction.next, //acció del teclat al prémer el botó
              validator: _emailValidator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contrasenya*',
                hintText: '*******',
              ),
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) => _login(context),
              validator: _passwordValidator,
              obscureText: true,
            ),
            //BOTÓ DE LOGIN
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(2255, 165, 168, 168),
              ),
              child: const Text(
                'Inicia sessió',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                _login(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    //validació del camp de text de l'email
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern); //patró de l'email
    if (value != null && !regex.hasMatch(value)) {
      //si no compleix el patró de l'email
      return "Format de l'Email invàlid";
    } else {
      return null;
    }
  }

  String? _passwordValidator(String? value) {
    //validació del camp de text de la contrasenya
    if (value != null && value.length >= 6) return null;
    return 'La contrasenya ha de tindre més de 6 caràcters';
  }

  Future<void> _login(BuildContext context) async {
    //funció per fer login
    if (_loginFormKey.currentState!.validate()) {
      //si el formulari és vàlid
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            //es fa el log in amb email i contrasenya
            email: _emailControler.text,
            password: _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sessió iniciada correctament'),
            duration: Duration(seconds: 3),
          ),
        ); //es passen les dades dels camps de text
        // Tanca el pop-up i redirigeix a la pantalla de menú
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed(PantallaMenu.route);
      } on FirebaseAuthException catch (e) {
        //si hi ha un error al fer login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Error log in'),
          ),
        );
      }
    }
  }
}
