import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:gluko/login/view/login_page.dart';

import '../cubit/forgetpassword_cubit.dart';


class forgetpasswordpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetpasswordCubit(),
      child: forgetpasswordview(),
    );
  }
}

class forgetpasswordview extends StatefulWidget {
  @override
  State<forgetpasswordview> createState() => _forgetpasswordviewState();
}

class  _forgetpasswordviewState extends State<forgetpasswordview>{
  final correoCtrl = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;
  final passwordCtrl = TextEditingController();
  final repeatPassCtrl = TextEditingController();


  @override
  void initState() {
    super.initState();
    
    correoCtrl.addListener(() => setState(() {}));
    passwordCtrl.addListener(() => setState(() {}));
    repeatPassCtrl.addListener(() => setState(() {}));
  }

  int _currentStep = 0;
  List<Step> getSteps() => [
    Step(
      state: _stepState(0),
      isActive: _currentStep >=0,
      title: const Text(
          'Paso 1',
          style: TextStyle(color: Colors.black, fontSize: 15)
        ),
      subtitle: const Text(
        'Ingresa tu correo',
        style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/100)),
          TextFormField(
            controller: correoCtrl,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              hintText: 'name@example.com',
              labelText: 'Correo',
              contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
              prefixIcon: const Icon(Icons.email_outlined, color: Colors.black45),
              suffixIcon: correoCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => correoCtrl.clear(),),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none
              ),
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      )
    ),
    Step(
      state: _stepState(1),
      isActive: _currentStep >=1,
      title: const Text(
          'Paso 2',
          style: TextStyle(color: Colors.black, fontSize: 15)
      ),
      subtitle: const Text(
          'Codigo de verificación',
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
      ),
      content: const SizedBox(
        width: 110,
        height: 100,
      )
    ),
    Step(
      state: _stepState(2),
      isActive: _currentStep >=2,
      title: const Text(
          'Paso 3',
          style: TextStyle(color: Colors.black, fontSize: 15)
      ),
      subtitle: const Text(
          'Contraseña nueva',
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/100)),
          TextFormField(
            controller: passwordCtrl,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Contraseña nueva',
              errorText: passwordCtrl.text.isEmpty || passwordCtrl.text.length > 7 ? null : 'Contraseña invalida',
              suffixIcon: IconButton(
                  icon: isPasswordVisible ? const Icon(Icons.visibility_off, color: Colors.black45) : const Icon(Icons.visibility, color: Colors.black45),
                onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none
              ),
              helperText: ('Utilice al menos 8 caracteres'),
              helperStyle: TextStyle(fontSize: 11)
            ),
            obscureText: isPasswordVisible,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          TextFormField(
            controller: repeatPassCtrl,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              labelText: 'Confirmar contraseña',
              errorText: passwordCtrl.text != repeatPassCtrl.text ? 'Contraseñas no coinciden' : null,
              suffixIcon: IconButton(
                icon: isPasswordVisible2 ? const Icon(Icons.visibility_off, color: Colors.black45) : const Icon(Icons.visibility, color: Colors.black45),
                onPressed: () => setState(() => isPasswordVisible2 = !isPasswordVisible2),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
              border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none
              ),
            ),
            obscureText: isPasswordVisible2,
          ),
        ],
      )
    )
  ];

  StepState _stepState (int step) {
    if(_currentStep > step) {
      return StepState.complete;
    } else if (_currentStep == step) {
      return StepState.editing;
    } else {
      return StepState.indexed;
    }
  }

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  void submitFormulario () {

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorsGenerals().lightgrey,
      appBar: AppBar(
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Loginpage()
                ), (Route<dynamic> route) => false
            );
          },
        ),
        title: const Text(
          " Recuperar contraseña ",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: BlocBuilder<ForgetpasswordCubit, ForgetpasswordState>(
        builder: (context, states) {
          switch (states.status) {
            case Forgetpasswordtatus.loading:
              return const Center(child: CircularProgressIndicator());
              break;
            case Forgetpasswordtatus.success:
              return Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stepper(
                  currentStep: _currentStep,
                  onStepContinue: () {
                    final isLastStep = _currentStep == getSteps().length - 1;
                    if(isLastStep) {
                      //Boton con confirmar, guardar datos enviarlos a back y limpiar campos
                    } else if (_currentStep == 0){
                        if (correoCtrl.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.black45,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: const Text(
                                      "Ingrese un correo",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              )
                          );
                        } else if (!validateEmail(correoCtrl.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  child: const Text(
                                    "Debe ingresar un correo valido",
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              )
                          );
                        } else {
                          setState(() => _currentStep += 1);
                        }
                    } else {
                      setState(() => _currentStep += 1);
                    }
                  },
                  onStepTapped: (step) => setState(() => _currentStep = step),
                  onStepCancel: () {
                      _currentStep == 0 ? null : () => setState(()  => _currentStep -= 1);
                  },
                  controlsBuilder: (BuildContext context, ControlsDetails details) {
                      final isLastStep = _currentStep == getSteps().length - 1;
                      return Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                 ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20), // radio de la esquina redondeada
                                    ),
                                    backgroundColor: Colors.red, // color de fondo
                                  ),
                                  child: Text(isLastStep ? 'Confirmar' : 'Continuar', style: const TextStyle(fontSize: 17),),
                                ),
                                const SizedBox(width: 12,)
                              ]
                          )
                      );
                  },
                  steps: getSteps(),
                )
              );
              break;
            case Forgetpasswordtatus.error:
              return const Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}