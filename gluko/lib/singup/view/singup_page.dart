import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../colors/colorsGenerals.dart';
import 'package:gluko/login/view/login_page.dart';
import '../cubit/singup_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SexTypeEnum {men, women}

class Singuppage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingupCubit(),
      child: Singupview(),
    );
  }
}

class Singupview extends StatefulWidget {
  @override
  State<Singupview> createState() => _SingupviewState();
}

class  _SingupviewState extends State<Singupview>{
  // primer paso
  final correoCtrl = TextEditingController();
  //segundo paso
  final passwordCtrl = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;
  // cuarto paso
  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final bornCtrl = TextEditingController();
  final dateDCtrl = TextEditingController();
  SexTypeEnum? _sexTypeEnum = SexTypeEnum.men;
  //septimo paso
  int _selectMed = 0;
  //octavo paso
  final hiperCtrl = TextEditingController();
  final normCtrl = TextEditingController();
  final hipoCtrl = TextEditingController();
  //noveno paso
  final pesoCtrl = TextEditingController();
  //decimo paso
  final alturaCtrl = TextEditingController();
  // 11 paso
  final senbCtrl = TextEditingController();
  final ratioCtrl = TextEditingController();


  @override
  void initState() {
    super.initState();

    // primer paso
    correoCtrl.addListener(() => setState(() {}));
    // segundo paso
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
    // noveno paso
    pesoCtrl.addListener(() => setState(() {}));
    // decimo paso
    alturaCtrl.addListener(() => setState(() {}));
    // 11 paso
    ratioCtrl.addListener(() => setState(() {}));
    senbCtrl.addListener(() => setState(() {}));
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
        content: const SizedBox(
          width: 110,
          height: 100,
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
                      value: SexTypeEnum.men,
                      onChanged: (val) {
                        setState(() {
                          _sexTypeEnum = val;
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
                      value: SexTypeEnum.women,
                      onChanged: (val) {
                        setState(() {
                          _sexTypeEnum = val;
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
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2024)
                      );
                      if(newDate == null) return;
                      setState(() => bornCtrl.text = DateFormat.yMd().format(newDate));
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
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2024)
                        );
                        if(newDate == null) return;
                        setState(() => dateDCtrl.text = DateFormat.yMd().format(newDate));
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
              "Inidica tus objetivos de glucometria",
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
          children:  const [
            Text(
              "Hora aplicación basal",
              style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            )
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/Icons/desayuno.png", height: MediaQuery.of(context).size.height/14),
                        const Text("DESAYUNO")
                      ],
                    )
                  ),
                  
                ]
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/Icons/comida.png", height: MediaQuery.of(context).size.height/14),
                          const Text("ALMUERZO")
                        ],
                      )
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
                ]
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/Icons/cena.png", height: MediaQuery.of(context).size.height/14),
                          const Text("CENA")
                        ],
                      )
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
          duration: const Duration(seconds: 1),
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
                                  pushUp("Ingrese un correo");
                                } else if (!validateEmail(correoCtrl.text)) {
                                  pushUp("Debe ingresar un correo valido");
                                } else {
                                  setState(() => _currentStep += 1);
                                }
                              } else if (_currentStep == 2) {
                                if(passwordCtrl.text.isEmpty || passwordCtrl.text.length < 7){
                                  pushUp("Ingrese una contraseña valida");
                                } else {
                                  setState(() => _currentStep += 1);
                                }
                              } else if (_currentStep == 3) {
                                if(nombreCtrl.text.isEmpty || apellidoCtrl.text.isEmpty || dateDCtrl.text.isEmpty || bornCtrl.text.isEmpty) {
                                  pushUp("Complete todo los campos por favor");
                                } else {
                                  setState(() => _currentStep += 1);
                                }
                              } else if (_currentStep == 7) {
                                if(hiperCtrl.text.isEmpty || normCtrl.text.isEmpty || hipoCtrl.text.isEmpty) {
                                  pushUp("Complete todos los campos por favor");
                                } else {
                                  final nHiper = int.tryParse(hiperCtrl.text);
                                  final nNorm = int.tryParse(normCtrl.text);
                                  final nHipo = int.tryParse(hipoCtrl.text);

                                  if(nHiper! < 1 || nHiper > 520 || nNorm! < 1 || nNorm > 520 || nHipo! < 1 || nHipo > 520) {
                                    pushUp("Los valores deben estar entre 1 y 520");
                                  } else {
                                    setState(() => _currentStep += 1);
                                  }
                                }
                              } else if(_currentStep == 8) {
                                if(pesoCtrl.text.isEmpty) {
                                  pushUp("Ingrese su peso corporal por favor");
                                } else {
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
                                    setState(() => _currentStep += 1);
                                  }
                                }
                              } else {
                                setState(() => _currentStep += 1);
                              }
                            },
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
                      case Singuptatus.error:
                      return const Text("Me petatie");
                        break;
                    }
                  },
                ),
    );
  }
}

