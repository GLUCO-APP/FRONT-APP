import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gluko/assembleplate/view/assembleplate_page.dart';
import 'package:intl/intl.dart';
import '../../colors/colorsGenerals.dart';
import '../../home/view/home_page.dart';
import '../cubit/calculateinsulin_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class calculateinsuline_page extends StatelessWidget {
  final DetailInsulin info;
  final List<plateId> foods;
  calculateinsuline_page({required this.info, required this.foods}) ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculateinsulinCubit(RegisterPlateRepository(),RegisterReportRepository())..getInfoUser(),
      child: calculateinsulineview(info, foods),
    );
  }
}

class calculateinsulineview extends StatefulWidget {
  DetailInsulin info;
  List<plateId> foods;
  calculateinsulineview(this.info, this.foods);

  @override
  State<calculateinsulineview> createState() => _calculateinsulineviewState(info, foods);
}

var tags = ["Desayuno","Cena","Almuerzo","Onces","Medias nueves",];
var vista  = TimeOfDay.now().hour > 0 && TimeOfDay.now().hour < 13 ?"Desayuno": TimeOfDay.now().hour > 13 && TimeOfDay.now().hour < 18 ? "Almuerzo": "Cena";
var hora  = TimeOfDay.now().hour > 0 && TimeOfDay.now().hour < 13 ?"am":"pm";
var direccion = TextEditingController();
var Descripcion = TextEditingController();
bool compartir = false;
bool verMapa = true;
GlobalKey<FormState> formKey = GlobalKey<FormState>();

double CalculoUnidades(double glAct, double graCarbo, User use){
  print(use.estable.toDouble());
  print(use.sensitivity);
  print(use.rate.toDouble());
  double glucemiaObjetivo = use.estable.toDouble();
  double glucemiaActual = glAct;
  double sensibilidad = use.sensitivity;
  double dosisCorreccion = (glucemiaObjetivo - glucemiaActual)/sensibilidad;
  double gramosCarbohidratos = graCarbo;
  double ratioInsulina = use.rate.toDouble();
  double dosisInsulina = gramosCarbohidratos/ratioInsulina;
  double unidInsulina =  dosisInsulina.abs()+dosisCorreccion.abs();
  return unidInsulina;
}

