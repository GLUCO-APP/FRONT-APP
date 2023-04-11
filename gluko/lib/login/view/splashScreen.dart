import 'package:flutter/material.dart';
import '../../colors/colorsGenerals.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationOffset;
  late Animation<double> _animationSize;

  @override
  void initState() {
    super.initState();

    // Inicializa la animación
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6), // Duración de la animación
    );

    // Define la animación
    _animationOffset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, -1), // Desplazamiento hacia arriba
    ).animate(_animationController);

    _animationSize = Tween<double>(begin: 100, end: 900) // Agregamos una nueva animación
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    // Inicia la animación
    _animationController.forward();

    // Actualiza el estado del widget en cada cambio de la animación
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Contenedor que se anima hacia arriba
          Positioned(
            bottom: _animationOffset.value.dy *
                -MediaQuery.of(context).size.height,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: ColorsGenerals().lightgrey,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0, -1),
                    blurRadius: 12,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  "assets/Logo/logo.png",
                  height: _animationSize.value, // Usamos la nueva animación para ajustar el tamaño
                  width: _animationSize.value,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Detiene el controlador de animación cuando se destruye el widget
    _animationController.dispose();
    super.dispose();
  }
}
