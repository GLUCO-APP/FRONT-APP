import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko/Begin/view/begin_page.dart';
import 'package:gluko/emergency/view/emergency_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gluko/profile/view/profile_page.dart';
import 'package:gluko_repository/gluko_repository.dart';
import '../../biometricValidation/biometricValidate.dart';
import '../../colors/colorsGenerals.dart';
import '../../report/view/report_page.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Homeview(),
    );
  }
}



class Homeview extends StatefulWidget {
  @override
  State<Homeview> createState() => _HomeviewState();
}

class  _HomeviewState extends State<Homeview>{

  int _paginaActual = 0;
  List<Widget> pantallas = [
    beginpage(),
    reportpage(),
    emergencypage()
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: ColorsGenerals().lightgrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsGenerals().whith,
        leading: IconButton(
          icon: SvgPicture.asset("assets/Icons/usuario.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/30,),
          onPressed: () async {
            var tutor = await PercisteRepository().UserType();
            if(tutor){
              var autent = await LocalAuthApi.authenticate();
              if(autent){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            profilepage())
                );
              }else{
                Fluttertoast.showToast(
                    msg: "Validacion fallida", fontSize: 20);
              }
            }else{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          profilepage())
              );
            }
          },
        ),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Gluko",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, states) {
          switch (states.status) {
            case Hometatus.loading:
              return Center(child: CircularProgressIndicator());
              break;
            case Hometatus.success:
              return pantallas[_paginaActual];
              break;
            case Hometatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
        bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          backgroundColor: ColorsGenerals().whith,
          currentIndex: _paginaActual,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
            selectedFontSize:14,
          onTap: (index) {
            setState(() {
                _paginaActual = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/Icons/casa.svg",color: _paginaActual == 0? ColorsGenerals().black: ColorsGenerals().darkgrey,cacheColorFilter: false, width: MediaQuery.of(context).size.height/25,),
                label: "Inicio"
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/Icons/grafico.svg",color: _paginaActual == 1? ColorsGenerals().black: ColorsGenerals().darkgrey,cacheColorFilter: false, width: MediaQuery.of(context).size.height/25,),
                label: "Reportes"
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/Icons/sirena.svg",color: _paginaActual == 2? ColorsGenerals().black: ColorsGenerals().darkgrey,cacheColorFilter: false, width: MediaQuery.of(context).size.height/25,),
                label: "Emergencia"
            ),
          ],
        )
    );
  }

}