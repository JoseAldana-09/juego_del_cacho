import 'package:flutter/material.dart';

class CachoTableroApp extends StatelessWidget {
  const CachoTableroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CachoTablero(),
    );
  }
}

void main() {
  runApp(const CachoTableroApp());
}

class CachoTablero extends StatefulWidget {
  const CachoTablero({super.key});

  @override
  State<CachoTablero> createState() => _CachoTableroState();
}

class _CachoTableroState extends State<CachoTablero> {
  int balas = 0;
  int tontos = 0;
  int tricas = 0;
  int cuadras = 0;
  int quinas = 0;
  int senas = 0;
  String escalera = "0 pts";
  String full = "0 pts";
  String poker = "0 pts";
  String grandeDormida = "";

  void botonIncremento(String nombre) {
    setState(() {
      switch (nombre) {
        case "Balas":
          balas = (balas == 5) ? 0 : balas + 1;
          break;
        case "Tontos":
          tontos = (tontos == 10) ? 0 : tontos + 2;
          break;
        case "Tricas":
          tricas = (tricas == 15) ? 0 : tricas + 3;
          break;
        case "Cuadras":
          cuadras = (cuadras == 20) ? 0 : cuadras + 4;
          break;
        case "Quinas":
          quinas = (quinas == 25) ? 0 : quinas + 5;
          break;
        case "Senas":
          senas = (senas == 30) ? 0 : senas + 6;
          break;
      }
    });
  }

  // Función para manejar las opciones de escalera, full y poker
  void manejarOpcionesEspeciales(String categoria, String tipo) {
    setState(() {
      switch (categoria) {
        case "Escalera":
          escalera = (tipo == "De huevo") ? "20 pts" : "25 pts";
          break;
        case "Full":
          full = (tipo == "De huevo") ? "30 pts" : "35 pts";
          break;
        case "Poker":
          poker = (tipo == "De huevo") ? "40 pts" : "45 pts";
          break;
      }
    });
  }

  // Crear un botón con la lógica de incremento
  Widget crearBoton(String nombre, int valor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
          ),
          onPressed: () => botonIncremento(nombre),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nombre,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "$valor pts",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget crearBotonEspecial(String nombre, String valor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(18),
          ),
          onPressed: () => _mostrarOpcionesEspeciales(nombre),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nombre,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                valor,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarOpcionesEspeciales(String categoria) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Seleccionar opción para $categoria"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  manejarOpcionesEspeciales(categoria, "De huevo");
                  Navigator.of(context).pop();
                },
                child: const Text("De huevo"),
              ),
              ElevatedButton(
                onPressed: () {
                  manejarOpcionesEspeciales(categoria, "De mano");
                  Navigator.of(context).pop();
                },
                child: const Text("De mano"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Juan José Aldana Rodriguez\n"Juego Tablero de Cacho"',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                crearBoton("Balas", balas),
                crearBotonEspecial("Escalera", escalera),
                crearBoton("Cuadras", cuadras),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                crearBoton("Tontos", tontos),
                crearBotonEspecial("Full", full),
                crearBoton("Quinas", quinas),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                crearBoton("Tricas", tricas),
                crearBotonEspecial("Poker", poker),
                crearBoton("Senas", senas),
              ],
            ),
          ),
          const SizedBox(
              height:
                  20), // Espacio entre el tablero y el botón "Grande/Dormida"
          ElevatedButton(
            onPressed: () => print("Grande/Dormida"),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Grande / Dormida",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
