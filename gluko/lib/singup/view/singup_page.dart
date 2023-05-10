import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko/profile/view/profile_page.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:intl/intl.dart';
import '../../colors/colorsGenerals.dart';
import 'package:gluko/login/view/login_page.dart';
import '../cubit/singup_cubit.dart';
import 'package:gluko_repository/src/models/insulin.dart';

enum SexTypeEnum {masculino, femenino}

extension SexTypeExtension on SexTypeEnum {
  String get value {
    switch (this) {
      case SexTypeEnum.masculino:
        return "Masculino";
      case SexTypeEnum.femenino:
        return "Femenino";
      default:
        throw Exception("Valor no válido en SexTypeEnum");
    }
  }
}

class ButtonData {
  final int id;
  final String name;
  final String image;

  ButtonData(this.id, this.name, this.image);
}

class Singuppage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingupCubit(SignUpRepository(), EmailValidateRepository(), allinsulinRepository())..listInsulin(),
      child: Singupview(),
    );
  }
}

// usuario
User usuario = User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "", "");
List<Insulin> listInsulinR = [];
List<Insulin> pruebaR = [];
List<Insulin> listInsulinB = [];
List<Insulin> pruebaL = [];

class Singupview extends StatefulWidget {
  @override
  State<Singupview> createState() => _SingupviewState();
}

class  _SingupviewState extends State<Singupview>{

