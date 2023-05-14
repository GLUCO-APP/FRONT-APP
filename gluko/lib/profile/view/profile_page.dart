import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gluko/login/cubit/login_cubit.dart';
import 'package:gluko/login/view/login_page.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../colors/colorsGenerals.dart';
import '../../home/view/home_page.dart';
import '../cubit/profile_cubit.dart';

enum SexTypeEnum {masculino, femenino}

class ButtonData {
  final int code;
  final String name;
  final String image;

  ButtonData(this.code, this.name, this.image);
}

class profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        infoUserRepository(),
        PercisteRepository(),
        allinsulinRepository(),
        ChangePasswordRepository(),
        EditUserRepository()
      )..getInfoUser(),
      child: profileview(),
    );
  }
}

var name = "Mateo Arenas";
var edad = "23";
var correo = "matvo@gmail.com";
var sexo = "Masculino";
var Hiper = "180 mg/dL";
var Normal = "90 - 160 mg/dL";
var Hipo = "70 mg/dL";
var peso = "70";
var altura = "175";
var sensibilidad = "40";
var ratio = "14";
var insulinaBolo = "";
var insulinaBasal = "";
var horaBasal = "";
var horaInicioDesayuno = "";
var horaInicioComida = "";
var horaInicioCena = "";
var horaFinalDesayuno = "";
var horaFinalComida = "";
var horaFinalCena = "";
var objetivoCarbo = "";
var actividadFisica = "";
User user = User("", "", "", "", "", 0, "", 0, 0, "", "", 0, 0, 0, 0, 0, "", "", "", "", "", "", "", Insulin(0, "", "", 0, 0), Insulin(0, "", "", 0, 0), 0, 0, "", "");
GlobalKey<FormState> formKey = GlobalKey<FormState>();


var  ver = true;


class profileview extends StatefulWidget {
  @override
  State<profileview> createState() => _profileviewState();
}

class  _profileviewState extends State<profileview>{

