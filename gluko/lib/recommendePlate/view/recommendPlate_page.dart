import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../biometricValidation/biometricValidate.dart';
import '../../calculateinsulin/view/calculateinsulina_page.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/recomemende_plate_cubit.dart';

class RecomemendePlatepage extends StatelessWidget {
  final PlateRecomend plate;
  RecomemendePlatepage(this.plate);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecomemendePlateCubit(plate)..getCurrentLocation(PointLatLng(plate.latitude, plate.longitude)),
      child: RecomemendePlateview(),
    );
  }
}

class RecomemendePlateview extends StatefulWidget {
  @override
  State<RecomemendePlateview> createState() => _RecomemendePlateviewState();
}

var platoLatitud = 0.0;
var platoLongitud = 0.0;
var miLatitud = 0.0;
var miLongitud = 0.0;
var verMapa = true;
PlateRecomend plato = PlateRecomend([], 0, 0, 0, 0, "", 0, 0, "", "", 0);
PlateRecomend plate = PlateRecomend([], 0, 0, 0, 0, "", 0, 0, "", "", 0);

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _RecomemendePlateviewState extends State<RecomemendePlateview>{
  var glucosa = TextEditingController();
  late GoogleMapController _mapController;
  @override
  void initState() {
    super.initState();
    verMapa = true;
  }

  void CalculoInsulina() async{
    List<plateId> foods = plato.foods.map((food) => plateId(food.id)).toList();
    var gluco = glucosa.text.toString();
    print(gluco);
    glucosa.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                calculateinsuline_page(info: DetailInsulin(plato.Carbohydrates, gluco, plato.Proteins, plato.Fats), foods: foods,))
    );
  }

  void centerMapBetweenPoints() {
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        min(miLatitud, plate.latitude),
        min(miLongitud, plate.longitude),
      ),
      northeast: LatLng(
        max(miLatitud, plate.latitude),
        max(miLongitud, plate.longitude),
      ),
    );
    print("${min(miLatitud, plate.latitude)} ,${min(miLongitud, plate.longitude)} ,  ${max(miLatitud, plate.latitude)},  ${max(miLongitud, plate.longitude)}");

    if (_mapController != null){
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  recibirGlucosa(BuildContext context) {
    return showModalBottomSheet(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Registra tu nivel de glucosa", textAlign: TextAlign.center,style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              maxLength: 3,
                              controller: glucosa,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              cursorColor: ColorsGenerals().black,
                              style: TextStyle(color: ColorsGenerals().black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorsGenerals().lightgrey,
                                hintText: 'Inserte nivel de glucosa',
                                hintStyle: TextStyle(color: ColorsGenerals().black),
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset("assets/Icons/glucometro.svg",color: ColorsGenerals().black,cacheColorFilter: false, width: MediaQuery.of(context).size.height/40,),
                                )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese su nivel de glucosa';
                                }
                                return null;
                              },
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/200)),
                            ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  var tutor = await PercisteRepository().UserType();
                                  if(tutor){
                                    var autent = await LocalAuthApi.authenticate();
                                    if(autent){
                                      CalculoInsulina();
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: "Validacion fallida", fontSize: 20);
                                    }
                                  }else{
                                    CalculoInsulina();
                                  }
                                }
                              },
                              child: Text("Cálculo unidades",
                                style: TextStyle(color: ColorsGenerals().whith, fontSize: 15),),
                              style: ElevatedButton.styleFrom(
                                elevation: 8, // elevación de la sombra
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // radio de la esquina redondeada
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                backgroundColor: ColorsGenerals().red, // color de fondo
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Set<Marker> _createMarket(){
    Set<Marker> _markers = {};
    _markers.add(
      Marker(
        markerId: MarkerId('Plato'),
        position: LatLng(plato.latitude, plato.longitude),
        infoWindow: InfoWindow(title: 'Plato'),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('Tu'),
        position: LatLng(miLatitud, miLongitud),
        infoWindow: InfoWindow(title: 'Tu'),
      ),
    );
    return _markers;
  }

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
    Timer(Duration(milliseconds: 100), () {
      centerMapBetweenPoints();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            recibirGlucosa(context);
          },
          child: Text("Comer plato",
            style: TextStyle(color: ColorsGenerals().whith),),
          style: ElevatedButton.styleFrom(
            elevation: 8, // elevación de la sombra
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  30), // radio de la esquina redondeada
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            backgroundColor: Colors.red, // color de fondo
          ),

        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/Icons/atras.svg", color: ColorsGenerals().black,
            cacheColorFilter: false,
            width: MediaQuery
                .of(context)
                .size
                .height / 30,),
          onPressed: () {
            setState(() {
              verMapa = false;
            });
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        actions: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            "Plato recomendado  ",
            style: TextStyle(color: Colors.black, fontSize: 25),
          )
          ],
        )
        ],
      ),
      body: BlocBuilder<RecomemendePlateCubit, RecomemendePlateState>(
        builder: (context, states) {
          switch (states.status) {
            case RecomemendePlatestatus.loading:
              return Center(child: CircularProgressIndicator( color: ColorsGenerals().red,));
              break;
            case RecomemendePlatestatus.success:
              plato = context.read<RecomemendePlateCubit>().plate;
              plate = plato;
              miLatitud = context.read<RecomemendePlateCubit>().getMyPosition().latitude;
              miLongitud = context.read<RecomemendePlateCubit>().getMyPosition().longitude;
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 2.1,
                          decoration: BoxDecoration(
                              color: ColorsGenerals().lightgrey,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 3),
                                ),
                              ]
                          ),
                          child: verMapa? GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng((miLatitud + plate.latitude) / 2, (miLongitud + plate.longitude) / 2),
                              zoom: 14,
                            ),
                            onMapCreated: _onMapCreated,
                            markers: _createMarket(),
                            polylines: {
                              Polyline(
                                polylineId: PolylineId(""),
                                points: context.read<RecomemendePlateCubit>().polinateCordination,
                                color: ColorsGenerals().red,
                                width: 3,
                              )
                            },
                          ):Container(),
                        ),
                        GestureDetector(
                          onTap: (){
                            editplato(context);
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 4.3,
                            decoration: BoxDecoration(
                                color: ColorsGenerals().lightgrey,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.7,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 6,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/Food/plato_v1.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    child: Stack(
                                      children: plato.foods.length < 6
                                          ? ComidasEnPlato(plato.foods)
                                          : ComidasEnPlato(plato.foods)
                                          .sublist(0, 6),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${double.parse(plate.Fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: ColorsGenerals().black)),
                                        Text("Grasas", style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: ColorsGenerals().black),),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${double.parse(plate.Carbohydrates.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: ColorsGenerals().black)),
                                        Text("Carbohidratos", style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: ColorsGenerals().black),),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${double.parse(plate.Proteins.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorsGenerals().black)),
                                        Text("Proteína", style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: ColorsGenerals().black)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case RecomemendePlatestatus.error:
              return Center(child: Text("Algo salio mal :(", style: TextStyle(color: ColorsGenerals().black),),);
              break;
          }
        },
      ),
    );
  }
  List<Posiciones> pos = [
    Posiciones(top: 35, left: 30),
    Posiciones(top: 15, left: 80),
    Posiciones(top: 35, left: 140),
    Posiciones(top: 60, left: 80)
  ];
  editplato(BuildContext context) {
    return showModalBottomSheet(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(color: ColorsGenerals().whith,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Descripción:", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500, fontSize: 17)),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width/1.3,
                                child: Text(plate.Description, style: TextStyle( color: ColorsGenerals().black)),
                              )
                            ],
                          ),
                        ],
                      ),
                      Text("Comida en plato", style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 40),),
                      ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                            physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.7,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: PlatoEditar(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }
  Widget PlatoEditar(BuildContext context) =>
      ListView.builder(
          itemCount: plato.foods.length,
          itemBuilder: (context, index) {
            final plat = plato.foods[index];
            return Padding(padding: EdgeInsets.all(10),
            child: Container(
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 150, left: 3, right: 3),
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorsGenerals().lightgrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 0.5,
                          offset: Offset(0, 1),
                        ),
                      ]
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(plat.name.length > 17 ? plat.name.substring(0,16):plat.name, style: TextStyle(
                              fontSize: 20, color: ColorsGenerals().black)),
                          Row(
                            children: [
                              Container(
                                child: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 80,
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset("assets/Food/${plat.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${double.parse(plat.fats.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: ColorsGenerals().black)),
                              Text("Grasas", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${double.parse(plat.carbs.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: ColorsGenerals().black)),
                              Text("Carbohidratos", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${double.parse(plat.protein.toStringAsFixed(1)).abs()}g", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorsGenerals().black)),
                              Text("Proteína", style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: ColorsGenerals().black)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
            );
          }
      );
  List<Widget> ComidasEnPlato(List<FoodDetail> frut) {
    List<Widget> widgets = [];
    int platoPos = 0;
    for (int i = 0; i < frut.length; i++) {
      final com = frut[i];
      if (platoPos < pos.length && !com.tag.contains("bebida") && !com.tag.contains("sopa")) {
        widgets.add(
          Positioned(
            left: pos[platoPos].left,
            top: pos[platoPos].top,
            child: Material(
              color: Colors.transparent,
              child:  Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
            ),
          ),
        );
        platoPos++;
      } else {
        if(com.tag.contains("bebida")){
          print("Pone la bebida");
          widgets.add(
            Positioned(
              left: 10,
              top: 80,
              child: Material(
                color: Colors.transparent,
                child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
              ),
            ),
          );
        }
        else{
          if(com.tag.contains("sopa")){
            widgets.add(
              Positioned(
                left: 200,
                top: 80,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                ),
              ),
            );
          }else{
            widgets.add(
              Positioned(
                left: 400,
                top: 400,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 60, width: 60,),
                ),
              ),
            );
          }
        }

      }
    }
    return widgets;
  }

}
