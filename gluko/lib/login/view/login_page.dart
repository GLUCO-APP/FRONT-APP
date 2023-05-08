import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../forgetpassword/view/forgetpassword_page.dart';
import '../../home/view/home_page.dart';
import '../../notifications/pushNotification.dart';
import '../../singup/view/singup_page.dart';
import '../cubit/login_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository(), PercisteRepository())..isAutenticate(context),
      child: loginview(),
    );
  }
}

class loginview extends StatefulWidget {
  @override
  State<loginview> createState() => _loginviewviewState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
var correo = TextEditingController();
var contrasena = TextEditingController();
class _loginviewviewState extends State<loginview>{
  final correoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;
  var  ver = true;

  @override
  void initState() {
    super.initState();
    correoCtrl.addListener(() => setState(() {}));
    passwordCtrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, states) {
          switch (states.status) {
            case LoginStatestatus.loading:

              return Center(child: CircularProgressIndicator( color: ColorsGenerals().red,));
              break;
            case LoginStatestatus.success:
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/1.8,
                        decoration: BoxDecoration(
                          color: ColorsGenerals().lightgrey,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(0, -1),
                              blurRadius: 12,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/Logo/logo_figura.svg",
                                color:ColorsGenerals().red, height: MediaQuery.of(context).size.height/5),
                            SvgPicture.asset("assets/Logo/logo_name.svg",
                                color:ColorsGenerals().black, height: MediaQuery.of(context).size.height/10),
                          ],
                        ),
                      ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/2.7,
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  onEditingComplete: (){
                                    FocusScope.of(context).nextFocus();
                                  },
                                  controller: correo,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black, fontSize: 17),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ColorsGenerals().regulargrey,
                                    hintText: 'Correo',
                                    hintStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() {
                                        ver = false;
                                      });
                                      return 'Ingrese Correo';
                                    }
                                    setState(() {
                                      ver = true;
                                    });
                                    return null;
                                  },
                                ),
                                ver? Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/60)):Padding(padding: EdgeInsets.symmetric(vertical: 1)),
                                TextFormField(
                                  obscureText: true,
                                  controller: contrasena,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black, fontSize: 17),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ColorsGenerals().regulargrey,
                                    hintText: 'Contraseña',
                                    hintStyle: TextStyle(color: Colors.black),
                                    contentPadding: EdgeInsets.symmetric(vertical: 1.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(Icons.lock, color: Colors.black),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Ingrese Contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                TextButton(onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              forgetpasswordpage())
                                  );
                                }, child:Text("¿Olvidó su contraseña? ", style: TextStyle(color: Colors.black, fontSize: 12),),style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all<Color>(ColorsGenerals().red), // color deseado
                                )),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        print(correo.text);
                                        var repnse =  await context.read<LoginCubit>().Login(correo.text, contrasena.text);
                                        if(repnse.estatus){
                                          LocalNotificationService().initializeService();
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                                (Route<dynamic> route) => false,
                                          );
                                        }else {
                                          Fluttertoast.showToast(
                                              msg: repnse.message, fontSize: 20);
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                      child: Text("Iniciar Sesión", style: TextStyle(fontSize: 17),),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 8, // elevación de la sombra
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30), // radio de la esquina redondeada
                                      ),
                                      backgroundColor: Colors.red, // color de fondo
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Singuppage())
                          );
                        },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("¿No tiene cuenta?", style: TextStyle(color: ColorsGenerals().black, fontSize: 14),),
                                Text("Registrarse",style: TextStyle(color: ColorsGenerals().red, fontSize: 14))
                              ],
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  31, 239, 131, 131)), // color deseado
                            )
                        )
                      ],
                    ),
                  ),
                ),
              );
              break;
            case LoginStatestatus.error:
              return Center(child: Text("Algo salio mal :(", style: TextStyle(color: ColorsGenerals().black),),);
              break;
          }
        },
      ),
    );
  }
}