  showMyPopupChangePassword(BuildContext context) {
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
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: oldPasswordCtrl,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Contraseña actual',
                                    errorText: oldPasswordCtrl.text.isEmpty || oldPasswordCtrl.text.length > 7 ? null : 'Contraseña invalida',
                                    suffixIcon: IconButton(
                                      icon: isPasswordVisible1 ? const Icon(Icons.visibility_off, color: Colors.black45) : const Icon(Icons.visibility, color: Colors.black45),
                                      onPressed: () => setState(() => isPasswordVisible1 = !isPasswordVisible1),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                                    border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none
                                    ),
                                ),
                                obscureText: isPasswordVisible1,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: newPasswordCtrl,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Contraseña nueva',
                                    errorText: newPasswordCtrl.text.isEmpty || newPasswordCtrl.text.length > 7 ? null : 'Contraseña invalida',
                                    suffixIcon: IconButton(
                                      icon: isPasswordVisible2 ? const Icon(Icons.visibility_off, color: Colors.black45) : const Icon(Icons.visibility, color: Colors.black45),
                                      onPressed: () => setState(() => isPasswordVisible2 = !isPasswordVisible2),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                                    border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none
                                    ),
                                    helperText: ('Utilice al menos 8 caracteres'),
                                    helperStyle: TextStyle(fontSize: 11)
                                ),
                                obscureText: isPasswordVisible2,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: newRepeatPasswordCtrl,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Confirmar contraseña',
                                    errorText: newPasswordCtrl.text != newRepeatPasswordCtrl.text ? 'Contraseñas no coinciden' : null,
                                    suffixIcon: IconButton(
                                      icon: isPasswordVisible3 ? const Icon(Icons.visibility_off, color: Colors.black45) : const Icon(Icons.visibility, color: Colors.black45),
                                      onPressed: () => setState(() => isPasswordVisible3 = !isPasswordVisible3),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 30.0),
                                    border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide.none
                                    ),
                                ),
                                obscureText: isPasswordVisible3,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if(oldPasswordCtrl.text.isEmpty || newPasswordCtrl.text.isEmpty || newPasswordCtrl.text.length < 7 || newRepeatPasswordCtrl.text.isEmpty || newRepeatPasswordCtrl.text.length < 7){
                                      pushUp("Ingrese una contraseña valida");
                                    } else {
                                      var token = await PercisteRepository().GetToken();
                                      var response = await ChangePasswordRepository().changePassword(token, oldPasswordCtrl.text.toString(), newPasswordCtrl.text.toString());
                                      print(response.message);
                                      if (response.estatus){
                                        clean();
                                        pushUp(response.message);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()),
                                              (Route<dynamic> route) => false,
                                        );
                                      } else {
                                        pushUp(response.message);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Guardar Cambios",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                ElevatedButton(
                                  onPressed: () async {
                                    clean();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Cancelar",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                              ],
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

  showMyPopupEditObjective(BuildContext context) {
    print(user.nombre);
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
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: hiperCtrl,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.red, fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  labelText: 'Hiperglucemia',
                                  hintText: Hiper,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: hiperCtrl.text.isEmpty ? Container(width: 0) :
                                  IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => hiperCtrl.clear(),),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: normCtrl,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.green, fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  labelText: 'Nivel Deseado',
                                  hintText: Normal,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: normCtrl.text.isEmpty ? Container(width: 0) :
                                  IconButton(icon: const Icon(Icons.close, color: Colors.green), onPressed: () => normCtrl.clear(),),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: hipoCtrl,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  labelText: 'Hipoglucemia',
                                  hintText: Hipo,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: hipoCtrl.text.isEmpty ? Container(width: 0) :
                                  IconButton(icon: const Icon(Icons.close, color: Colors.lightBlue), onPressed: () => hipoCtrl.clear(),),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    clean();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Cancelar",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                ElevatedButton(
                                  onPressed: () async {
                                    if(hiperCtrl.text.isEmpty || normCtrl.text.isEmpty || hiperCtrl.text.isEmpty){
                                      pushUp("Complete todos los campos por favor");
                                    } else {
                                        final nHiper = int.tryParse(hiperCtrl.text);
                                        final nNorm = int.tryParse(normCtrl.text);
                                        final nHipo = int.tryParse(hipoCtrl.text);

                                        if(nHiper! < 1 || nHiper > 520 || nNorm! < 1 || nNorm > 520 || nHipo! < 1 || nHipo > 520) {
                                          pushUp("Los valores deben estar entre 1 y 520");
                                        } else {
                                          user.hyper = nHiper;
                                          user.estable = nNorm;
                                          user.hipo = nHipo;
                                          var token = await PercisteRepository().GetToken();
                                          var response = await EditUserRepository().editUser(user, token);
                                          print(response.message);
                                          if (response.estatus){
                                            clean();
                                            pushUp(response.message);
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                                  (Route<dynamic> route) => false,
                                            );
                                          } else {
                                            pushUp(response.message);
                                          }
                                        }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Guardar Cambios",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                              ],
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

  showMyPopupEditPyshics(BuildContext context) {
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
                        height: MediaQuery.of(context).size.height/2.8,
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
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: pesoCtrl,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black45, fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  labelText: 'Peso en kg',
                                  hintText: peso,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: pesoCtrl.text.isEmpty ? Container(width: 0) :
                                  IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => pesoCtrl.clear(),),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Container(
                              height:  MediaQuery.of(context).size.height/13,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: alturaCtrl,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black45, fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  filled: true,
                                  labelText: 'Altura en cm',
                                  hintText: altura,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: alturaCtrl.text.isEmpty ? Container(width: 0) :
                                  IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => alturaCtrl.clear(),),
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    clean();
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Cancelar",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                ElevatedButton(
                                  onPressed: () async {
                                    if(pesoCtrl.text.isEmpty || alturaCtrl.text.isEmpty){
                                      pushUp("Complete todos los campos por favor");
                                    } else {
                                      user.peso = double.tryParse(pesoCtrl.text)!;
                                      user.estatura = double.tryParse(alturaCtrl.text)!;
                                      var token = await PercisteRepository().GetToken();
                                      var response = await EditUserRepository().editUser(user, token);
                                      print(response.message);
                                      if (response.estatus){
                                        clean();
                                        pushUp(response.message);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()),
                                              (Route<dynamic> route) => false,
                                        );
                                      } else {
                                        pushUp(response.message);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Guardar Cambios",
                                    style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                              ],
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

  Future<void>showMyPopupEditMecis(BuildContext context) async {
    String? _selectedInsulinR = "Humulin R Cristalina";
    int _selectPR = 0;
    String? _selectedInsulinL = "Delemir Levemir";
    int _selectPL = 0;
    pruebaR = await allinsulinRepository().getInsulin();
    if(listInsulinR.isEmpty){
      for (var insulin in pruebaR) {
        if(insulin.type == "Bolo"){
          listInsulinR.add(insulin);
        }
      }
    }
    if(listInsulinB.isEmpty){
      for (var insulin in pruebaR) {
        if(insulin.type == "Basal"){
          listInsulinB.add(insulin);
        }
      }
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return  Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width/3,
              color: Colors.transparent,
              child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.height/1.1,
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: ratioCtrl,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black45, fontSize: 15),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    filled: true,
                                    labelText: 'Ratio',
                                    helperText: "Cantidad de carbohidratos que se cubren con 1 unidad de insulina",
                                    helperMaxLines: 3,
                                    hintText: ratio,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: ratioCtrl.text.isEmpty ? Container(width: 0) :
                                    IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => ratioCtrl.clear(),),
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: senbCtrl,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black45, fontSize: 15),
                                  decoration: InputDecoration(
                                    filled: true,
                                    labelText: 'Sensibilidad',
                                    helperText: "Cantidad de glucemia que se reduce con 1 unidad de insulina",
                                    helperMaxLines: 3,
                                    hintText: sensibilidad,
                                    errorText: senbCtrl.text.isEmpty ? null : 'Ingrese un valor por favor',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: senbCtrl.text.isEmpty ? Container(width: 0) :
                                    IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => senbCtrl.clear(),),
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      DropdownButtonFormField(
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
                                      DropdownButtonFormField(
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
                                                  ctrHoraInsulinL.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                                                },
                                              )
                                            ],
                                          )
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              clean();
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 8, // elevación de la sombra
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    30), // radio de la esquina redondeada
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              backgroundColor: ColorsGenerals().red, // color de fondo
                                            ),
                                            child: Text("Cancelar",
                                              style: TextStyle(color: ColorsGenerals().whith),),
                                          ),
                                          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if(ratioCtrl.text.isEmpty || senbCtrl.text.isEmpty || ctrHoraInsulinL.text.isEmpty){
                                                pushUp("Complete todos los campos por favor");
                                              } else {
                                                user.rate = int.tryParse(ratioCtrl.text)!;
                                                user.sensitivity = double.tryParse(senbCtrl.text)!;
                                                user.precis = ctrHoraInsulinL.text.toString();
                                                for (var insulin in listInsulinR) {
                                                  if(insulin.name == _selectedInsulinR){
                                                    user.insulinR = insulin;
                                                  }
                                                }
                                                for (var insulin in listInsulinB) {
                                                  if(insulin.name == _selectedInsulinL){
                                                    user.insulinL = insulin;
                                                  }
                                                }
                                                var token = await PercisteRepository().GetToken();
                                                var response = await EditUserRepository().editUser(user, token);
                                                print(response.message);
                                                if (response.estatus){
                                                  clean();
                                                  pushUp(response.message);
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()),
                                                        (Route<dynamic> route) => false,
                                                  );
                                                } else {
                                                  pushUp(response.message);
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 8, // elevación de la sombra
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    30), // radio de la esquina redondeada
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              backgroundColor: ColorsGenerals().red, // color de fondo
                                            ),
                                            child: Text("Guardar Cambios",
                                              style: TextStyle(color: ColorsGenerals().whith),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          )
                      ),
                    ]
                ),
              ),
            ),
          );
        });
      },
    );
  }

  showMyPopupEditStyle(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width/3,
            color: Colors.transparent,
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width/1.2,
                        height: MediaQuery.of(context).size.height/1.1,
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
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(
                              physics: const BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
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
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Desayuno", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
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
                                                              horaInicioDesayunoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
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
                                                                horaFinalDesayunoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                                                              },
                                                            )
                                                        ),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ],
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
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Almuerzo", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
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
                                                              horaInicioAlmuerzoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
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
                                                                horaFinalAlmuerzoCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                                                              },
                                                            )
                                                        ),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ],
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
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Cena", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
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
                                                              horaInicioCenaCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
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
                                                                horaFinalCenaCtrl.text = '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
                                                              },
                                                            )
                                                        ),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                    ]
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                                Text("Actividad Fisica", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                Column(
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
                                          Text(
                                              button.name,
                                              style: const TextStyle(fontSize: 15, color: Colors.black)
                                          ),
                                        ],
                                      ),
                                    ),
                                  )).values.toList(),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        clean();
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 8, // elevación de la sombra
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30), // radio de la esquina redondeada
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        backgroundColor: ColorsGenerals().red, // color de fondo
                                      ),
                                      child: Text("Cancelar",
                                        style: TextStyle(color: ColorsGenerals().whith),),
                                    ),
                                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if(horaInicioDesayunoCtrl.text.isEmpty || horaFinalDesayunoCtrl.text.isEmpty || horaInicioAlmuerzoCtrl.text.isEmpty || horaFinalAlmuerzoCtrl.text.isEmpty || horaInicioCenaCtrl.text.isEmpty || horaFinalCenaCtrl.text.isEmpty || carboOCtrl.text.isEmpty){
                                          pushUp("Complete todos los campos por favor");
                                        } else {
                                          user.breakfast_start = horaInicioDesayunoCtrl.text.toString();
                                          user.breakfast_end = horaFinalDesayunoCtrl.text.toString();
                                          user.lunch_start = horaInicioAlmuerzoCtrl.text.toString();
                                          user.lunch_end = horaFinalAlmuerzoCtrl.text.toString();
                                          user.dinner_start = horaInicioCenaCtrl.text.toString();
                                          user.dinner_end = horaFinalCenaCtrl.text.toString();
                                          user.objective_carbs = int.tryParse(carboOCtrl.text)!;
                                          user.physicalctivity = _buttons[_selectedButtonA].code;
                                          var token = await PercisteRepository().GetToken();
                                          var response = await EditUserRepository().editUser(user, token);
                                          print(response.message);
                                          if (response.estatus){
                                            clean();
                                            pushUp(response.message);
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                                  (Route<dynamic> route) => false,
                                            );
                                          } else {
                                            pushUp(response.message);
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 8, // elevación de la sombra
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30), // radio de la esquina redondeada
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        backgroundColor: ColorsGenerals().red, // color de fondo
                                      ),
                                      child: Text("Guardar Cambios",
                                        style: TextStyle(color: ColorsGenerals().whith),),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        )
                      ),
                    )
                  ]
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showMyPopupLogout(BuildContext context) async {
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
                            const Text(
                                "¿Seguro desea cerrar su sesión?",
                                style: TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Cancelar", style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    var cerro = await PercisteRepository().logout();
                                    if(cerro == true){
                                      pushUp("Cierre de sesión exitoso");
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Loginpage()),
                                            (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      pushUp("No se logro cerrar sesión");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8, // elevación de la sombra
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30), // radio de la esquina redondeada
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    backgroundColor: ColorsGenerals().red, // color de fondo
                                  ),
                                  child: Text("Aceptar", style: TextStyle(color: ColorsGenerals().whith),),
                                ),
                              ],
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

  void _onButtonPressed(int index) {
    setState(() {
      if (_selectedButtonA == index) {
        _selectedButtonA = -1;
      } else {
        _selectedButtonA = index;
      }
    });
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

  final nameCtrl = TextEditingController();
  final meilCtrl = TextEditingController();
  final edadCtrl = TextEditingController();
  // Editar contraseña
  bool isPasswordVisible1 = true;
  bool isPasswordVisible2 = true;
  bool isPasswordVisible3 = true;
  final oldPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final newRepeatPasswordCtrl = TextEditingController();
// Editar obejtivos de glucometria
  final hiperCtrl = TextEditingController();
  final normCtrl = TextEditingController();
  final hipoCtrl = TextEditingController();
// Editar peso y altura
  final pesoCtrl = TextEditingController();
  final alturaCtrl = TextEditingController();
// Editar datos medicos
  final ratioCtrl = TextEditingController();
  final senbCtrl = TextEditingController();
  final ctrHoraInsulinL = TextEditingController();
  List<Insulin> listInsulinR = [];
  List<Insulin> pruebaR = [];
  List<Insulin> listInsulinB = [];
  List<Insulin> pruebaL = [];
// Editar datos de estilo de vida
  final horaInicioDesayunoCtrl = TextEditingController();
  final horaFinalDesayunoCtrl = TextEditingController();
  final horaInicioAlmuerzoCtrl = TextEditingController();
  final horaFinalAlmuerzoCtrl = TextEditingController();
  final horaInicioCenaCtrl = TextEditingController();
  final horaFinalCenaCtrl = TextEditingController();
  final carboOCtrl = TextEditingController();
  int _selectedButtonA = -1;
  final List<ButtonData> _buttons = [
    ButtonData(0, "Sedentarismo", "assets/Icons/Relajante1.png"),
    ButtonData(1, "1-3 dias/semana", "assets/Icons/Triangulo1.png"),
    ButtonData(2, "3-5 dias/semana", "assets/Icons/Corriendo1.png"),
    ButtonData(3, "5-7 dias/semana", "assets/Icons/Deporte1.png")
  ];


  @override
  void initState() {
    super.initState();
    clean();
    hiperCtrl.addListener(() => setState(() {}));
    normCtrl.addListener(() => setState(() {}));
    hipoCtrl.addListener(() => setState(() {}));
    pesoCtrl.addListener(() => setState(() {}));
    alturaCtrl.addListener(() => setState(() {}));
    ratioCtrl.addListener(() => setState(() {}));
    senbCtrl.addListener(() => setState(() {}));
    ctrHoraInsulinL.addListener(() => setState(() {}));
    horaInicioDesayunoCtrl.addListener(() => setState(() {}));
    horaFinalDesayunoCtrl.addListener(() => setState(() {}));
    horaInicioAlmuerzoCtrl.addListener(() => setState(() {}));
    horaFinalAlmuerzoCtrl.addListener(() => setState(() {}));
    horaInicioCenaCtrl.addListener(() => setState(() {}));
    horaFinalCenaCtrl.addListener(() => setState(() {}));
    carboOCtrl.addListener(() => setState(() {}));
    oldPasswordCtrl.addListener(() => setState(() {}));
    newPasswordCtrl.addListener(() => setState(() {}));
    newRepeatPasswordCtrl.addListener(() => setState(() {}));
  }

  void clean () {
    nameCtrl.clear();
    meilCtrl.clear();
    edadCtrl.clear();
    hiperCtrl.clear();
    normCtrl.clear();
    hipoCtrl.clear();
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
    carboOCtrl.clear();
    oldPasswordCtrl.clear();
    newPasswordCtrl.clear();
    newRepeatPasswordCtrl.clear();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/Icons/atras.svg", color: ColorsGenerals().black,
            cacheColorFilter: false,
            width: MediaQuery
                .of(context)
                .size
                .height / 30,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMyPopupLogout(context);
          },
            icon: Icon(Icons.logout, color: ColorsGenerals().black)
          )
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, states) {
          switch (states.status) {
            case profilestatus.loading:
              return const Center(child: CircularProgressIndicator());
              break;
            case profilestatus.success:
              user = context.read<ProfileCubit>().getUser();
              if(user.nombre.isNotEmpty){
                name = user.nombre;
                edad = "${user.edad.abs()}";
                correo = user.email;
                sexo = user.genero;
                Hiper = "${user.hyper} mg/dL";
                Normal = "${user.estable} mg/dL";
                Hipo = "${user.hipo} mg/dL";
                peso = user.peso.toStringAsFixed(1);
                altura = "${user.estatura}";
                sensibilidad = "${user.sensitivity}";
                ratio = "${user.rate}";
                insulinaBolo = user.insulinR.name;
                insulinaBasal = user.insulinL.name;
                horaBasal = user.precis.substring(0, user.precis.length -3);
                horaInicioDesayuno = user.breakfast_start.substring(0, user.breakfast_start.length - 3);
                horaFinalDesayuno = user.breakfast_end.substring(0, user.breakfast_end.length - 3);
                horaInicioComida = user.lunch_start.substring(0, user.lunch_start.length - 3);
                horaFinalComida = user.lunch_end.substring(0, user.lunch_end.length - 3);
                horaInicioCena = user.dinner_start.substring(0, user.dinner_start.length - 3);
                horaFinalCena = user.dinner_end.substring(0, user.dinner_end.length - 3);
                objetivoCarbo = "${user.objective_carbs} g";
                actividadFisica = _buttons.elementAt(user.physicalctivity).name;
              }
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: const BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/5,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name, style: TextStyle(color: ColorsGenerals().black, fontSize: 25, fontWeight: FontWeight.w500),),
                                    Text("Edad : $edad", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    Text("Correo : $correo", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    Text("Sexo : $sexo", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          ElevatedButton(
                              onPressed: () async {
                                showMyPopupChangePassword(context);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 8, // elevación de la sombra
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // radio de la esquina redondeada
                                ),
                                backgroundColor: Colors.red, // color de fondo
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                child: Text("Cambiar Contraseña", style: TextStyle(fontSize: 17),),
                              )
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          Text("  Objetivos glucometria", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                height:  MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.red,
                                            Colors.green,
                                            Colors.blue,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width/8,
                                      height: MediaQuery.of(context).size.height/7,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Hiper : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                            Text(Hiper, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Normal : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                            Text(Normal, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Hipo : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                            Text(Hipo, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){showMyPopupEditObjective(this.context);}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,),
                                ),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          Text("  Datos fisicos", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${peso}kg", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                    Container(
                                      width: 1,
                                      height: MediaQuery.of(context).size.height/10,
                                      color: ColorsGenerals().darkgrey,
                                    ),
                                    Text("${altura}cm", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){showMyPopupEditPyshics(this.context);}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,)),
                              ),
                              Positioned(
                                top: 1,
                                left: 0,
                                child: Text("   Peso: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: 1,
                                left: MediaQuery.of(context).size.width/2,
                                child: Text("Altura: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          Text("  Datos medicos", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/3.9,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(sensibilidad, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                        Container(
                                          width: 1,
                                          height: MediaQuery.of(context).size.height/12,
                                          color: ColorsGenerals().darkgrey,
                                        ),
                                        Text(ratio, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: ColorsGenerals().darkgrey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(17),
                                      height: MediaQuery.of(context).size.height/7,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Bolo : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                                Text(insulinaBolo, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Basal : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                                Text(insulinaBasal, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Hora aplicación basal : ", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w500),),
                                                Text(horaBasal, style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                          ]
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){showMyPopupEditMecis(this.context);}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,)),
                              ),
                              Positioned(
                                top: 2,
                                left: 0,
                                child: Text("   Sensibilidad: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: 2,
                                left: MediaQuery.of(context).size.width/2,
                                child: Text("Ratio: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height/10,
                                left: 0,
                                child: Text("   Insulina: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                          Text("  Estilo de vida", style: TextStyle(color: ColorsGenerals().black, fontSize: 17,fontWeight: FontWeight.w400),),
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height:  MediaQuery.of(context).size.height/2.3,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ColorsGenerals().lightgrey,
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Inicio: $horaInicioDesayuno", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                        Container(
                                          width: 1,
                                          height: MediaQuery.of(context).size.height/10,
                                          color: ColorsGenerals().darkgrey,
                                        ),
                                        Text("Final: $horaFinalDesayuno", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Inicio: $horaInicioComida", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                        Container(
                                          width: 1,
                                          height: MediaQuery.of(context).size.height/10,
                                          color: ColorsGenerals().darkgrey,
                                        ),
                                        Text("Final: $horaFinalComida", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Inicio: $horaInicioCena", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                        Container(
                                          width: 1,
                                          height: MediaQuery.of(context).size.height/10,
                                          color: ColorsGenerals().darkgrey,
                                        ),
                                        Text("Final: $horaFinalCena", style: TextStyle(color: ColorsGenerals().black, fontSize: 18,fontWeight: FontWeight.w300),),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: ColorsGenerals().darkgrey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      height: MediaQuery.of(context).size.height/10,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Objetivo Carbohidratos: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 15,fontWeight: FontWeight.w500),),
                                                Text(objetivoCarbo, style: TextStyle(color: ColorsGenerals().black, fontSize: 15,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Actividad fisica: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 15,fontWeight: FontWeight.w500),),
                                                Text(actividadFisica, style: TextStyle(color: ColorsGenerals().black, fontSize: 15,fontWeight: FontWeight.w300),),
                                              ],
                                            ),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(onPressed: (){showMyPopupEditStyle(this.context);}, icon: SvgPicture.asset("assets/Icons/lapiz.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,)),
                              ),
                              Positioned(
                                top: 5,
                                left: 0,
                                child: Text("   Desayuno: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height/10,
                                left: 0,
                                child: Text("   Almuerzo: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height/5,
                                left: 0,
                                child: Text("   Cena: ", style: TextStyle(color: ColorsGenerals().black, fontSize: 16,fontWeight: FontWeight.w500),),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        ],
                      )
                  ),
                ),
              );
              break;
            case profilestatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}