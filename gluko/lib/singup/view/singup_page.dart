import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/singup_cubit.dart';

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
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorsGenerals().lightgrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [Text(
            " Crear cuenta ",
            style: TextStyle(color: Colors.black, fontSize: 22),
          )],
        ),
        body: BlocBuilder<SingupCubit, SingupState>(
                builder: (context, states) {
                    switch (states.status) {
                      case Singuptatus.loading:
                      return Center(child: CircularProgressIndicator());
                        break;
                      case Singuptatus.success:
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(100)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, -5),
                              blurRadius: 2,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      );
                        break;
                      case Singuptatus.error:
                      return Text("Me petatie");
                        break;
                    }
                  },
                ),
    );
  }
}