  Future<void> showMyPopupComplete(BuildContext context, var response) async {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width/3,
            height: MediaQuery.of(context).size.height/1.3,
            color: Colors.transparent,
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                          color: ColorsGenerals().whith,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(-5, 6),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              response.message,
                              style: TextStyle(fontSize: 20.0),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            ElevatedButton(
                              child: const Text('Continuar', style: TextStyle(color: Colors.white)),
                              onPressed: (){
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Loginpage()),
                                      (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        )
                    ),
                  ]
              ),
            ),
          ),
        );
      },
    );
  }

  _SingupviewState(){
  }

  // primer paso
  final correoCtrl = TextEditingController();
  String code = '';
  // segundo paso
  final codeCtrl = TextEditingController();
  // tercer paso
  final passwordCtrl = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;
  // cuarto paso
  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final bornCtrl = TextEditingController();
  final dateDCtrl = TextEditingController();
  var _sexTypeEnum = SexTypeEnum.masculino;
  DateTime? newDateD;
  DateTime? newDateN;
  //septimo paso
  int _selectMed = 0;
  //octavo paso
  final hiperCtrl = TextEditingController();
  final normCtrl = TextEditingController();
  final hipoCtrl = TextEditingController();
  final carboOCtrl = TextEditingController();
  //noveno paso
  final pesoCtrl = TextEditingController();
  //decimo paso
  final alturaCtrl = TextEditingController();
  // 11 paso
  final senbCtrl = TextEditingController();
  final ratioCtrl = TextEditingController();
  // 12 paso
  String? _selectedInsulinR = "Humulin R Cristalina";
  int _selectPR = 0;
  String? _selectedInsulinL = "Delemir Levemir";
  int _selectPL = 0;
  final ctrHoraInsulinL = TextEditingController();
  // 13 paso
  final horaInicioDesayunoCtrl = TextEditingController();
  final horaFinalDesayunoCtrl = TextEditingController();
  final horaInicioAlmuerzoCtrl = TextEditingController();
  final horaFinalAlmuerzoCtrl = TextEditingController();
  final horaInicioCenaCtrl = TextEditingController();
  final horaFinalCenaCtrl = TextEditingController();
  // 14 paso
  int _selectedButtonA = -1;
  final List<ButtonData> _buttons = [
    ButtonData(0, "Sedentarismo", "assets/Icons/Relajante1.png"),
    ButtonData(1, "1-3 dias por semana", "assets/Icons/Triangulo1.png"),
    ButtonData(2, "3-5 dias por semana", "assets/Icons/Corriendo1.png"),
    ButtonData(3, "5-7 dias por semana", "assets/Icons/Deporte1.png")
  ];
  // 15 paso
  int _selectUser = 0;



  @override
  void initState() {
    super.initState();
    clean();
    _currentStep = 0;
    // primer paso
    correoCtrl.addListener(() => setState(() {}));
    // segundo paso
    codeCtrl.addListener(() => setState(() {}));
    // tercer paso
    passwordCtrl.addListener(() => setState(() {}));
    // cuarto paso
    nombreCtrl.addListener(() => setState(() {}));
    apellidoCtrl.addListener(() => setState(() {}));
    bornCtrl.addListener(() => setState(() {}));
    dateDCtrl.addListener(() => setState(() {}));
    // octavo paso
    hiperCtrl.addListener(() => setState(() {}));
    normCtrl.addListener(() => setState(() {}));
    hipoCtrl.addListener(() => setState(() {}));
    carboOCtrl.addListener(() => setState(() {}));
    // noveno paso
    pesoCtrl.addListener(() => setState(() {}));
    // decimo paso
    alturaCtrl.addListener(() => setState(() {}));
    // 11 paso
    ratioCtrl.addListener(() => setState(() {}));
    senbCtrl.addListener(() => setState(() {}));
    // 12 paso
    ctrHoraInsulinL.addListener(() => setState(() {}));
    // 13 paso
    horaInicioDesayunoCtrl.addListener(() => setState(() {}));
    horaFinalDesayunoCtrl.addListener(() => setState(() {}));
    horaInicioAlmuerzoCtrl.addListener(() => setState(() {}));
    horaFinalAlmuerzoCtrl.addListener(() => setState(() {}));
    horaInicioCenaCtrl.addListener(() => setState(() {}));
    horaFinalCenaCtrl.addListener(() => setState(() {}));
  }

  int _currentStep = 0;
  List<Step> getSteps() => [
    Step(
        state: _stepState(0),
        isActive: _currentStep >=0,
        title: const Text(
            'Correo Electronico',
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
            'Codigo de verificación',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/100)),
            TextFormField(
              controller: codeCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                FilteringTextInputFormatter.allow(RegExp(r'\d')),
              ],
              decoration: InputDecoration(
                filled: true,
                labelText: 'Codigo',
                helperText: ('Ingrese el codigo que llego a su correo'),
                helperStyle: const TextStyle(fontSize: 11),
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                suffixIcon: codeCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => codeCtrl.clear(),),
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
        state: _stepState(2),
        isActive: _currentStep >=2,
        title: const Text(
            'Contraseña',
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
                  helperStyle: const TextStyle(fontSize: 11)
              ),
              obscureText: isPasswordVisible,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          ],
        )
    ),
    Step(
        state: _stepState(3),
        isActive: _currentStep >=3,
        title: const Text(
            'Datos personales',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/100)),
            TextFormField(
              controller: nombreCtrl,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Nombre',
                  contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none
                  ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            TextFormField(
              controller: apellidoCtrl,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                labelText: 'Apellidos',
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            const Text(
                "Sexo",
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            Row(
              children: [
                Expanded(
                    child: RadioListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      title: const Text("Hombre", style: TextStyle(color: Colors.black, fontSize: 15),),
                      groupValue: _sexTypeEnum,
                      activeColor: Colors.red,
                      value: SexTypeEnum.masculino,
                      onChanged: (val) {
                        setState(() {
                          _sexTypeEnum = val!;
                        });
                      }
                    ),
                ),
                Expanded(
                    child: RadioListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                      title: const Text("Mujer", style: TextStyle(color: Colors.black, fontSize: 15),),
                      groupValue: _sexTypeEnum,
                      activeColor: Colors.red,
                      value: SexTypeEnum.femenino,
                      onChanged: (val) {
                        setState(() {
                          _sexTypeEnum = val!;
                        });
                      }
                    ),
                ),
              ],
            ),
            const Text(
              "Sexo al nacer, te preguntamos el sexo al nacer por razones medicas.",
              style: TextStyle(fontSize: 11, color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: bornCtrl,
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Fecha de nacimiento',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                          contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none
                          ),
                        ),
                        enabled: false,

                      ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.date_range_outlined, color: Colors.black45),
                    onPressed: () async {
                      newDateN = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now()
                      );
                      if(newDateN == null) return;
                      setState(() => bornCtrl.text = DateFormat.yMd().format(newDateN!));
                    },
                  )
                ],
              )
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: dateDCtrl,
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Fecha de diagnostico',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                          contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none
                          ),
                        ),
                        enabled: false,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.date_range_outlined, color: Colors.black45),
                      onPressed: () async {
                        newDateD = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now()
                        );
                        if(newDateD == null) return;
                        setState(() => dateDCtrl.text = DateFormat.yMd().format(newDateD!));
                      },
                    )
                  ],
                )
            ),
          ],
        )
    ),
    Step(
        state: _stepState(4),
        isActive: _currentStep >=4,
        title: const Text(
            'Tipo de Diabetes',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Por el momento, esta aplicación esta enfocada en el tratamiento de diabetes tipo 1",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        )
    ),
    Step(
        state: _stepState(5),
        isActive: _currentStep >=5,
        title: const Text(
            'Tratamiento',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Por el momento, esta aplicación esta enfocada en el tratamiento con bolígrafo / jeringas",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        )
    ),
    Step(
        state: _stepState(6),
        isActive: _currentStep >=6,
        title: const Text(
            'Medicamentos',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Text(
              "¿Utilizas medicamentos junto a tu tratamiento de diabetes?",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            ToggleButtons(
              selectedBorderColor: Colors.red,
              borderRadius: BorderRadius.circular(20),
              borderWidth: 2,
              isSelected: [
                _selectMed == 0,
                _selectMed == 1,
              ],
              onPressed: (int newIndex) {
                setState(() {
                  _selectMed = newIndex;
                });
              },
              children: const [
                Text(
                    "Si",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  "No",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ]
            )
          ],
        )
    ),
    Step(
        state: _stepState(7),
        isActive: _currentStep >=7,
        title: const Text(
            'Objetivos',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Text(
              "Indica tus objetivos de glucometria",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            TextFormField(
              controller: hiperCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.red, fontSize: 15),
              validator: (value){
                final n = int.tryParse(value!);
                if( n == null || n < 1 || n > 520) {
                  return 'El valor debe estar entre 1 y 520';
                }
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Hiperglucemia',
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                suffixIcon: hiperCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => hiperCtrl.clear(),),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none
                ),
              ),
              textInputAction: TextInputAction.done,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            TextFormField(
              controller: normCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.green, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                labelText: 'Rango deseado',
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                suffixIcon: normCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.green), onPressed: () => normCtrl.clear(),),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none
                ),
              ),
              textInputAction: TextInputAction.done,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            TextFormField(
              controller: hipoCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                labelText: 'Hipoglucemia',
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                suffixIcon: hipoCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.lightBlue), onPressed: () => hipoCtrl.clear(),),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none
                ),
              ),
              textInputAction: TextInputAction.done,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            const Text(
              "Indica tus objetivo de carbohidratos diarios en gramos",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            TextFormField(
              controller: carboOCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black45, fontSize: 15),
              validator: (value){
                final n = int.tryParse(value!);
                if( n == null || n < 1) {
                  return 'El valor debe ser mayor a 1';
                }
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Carbohidratos',
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                suffixIcon: carboOCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => carboOCtrl.clear(),),
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
        state: _stepState(8),
        isActive: _currentStep >=8,
        title: const Text(
            'Peso',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Text(
              "¿Cual es tu peso corporal en kilogramos?",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextFormField(
                      controller: pesoCtrl,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black45, fontSize: 15),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Peso',
                        hintText: '60.7',
                        contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                        suffixIcon: pesoCtrl.text.isEmpty ? Container(width: 0) :
                        IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => pesoCtrl.clear(),),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                ),
              ]
            ),
          ],
        )
    ),
    Step(
        state: _stepState(9),
        isActive: _currentStep >=9,
        title: const Text(
            'Altura',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Text(
              "¿Cual es tu altura corporal en centimetros?",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: alturaCtrl,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black45, fontSize: 15),
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Altura',
                        hintText: '175',
                        contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
                        suffixIcon: alturaCtrl.text.isEmpty ? Container(width: 0) :
                        IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => alturaCtrl.clear(),),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ]
            ),
          ],
        )
    ),
    Step(
        state: _stepState(10),
        isActive: _currentStep >=10,
        title: const Text(
            'Sensibilidad y Ratio',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const Text(
              "Inidica el ratio de insulina / HC por horas",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: ratioCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black45, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                labelText: 'Ratio',
                helperText: "Cantidad de carbohidratos que se cubren con 1 unidad de insulina",
                helperMaxLines: 3,
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                suffixIcon: ratioCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => ratioCtrl.clear(),),
                border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none
                ),
              ),
              textInputAction: TextInputAction.done,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            const Text(
              "Inidica tu sensibilidad de insulina",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: senbCtrl,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black45, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                labelText: 'Sensibilidad',
                helperText: "Cantidad de glucemia que se reduce con 1 unidad de insulina",
                helperMaxLines: 3,
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                suffixIcon: senbCtrl.text.isEmpty ? Container(width: 0) :
                IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => senbCtrl.clear(),),
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
        state: _stepState(11),
        isActive: _currentStep >=11,
        title: const Text(
            'Tipo de insulina',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedInsulinR,
              items: listInsulinR.toSet().map((e) =>
                DropdownMenuItem(
                  value: e.name,
                  child: Text(e.name),)
              ).toList(),
              onChanged: (value){
                setState(() {
                  _selectedInsulinR = value!;
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down
              ),
              decoration: const InputDecoration(
                labelText: "Insulina Rapida",
                  prefixIcon: Icon(
                      Icons.edit
                  )
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/200)),
            const Text(
              "Precisión",),
            ToggleButtons(
                selectedBorderColor: Colors.red,
                borderRadius: BorderRadius.circular(20),
                borderWidth: 2,
                isSelected: [
                  _selectPR == 0,
                  _selectPR == 1,
                ],
                onPressed: (int newIndex) {
                  setState(() {
                    _selectPR = newIndex;
                  });
                },
                children: const [
                  Text(
                    "1",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "0.5",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ]
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/100)),
            DropdownButtonFormField<String>(
              value: _selectedInsulinL,
              items: listInsulinB.toSet().map((e) =>
                  DropdownMenuItem(
                    value: e.name,
                    child: Text(e.name),)
              ).toList(),
              onChanged: (value){
                setState(() {
                  _selectedInsulinL = value!;
                });
              },
              icon: const Icon(
                  Icons.arrow_drop_down
              ),
              decoration: const InputDecoration(
                  labelText: "Insulina Lenta",
                prefixIcon: Icon(
                  Icons.edit
                )
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/200)),
            const Text(
              "Precisión",),
            ToggleButtons(
                selectedBorderColor: Colors.red,
                borderRadius: BorderRadius.circular(20),
                borderWidth: 2,
                isSelected: [
                  _selectPL == 0,
                  _selectPL == 1,
                ],
                onPressed: (int newIndex) {
                  setState(() {
                    _selectPL = newIndex;
                  });
                },
                children: const [
                  Text(
                    "1",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "0.5",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ]
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/100)),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: ctrHoraInsulinL,
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Hora aplicación insulina basal',
                          labelStyle: const TextStyle(color: Colors.black, fontSize: 10),
                          contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none
                          ),
                        ),
                        enabled: false,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time, color: Colors.black45),
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                        );
                        if(newTime == null) return;
                        setState(() => ctrHoraInsulinL.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                      },
                    )
                  ],
                )
            ),
          ],
        )
    ),
    Step(
        state: _stepState(12),
        isActive: _currentStep >=12,
        title: const Text(
            'Horario de comidas principales',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(242, 243, 247, 100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3)
                        )
                      ]
                    ),
                    child: IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/Icons/desayuno.png", height: MediaQuery.of(context).size.height/14),
                            const Text("DESAYUNO"),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: horaInicioDesayunoCtrl,
                                    style: const TextStyle(color: Colors.black, fontSize: 15),
                                    decoration: InputDecoration(
                                        filled: true,
                                        labelText: 'Inicio',
                                        labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              bottomLeft: Radius.circular(20.0)
                                          ),
                                        ),
                                        prefixIcon: IconButton(
                                          icon: const Icon(Icons.access_time, color: Colors.black45),
                                          onPressed: () async {
                                            TimeOfDay? newTime = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            );
                                            if(newTime == null) return;
                                            setState(() => horaInicioDesayunoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                                          },
                                        )
                                    ),
                                    enabled: true,
                                  ),
                                ),
                                Expanded(
                                    child: TextFormField(
                                      controller: horaFinalDesayunoCtrl,
                                      style: const TextStyle(color: Colors.black, fontSize: 15),
                                      decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Final',
                                          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20.0),
                                                bottomRight: Radius.circular(20.0)
                                            ),
                                          ),
                                          prefixIcon: IconButton(
                                            icon: const Icon(Icons.access_time, color: Colors.black45),
                                            onPressed: () async {
                                              TimeOfDay? newTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if(newTime == null) return;
                                              setState(() => horaFinalDesayunoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                                            },
                                          )
                                      ),
                                    )
                                )
                              ],
                            ),
                          ],
                        )
                    )

                  ),
                ]
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(242, 243, 247, 100),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3)
                            )
                          ]
                      ),
                      child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/Icons/comida.png", height: MediaQuery.of(context).size.height/14),
                              const Text("ALMUERZO"),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: horaInicioAlmuerzoCtrl,
                                      style: const TextStyle(color: Colors.black, fontSize: 15),
                                      decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Inicio',
                                          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                bottomLeft: Radius.circular(20.0)
                                            ),
                                          ),
                                          prefixIcon: IconButton(
                                            icon: const Icon(Icons.access_time, color: Colors.black45),
                                            onPressed: () async {
                                              TimeOfDay? newTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if(newTime == null) return;
                                              setState(() => horaInicioAlmuerzoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                                            },
                                          )
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                        controller: horaFinalAlmuerzoCtrl,
                                        style: const TextStyle(color: Colors.black, fontSize: 15),
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Final',
                                            labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20.0),
                                                  bottomRight: Radius.circular(20.0)
                                              ),
                                            ),
                                            prefixIcon: IconButton(
                                              icon: const Icon(Icons.access_time, color: Colors.black45),
                                              onPressed: () async {
                                                TimeOfDay? newTime = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if(newTime == null) return;
                                                setState(() => horaFinalAlmuerzoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                                              },
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          )
                      )
                  ),
                ]
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(242, 243, 247, 100),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3)
                            )
                          ]
                      ),
                      child: IntrinsicWidth(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/Icons/cena.png", height: MediaQuery.of(context).size.height/14),
                              const Text("CENA"),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: horaInicioCenaCtrl,
                                      style: const TextStyle(color: Colors.black, fontSize: 15),
                                      decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Inicio',
                                          labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                bottomLeft: Radius.circular(20.0)
                                            ),
                                          ),
                                          prefixIcon: IconButton(
                                            icon: const Icon(Icons.access_time, color: Colors.black45),
                                            onPressed: () async {
                                              TimeOfDay? newTime = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if(newTime == null) return;
                                              setState(() => horaInicioCenaCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                                            },
                                          )
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                        controller: horaFinalCenaCtrl,
                                        style: const TextStyle(color: Colors.black, fontSize: 15),
                                        decoration: InputDecoration(
                                            filled: true,
                                            labelText: 'Final',
                                            labelStyle: const TextStyle(color: Colors.black, fontSize: 15),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20.0),
                                                  bottomRight: Radius.circular(20.0)
                                              ),
                                            ),
                                            prefixIcon: IconButton(
                                              icon: const Icon(Icons.access_time, color: Colors.black45),
                                              onPressed: () async {
                                                TimeOfDay? newTime = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if(newTime == null) return;
                                                setState(() => horaFinalCenaCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}');
                                              },
                                            )
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          )
                      )
                  ),
                ]
            )
          ],
        )
    ),
    Step(
        state: _stepState(13),
        isActive: _currentStep >=13,
        title: const Text(
            'Actividad fisica',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buttons
              .asMap()
              .map((index, button) => MapEntry(
            index,
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(242, 243, 247, 100)),
                  side: MaterialStateProperty.resolveWith<BorderSide?>(
                          (Set<MaterialState> states) {
                        if(_selectedButtonA == index) {
                          return const BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          );
                        }
                        return null;
                      }),
              ),
              onPressed: () => _onButtonPressed(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(button.image, height: MediaQuery.of(context).size.height/14),
                  const SizedBox(height: 10),
                  Text(
                      button.name,
                      style: const TextStyle(fontSize: 15, color: Colors.black)
                  ),
                ],
              ),
            ),
          )).values.toList(),
        ),
    ),
    Step(
        state: _stepState(14),
        isActive: _currentStep >=14,
        title: const Text(
            'Tipo de usuario',
            style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Text(
              "¿Esta cuenta es de un paciente diabetico o un tutor?",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            ToggleButtons(
                selectedBorderColor: Colors.red,
                borderRadius: BorderRadius.circular(20),
                borderWidth: 2,
                isSelected: [
                  _selectUser == 0,
                  _selectUser == 1,
                ],
                onPressed: (int newIndex) {
                  setState(() {
                    _selectUser = newIndex;
                  });
                },
                children: const [
                  Text(
                    "Paciente",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Text(
                    "Tutor",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ]
            )
          ],
        )
    ),
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

  void _onButtonPressed(int index) {
    setState(() {
      if (_selectedButtonA == index) {
        _selectedButtonA = -1;
      } else {
        _selectedButtonA = index;
      }
    });
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

  void pushUp (String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child:  Text(
              mensaje,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }

  void clean () {
    correoCtrl.clear();
    codeCtrl.clear();
    passwordCtrl.clear();
    nombreCtrl.clear();
    apellidoCtrl.clear();
    bornCtrl.clear();
    dateDCtrl.clear();
    hiperCtrl.clear();
    normCtrl.clear();
    hipoCtrl.clear();
    carboOCtrl.clear();
    pesoCtrl.clear();
    alturaCtrl.clear();
    ratioCtrl.clear();
    senbCtrl.clear();
    ctrHoraInsulinL.clear();
    horaInicioDesayunoCtrl.clear();
    horaFinalDesayunoCtrl.clear();
    horaInicioAlmuerzoCtrl.clear();
    horaFinalAlmuerzoCtrl.clear();
    horaInicioCenaCtrl.clear();
    horaFinalCenaCtrl.clear();
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
            "Crear cuenta",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        body: BlocBuilder<SingupCubit, SingupState>(
                builder: (context, states) {
                    switch (states.status) {
                      case Singuptatus.loading:
                      return const Center(child: CircularProgressIndicator());
                        break;
                      case Singuptatus.success:
                        pruebaR = states.getInsulinas();
                        if(listInsulinR.isEmpty){
                          for (var insulin in pruebaR) {
                            if(insulin.type == "Bolo"){
                              listInsulinR.add(insulin);
                            }
                          }
                        }
                        pruebaL = states.getInsulinas();
                        if(listInsulinB.isEmpty){
                          for (var insulin in pruebaL) {
                            if(insulin.type == "Basal"){
                              listInsulinB.add(insulin);
                            }
                          }
                        }
                      return SingleChildScrollView(
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Stepper(
                                currentStep: _currentStep,
                                onStepContinue: () async {
                                  final isLastStep = _currentStep == getSteps().length - 1;
                                  if(isLastStep) {
                                    usuario.physicalctivity = _selectedButtonA;
                                    var response = await context.read<SingupCubit>().signUp(usuario);
                                    if (response.estatus){
                                      showMyPopupComplete(context, response);
                                    } else {
                                      pushUp(response.message);
                                    }
                                    //Boton con confirmar, guardar datos enviarlos a back y limpiar campos
                                  } else if (_currentStep == 0){
                                    if (correoCtrl.text.isEmpty){
                                      pushUp("Ingrese un correo");
                                    } else if (!validateEmail(correoCtrl.text)) {
                                      pushUp("Debe ingresar un correo valido");
                                    } else {
                                      usuario.email = correoCtrl.text.toString();
                                      var response = await context.read<SingupCubit>().codeValidate(usuario.email);
                                      if(response.estatus){
                                        code = response.code;
                                        setState(() => _currentStep += 1);
                                      } else {
                                        pushUp("Error al registrar el correo, confirme que el correo no ha sido resgistrado en la aplicación");
                                      }
                                    }
                                  } else if (_currentStep == 1) {
                                      if (codeCtrl.text.isEmpty){
                                        pushUp("Ingrese el codigo");
                                      } else if (codeCtrl.text != code) {
                                        pushUp("Codigo incorrecto, intente nuevamente");
                                        codeCtrl.clear();
                                      } else {
                                        setState(() => _currentStep += 1);
                                    }
                                  }else if (_currentStep == 2) {
                                    if(passwordCtrl.text.isEmpty || passwordCtrl.text.length < 7){
                                      pushUp("Ingrese una contraseña valida");
                                    } else {
                                      usuario.password = passwordCtrl.text.toString();
                                      setState(() => _currentStep += 1);
                                    }
                                  } else if (_currentStep == 3) {
                                    if(nombreCtrl.text.isEmpty || apellidoCtrl.text.isEmpty || dateDCtrl.text.isEmpty || bornCtrl.text.isEmpty) {
                                      pushUp("Complete todo los campos por favor");
                                    } else if(newDateD!.isBefore(newDateN!)) {
                                      pushUp("La fecha de  diagnostico no puede ser antes de la de nacimiento");
                                    } else {
                                      usuario.nombre = "${nombreCtrl.text} ${apellidoCtrl.text}";
                                      usuario.fechaNacimiento = bornCtrl.text.toString();
                                      usuario.fechaDiagnostico = dateDCtrl.text.toString();
                                      int nac = newDateN!.year - DateTime.now().year;
                                      usuario.edad = nac;
                                      usuario.genero = _sexTypeEnum.value;
                                      setState(() => _currentStep += 1);
                                    }
                                  } else if (_currentStep == 4) {
                                    usuario.tipoDiabetes = "Tipo 1";
                                    setState(() => _currentStep += 1);
                                  } else if (_currentStep == 5) {
                                    usuario.tipoTerapia = "Insulina";
                                    setState(() => _currentStep += 1);
                                  } else if (_currentStep == 6) {
                                    if(_selectMed == 0){
                                      usuario.infoAdicional = "Medicamenos";
                                    } else {
                                      usuario.infoAdicional = "Ninguna";
                                    }
                                    setState(() => _currentStep += 1);
                                  } else if (_currentStep == 7) {
                                    if(hiperCtrl.text.isEmpty || normCtrl.text.isEmpty || hipoCtrl.text.isEmpty || carboOCtrl.text.isEmpty) {
                                      pushUp("Complete todos los campos por favor");
                                    } else {
                                      final nHiper = int.tryParse(hiperCtrl.text);
                                      final nNorm = int.tryParse(normCtrl.text);
                                      final nHipo = int.tryParse(hipoCtrl.text);

                                      if(nHiper! < 1 || nHiper > 520 || nNorm! < 1 || nNorm > 520 || nHipo! < 1 || nHipo > 520) {
                                        pushUp("Los valores deben estar entre 1 y 520");
                                      } else {
                                        usuario.hyper = nHiper;
                                        usuario.estable = nNorm;
                                        usuario.hipo = nHipo;
                                        usuario.objective_carbs = int.tryParse(carboOCtrl.text)!;
                                        setState(() => _currentStep += 1);
                                      }
                                    }
                                  } else if(_currentStep == 8) {
                                    if(pesoCtrl.text.isEmpty) {
                                      pushUp("Ingrese su peso corporal por favor");
                                    } else {
                                      usuario.peso = double.tryParse(pesoCtrl.text)!;
                                      setState(() => _currentStep += 1);
                                    }
                                  } else if (_currentStep == 9) {
                                    if(alturaCtrl.text.isEmpty) {
                                      pushUp("Ingrese su altura corporal por favor");
                                    } else {
                                      final height = int.tryParse(alturaCtrl.text);
                                      if(height! < 40 || height > 300) {
                                        pushUp("Ingrese una altura corporal valida");
                                      } else {
                                        usuario.estatura = double.tryParse(alturaCtrl.text)!;
                                        setState(() => _currentStep += 1);
                                      }
                                    }
                                  } else if (_currentStep == 10){
                                    if(ratioCtrl.text.isEmpty || senbCtrl.text.isEmpty){
                                      pushUp("Complete todos los campos por favor");
                                    } else {
                                      usuario.rate = int.tryParse(ratioCtrl.text)!;
                                      usuario.sensitivity = double.tryParse(senbCtrl.text)!;
                                      setState(() => _currentStep += 1);
                                    }
                                  } else if (_currentStep == 11){
                                    if(ctrHoraInsulinL.text.isEmpty){
                                      pushUp("Complete todos los campos por favor");
                                    } else {
                                      usuario.precis = ctrHoraInsulinL.text.toString();
                                      for (var insulin in listInsulinR) {
                                        if(insulin.name == _selectedInsulinR){
                                          usuario.insulinR = insulin;
                                        }
                                      }
                                      for (var insulin in listInsulinB) {
                                        if(insulin.name == _selectedInsulinL){
                                          usuario.insulinL = insulin;
                                        }
                                      }
                                      setState(() => _currentStep += 1);
                                    }
                                  } else if (_currentStep == 12){
                                    if(horaInicioDesayunoCtrl.text.isEmpty || horaFinalDesayunoCtrl.text.isEmpty || horaInicioAlmuerzoCtrl.text.isEmpty || horaFinalAlmuerzoCtrl.text.isEmpty || horaInicioCenaCtrl.text.isEmpty || horaFinalCenaCtrl.text.isEmpty){
                                      pushUp("Complete todos los campos por favor");
                                    } else {
                                      usuario.breakfast_start = horaInicioDesayunoCtrl.text.toString();
                                      usuario.breakfast_end = horaFinalDesayunoCtrl.text.toString();
                                      usuario.lunch_start = horaInicioAlmuerzoCtrl.text.toString();
                                      usuario.lunch_end = horaFinalAlmuerzoCtrl.text.toString();
                                      usuario.dinner_start = horaInicioCenaCtrl.text.toString();
                                      usuario.dinner_end = horaFinalCenaCtrl.text.toString();
                                      setState(() => _currentStep += 1);
                                    }
                                  } else if (_currentStep == 13) {
                                    usuario.physicalctivity = _buttons[_selectedButtonA].id;
                                    setState(() => _currentStep += 1);
                                  } else if (_currentStep == 14) {
                                      if(_selectUser == 0){
                                        usuario.tipo_usuario = "Paciente";
                                      } else {
                                        usuario.tipo_usuario = "Tutor";
                                      }
                                      setState(() => _currentStep += 1);
                                  } else {
                                    setState(() => _currentStep += 1);
                                  }
                                },
                                onStepCancel: () async {
                                  if(_currentStep != 0){
                                    setState(()  => _currentStep--);
                                  }
                                },
                                controlsBuilder: (BuildContext context, ControlsDetails details) {
                                  final isLastStep = _currentStep == getSteps().length - 1;
                                  return Container(
                                      margin: const EdgeInsets.symmetric(vertical: 20),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: details.onStepCancel,
                                              style: ElevatedButton.styleFrom(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                elevation: 8, // elevación de la sombra
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // radio de la esquina redondeada
                                                ),
                                                backgroundColor: Colors.red, // color de fondo
                                              ),
                                              child: const Text("Atras", style: TextStyle(fontSize: 17),),
                                            ),
                                            const SizedBox(width: 12,),
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
                                              child: Text(isLastStep ? 'Registrarse' : 'Continuar', style: const TextStyle(fontSize: 17),),
                                            ),
                                            const SizedBox(width: 12,)
                                          ]
                                      )
                                  );
                                },
                                steps: getSteps(),
                              )
                          ),
                      );
                        break;
                      case Singuptatus.error:
                      return const Text("Me petatie");
                        break;
                    }
                  },
                ),
    );
  }
}

