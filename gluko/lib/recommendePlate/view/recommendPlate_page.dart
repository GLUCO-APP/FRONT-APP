import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../calculateinsulin/view/calculateinsulina_page.dart';
import '../../colors/colorsGenerals.dart';
import '../cubit/recomemende_plate_cubit.dart';

class RecomemendePlatepage extends StatelessWidget {
  final PlateRecomend plate;
  RecomemendePlatepage(this.plate);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecomemendePlateCubit()..getCurrentLocation(),
      child: RecomemendePlateview(plate),
    );
  }
}

class RecomemendePlateview extends StatefulWidget {
  PlateRecomend plate;
  RecomemendePlateview(this.plate);
  @override
  State<RecomemendePlateview> createState() => _RecomemendePlateviewState(plate);
}

var platoLatitud = 0.0;
var platoLongitud = 0.0;
var miLatitud = 0.0;
var miLongitud = 0.0;
PlateRecomend plato = PlateRecomend([], 0, 0, 0, 0, "", 0, 0, "", "", 0);

GlobalKey<FormState> formKey = GlobalKey<FormState>();
class _RecomemendePlateviewState extends State<RecomemendePlateview>{
  var glucosa = TextEditingController();
  PlateRecomend plate;
  _RecomemendePlateviewState(this.plate);
  Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    plato = plate;
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
            List<plateId> foods = plato.foods.map((food) => plateId(food.id)).toList();
            if (formKey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          calculateinsuline_page(info: DetailInsulin(plato.Carbohydrates, glucosa.text, plato.Proteins, plato.Fats), foods: foods,))
              );
            }
          },
          child: Text("Calculo Insulina",
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
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorsGenerals().whith,
        elevation: 1,
        actions: [Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            "Plato Recomendado  ",
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
              GoogleMapController mapController;
              void _onMapCreated(GoogleMapController controller) {
                mapController = controller;
                _markers.forEach((marker) {
                  controller.showMarkerInfoWindow(marker.markerId);
                });
              }
              miLatitud = context.read<RecomemendePlateCubit>().getMyPosition().latitude;
              miLongitud = context.read<RecomemendePlateCubit>().getMyPosition().longitude;
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
              Polyline _polyline = Polyline(
                polylineId: PolylineId('linea'),
                color: Colors.red,
                width: 3,
                points: [
                  LatLng(plato.latitude, plato.longitude),
                  LatLng(miLatitud, miLongitud),
                ],
              );
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.2,
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
                              .height / 3.2,
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
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng((miLatitud + plate.latitude) / 2, (miLongitud + plate.longitude) / 2),
                              zoom: 14,
                            ),
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            polylines: Set<Polyline>.of([_polyline]),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Container(
                            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/40 ),
                            height: MediaQuery.of(context).size.height/8,
                            width: MediaQuery.of(context).size.width/1.2,
                            child: TextFormField(
                              maxLength: 3,
                              controller: glucosa,
                              keyboardType: TextInputType.number,
                              cursorColor: ColorsGenerals().black,
                              style: TextStyle(color: ColorsGenerals().black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsGenerals().lightgrey,
                                  hintText: 'Ingrese glucemia',
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
                          ),
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
                                        Text("Proteina", style: TextStyle(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Descripcion:", style: TextStyle( color: ColorsGenerals().black, fontWeight: FontWeight.w500, fontSize: 16)),
                                Wrap(
                                  direction: Axis.vertical,
                                  spacing: 10,
                                  children: [
                                    Text(plate.Description, style: TextStyle( color: ColorsGenerals().black)),
                                  ],
                                )
                              ],
                            ),
                          ],
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
                      Text("Camida en plato", style: TextStyle(
                          color: ColorsGenerals().black,
                          fontWeight: FontWeight.w300,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .height / 30),),
                      ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                            physics: BouncingScrollPhysics() // Establecer el color de la animación de desplazamiento
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 2.3,
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
                              Text("Proteina", style: TextStyle(
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
      if (platoPos < pos.length && com.tag != "bebida" && com.tag != "sopa") {
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
        if(com.tag == "bebida"){
          print("Pone la bebida");
          widgets.add(
            Positioned(
              left: 10,
              top: 120,
              child: Material(
                color: Colors.transparent,
                child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
              ),
            ),
          );
        }
        else{
          if(com.tag == "sopa"){
            widgets.add(
              Positioned(
                left: 200,
                top: 120,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
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
                  child: Image.asset("assets/Food/${com.image.replaceAll('.jpg', '.png')}", height: 80, width: 80,),
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