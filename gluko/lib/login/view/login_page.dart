import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gluko/colors/colorsGenerals.dart';
import '../../forgetpassword/view/forgetpassword_page.dart';
import '../../home/view/home_page.dart';
import '../../singup/view/singup_page.dart';
import '../cubit/login_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: loginview(),
    );
  }
}

class loginview extends StatefulWidget {
  @override
  State<loginview> createState() => _loginviewviewState();
}

class _loginviewviewState extends State<loginview>{
  final correoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  String password = '';
  bool isPasswordVisible = true;

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
              return const Center(child: CircularProgressIndicator());
              break;
            case LoginStatestatus.success:
              return SingleChildScrollView(
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
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(100)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(0, -1),
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
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: correoCtrl,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'Correo',
                                hintStyle: const TextStyle(color: Colors.black45),
                                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                                prefixIcon: const Icon(Icons.email_outlined, color: Colors.black45),
                                suffixIcon: correoCtrl.text.isEmpty ? Container(width: 0) :
                                  IconButton(icon: const Icon(Icons.close, color: Colors.black45), onPressed: () => correoCtrl.clear(),),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                            TextFormField(
                              controller: passwordCtrl,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'Contraseña',
                                hintStyle: const TextStyle(color: Colors.black45),
                                prefixIcon: const Icon(Icons.lock, color: Colors.black45),
                                suffixIcon: IconButton(
                                  icon: isPasswordVisible ? const Icon(Icons.visibility_off, color: Colors.black45) : const Icon(Icons.visibility, color: Colors.black45),
                                  onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              obscureText: isPasswordVisible,
                            ),
                            TextButton(onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          forgetpasswordpage())
                              );
                            },style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                                  31, 239, 131, 131)), // color deseado
                            ), child:const Text("¿Olvido su contraseña? ", style: TextStyle(color: Colors.black, fontSize: 12),)),
                            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/300)),
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()),
                                        (Route<dynamic> route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 8, // elevación de la sombra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30), // radio de la esquina redondeada
                                  ),
                                  backgroundColor: Colors.red, // color de fondo
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                  child: const Text("Iniciar Sesion", style: TextStyle(fontSize: 17),),
                                )
                            ),
                          ],
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
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color>(const Color.fromARGB(
                                31, 239, 131, 131)), // color deseado
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("¿No tiene cuenta?", style: TextStyle(color: Colors.black, fontSize: 14),),
                              Text("Registrarse",style: TextStyle(color: Color.fromARGB(
                                  255, 230, 55, 55), fontSize: 14))
                            ],
                          )
                      )
                    ],

                  ),
                ),
              );
              break;
            case LoginStatestatus.error:
              return const Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}