Future<bool> checkLocationPermission() async {
  final status = await Permission.locationWhenInUse.status;
  if (status == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}
Future<bool> requestLocationPermission() async {
  final status = await Permission.locationWhenInUse.request();
  if (status == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}

Future<Position> getCurrentLocation() async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}


String text = "";
LatLng _center = LatLng(0, 0);

class  _calculateinsulineviewState extends State<calculateinsulineview>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    direccion.clear();
    Descripcion.clear();
    compartir = false;
  }

  DetailInsulin info;
  List<plateId> foods;
  _calculateinsulineviewState(this.info, this.foods);

  Future<void> showMyPopup(BuildContext context) async {
    String address = "";
    GoogleMapController mapController;
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }
    Future<void> getAddressFromLocation(LatLng position) async {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark place = placemarks[0];
        String addressnew =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
        setState(() {
          address = addressnew;
        });
        print("Direccion Actual: $address");
    }

    void _onCameraMove(CameraPosition position) {
      setState((){
        _center = position.target;
        getAddressFromLocation(position.target);
      });
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  GestureDetector(
          onTap: (){
            setState(() {
              verMapa = false;
            });
            Navigator.pop(context);
          },
          child: Material(
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
                          height: MediaQuery.of(context).size.height/1.6,
                          decoration: BoxDecoration(
                            color: ColorsGenerals().whith,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(-5, 6),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/1.2,
                                height: MediaQuery.of(context).size.height/2,
                                child: Stack(
                                  children: [
                                    verMapa?GoogleMap(
                                      onMapCreated: _onMapCreated,
                                      onCameraMove: _onCameraMove,
                                      initialCameraPosition: CameraPosition(
                                        target: _center,
                                        zoom: 17.0,
                                      ),
                                      myLocationEnabled: true,
                                    ):Container(),
                                    Center(
                                      child:  Icon(Icons.location_on, color: ColorsGenerals().red, size: 40,),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    text = address;
                                    direccion.text = text;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text("Guardar Ubicacion",
                                  style: TextStyle(color: ColorsGenerals().whith),),
                                style: ElevatedButton.styleFrom(
                                  elevation: 8, // elevación de la sombra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        30), // radio de la esquina redondeada
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                  backgroundColor: ColorsGenerals().red, // color de fondo
                                ),

                              ),
                            ],
                          )
                      ),
                    ]
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Future<void> showMyPopupCompartirInfo(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return  GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Material(
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
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(-5, 6),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text("¡Importante!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                              ),
                              Container(
                                child: Text("Para compartir un plato este debe ser una comida fuerte como:\n-Cena\n-Almuerzo\n-Desayuno\nSiempre agreguéle una ubicación con su descripción, por ejemplo:\nAndrés Carne de Res, Hayuelos centro comencial."),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ok",
                                      style: TextStyle(color: ColorsGenerals().whith),),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 8, // elevación de la sombra
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // radio de la esquina redondeada
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      backgroundColor: ColorsGenerals().red, // color de fondo
                                    ),

                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                    ]
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        actions: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            "Cálculo insulina   ",
            style: TextStyle(color: Colors.black, fontSize: 22),
          )
          ],
        )
        ],
      ),
      body: BlocBuilder<CalculateinsulinCubit, CalculateinsulinState>(
        builder: (context, states) {
          switch (states.status) {
            case Calculateinsulinstatus.loading:
              return Center(child: CircularProgressIndicator( color: ColorsGenerals().red,));
              break;
            case Calculateinsulinstatus.success:
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Unidades \nde insulina", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w300, fontSize: 40)),
                            Text("${CalculoUnidades(double.parse(info.gluco), info.carbs, context.read<CalculateinsulinCubit>().infoUser()).toInt()}U", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w300,fontSize: 40)),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.15,
                          height: MediaQuery.of(context).size.height/9,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Carbohidratos",textAlign: TextAlign.left, style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w200, fontSize: 20),),
                                  Text("Glucemia",textAlign: TextAlign.left, style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w200,fontSize: 20)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("${info.carbs}g", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w200,fontSize: 20)),
                                  Text("${info.gluco}", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w200,fontSize: 20),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("  Tipo", style: TextStyle( color: ColorsGenerals().black),),
                                Container(
                                  padding: EdgeInsets.symmetric( horizontal: 20),
                                  height: MediaQuery.of(context).size.height/18,
                                  width: MediaQuery.of(context).size.width/2.2,
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
                                    ],
                                  ),
                                  child: DropdownButton(items: tags.map((String a){
                                    return DropdownMenuItem(child: Text(a, style: TextStyle( color: ColorsGenerals().black, fontFamily: "GlukoFamily", fontWeight: FontWeight.w300, fontSize: 20)), value: a,);
                                  }).toList(),
                                    onChanged:(_value)=>{
                                      setState((){
                                        vista = _value.toString();
                                      }),
                                    },
                                    dropdownColor: ColorsGenerals().lightgrey,
                                    underline: SizedBox(),
                                    hint: Text(vista, style: TextStyle( color: ColorsGenerals().black, fontFamily: "GlukoFamily" , fontWeight: FontWeight.w300, fontSize: 17),),
                                    style: TextStyle( color: ColorsGenerals().black),
                                    borderRadius:BorderRadius.circular(20),
                                    icon: Icon(Icons.keyboard_arrow_down, size: 20,color: ColorsGenerals().black,),
                                    isExpanded: true,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("  Hora", style: TextStyle( color: ColorsGenerals().black),),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                                    ],
                                  ),
                                  child: Text("${DateFormat('h:mm a').format(DateTime.now())}", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w300, fontSize: 17),),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Sí desea compartir su plato para \notros usuarios, agregue una \ndescripción y la ubicación donde \nse puede encontrar el plato.", style: TextStyle( color: ColorsGenerals().black)),
                            Container(
                              width: MediaQuery.of(context).size.width /6,
                              height: MediaQuery.of(context).size.height /9,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage("assets/Logo/gluko_bot_hi.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text("Compartir", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w300, fontSize: 18)),
                              CupertinoSwitch(
                                value: compartir,
                                onChanged: (newValue){
                                  print(foods.length);
                                  if(foods.length >= 5 && (vista == "Almuerzo"||vista == "Cena" || vista == "Desayuno")){
                                    setState(() {
                                      compartir = !compartir;
                                    });
                                  }else{
                                    showMyPopupCompartirInfo(context);
                                  }
                                },
                                trackColor: ColorsGenerals().darkgrey,
                                activeColor: ColorsGenerals().red,
                              )
                            ],
                          ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width/1.5,
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
                                ],
                              ),
                              child: TextField(
                                controller: direccion,
                                enabled: compartir,
                                cursorColor: ColorsGenerals().black,
                                style: TextStyle(color: ColorsGenerals().black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsGenerals().lightgrey,
                                  hintText: 'Dirección',
                                  hintStyle: TextStyle(
                                      color: ColorsGenerals().black),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
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
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
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
                                ],
                              ),
                              child: IconButton( icon: Icon(Icons.location_on_outlined, color: ColorsGenerals().black,),
                                onPressed: compartir? () async {
                                    var validation = await checkLocationPermission();
                                    if (!validation){
                                      await requestLocationPermission();
                                    }else{
                                      var position =  await getCurrentLocation();
                                      setState(() {
                                        _center = LatLng(position.latitude, position.longitude);
                                        verMapa = true;
                                      });
                                      showMyPopup(context);
                                    }
                                }: null,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          height: MediaQuery.of(context).size.height/7,
                          decoration: BoxDecoration(
                            color: ColorsGenerals().lightgrey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Form(
                            child: TextFormField(
                              enabled: compartir,
                              controller: Descripcion,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              cursorColor: ColorsGenerals().black,
                              style: TextStyle(color: ColorsGenerals().black),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorsGenerals().lightgrey,
                                hintText: 'Descripción',
                                hintStyle: TextStyle(
                                    color: ColorsGenerals().black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
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
                              ),
                            ),),
                        ),
                        ElevatedButton(
                      onPressed: () async {
                        if(compartir){
                          if(direccion.text.isNotEmpty){
                            if(Descripcion.text.isNotEmpty){
                              print("Direccion ${direccion.text}, Latitud ${_center.latitude} Longitud ${_center.longitude}");
                              var response =  await context.read<CalculateinsulinCubit>().RegisterPlate(PlateRegister(foods,double.parse(info.gluco),info.carbs, info.protein, info.fats, vista, 1, _center.latitude,_center.longitude,direccion.text,Descripcion.text,"Sin titulo xd"),int.parse(info.gluco), CalculoUnidades(double.parse(info.gluco), info.carbs,context.read<CalculateinsulinCubit>().infoUser()).toInt());
                              if(response){
                                Fluttertoast.showToast(
                                    msg: "Plato Registrado", fontSize: 20);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage()),
                                      (Route<dynamic> route) => false,
                                );
                              }else{
                                Fluttertoast.showToast(
                                    msg: "Error al registrar plato Intenta Mas Tarde", fontSize: 20);
                              }
                            }else{
                              Fluttertoast.showToast(
                                  msg: "Agregue una descripción", fontSize: 20);
                            }
                          }else{
                            Fluttertoast.showToast(
                                msg: "Agregue una dirección", fontSize: 20);
                          }
                        }else{
                          var response =  await context.read<CalculateinsulinCubit>().RegisterPlate(PlateRegister(foods,double.parse(info.gluco),info.carbs, info.protein, info.fats, vista, 0, 0,0,"","",""),int.parse(info.gluco), CalculoUnidades(double.parse(info.gluco), info.carbs,context.read<CalculateinsulinCubit>().infoUser()).toInt());
                          print("Respuesta de registro ${response}");
                          if(response){
                            Fluttertoast.showToast(
                                msg: "Plato registrado", fontSize: 20);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage()),
                                  (Route<dynamic> route) => false,
                            );
                          }else{
                            Fluttertoast.showToast(
                                msg: "Error al registrar plato intenta mas tarde", fontSize: 20);
                          }
                        }
                      },
                      child: Text("Guardar registro",
                        style: TextStyle(color: ColorsGenerals().whith),),
                      style: ElevatedButton.styleFrom(
                        elevation: 8, // elevación de la sombra
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // radio de la esquina redondeada
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        backgroundColor: Colors.red, // color de fondo
                      ),

                    ),
                      ],

                    ),
                  ),
                ),
              );
              break;
            case Calculateinsulinstatus.error:
              return Text("Me petatie");
              break;
          }
        },
      ),
    );
  }
}