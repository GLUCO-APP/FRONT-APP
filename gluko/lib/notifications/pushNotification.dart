import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gluko_repository/gluko_repository.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  late final LocalNotificationService notifictions;
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@drawable/icono');

    IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'channel_name',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
    IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }


  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: true,
          isForegroundMode: false,
          initialNotificationContent:"",
          initialNotificationTitle:"",
        ), iosConfiguration: IosConfiguration(onForeground: onStart,autoStart: true));
    service.startService();
  }
  Future<void> coneccionNoti() async{
    try{
      IO.Socket socket = IO.io('http://prueba2-env.eba-i9peqcmf.us-east-1.elasticbeanstalk.com',
          OptionBuilder()
              .setTransports(['websocket']).build());

      socket.onConnect((_) {
        print('connect');
      });
      var cont = 1;
      print("muestra data");
      socket.on("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1YW5AZXhhbXBsZS5jb20iLCJpYXQiOjE2ODE2MTkxMjl9.2sN6SSX6sC9OuANUhK3hbWYkwRj8BtUjV9s_kHttpzI", (data)  async => {
        print("conecta al socket"),
        print(data),
        if( cont == 1){
          notifictions = LocalNotificationService(),
          notifictions.intialize(),
          await notifictions.showNotification(id: 0, title: data, body: ""),
          cont++,
        }else{
          await notifictions.showNotification(id: 0, title: data, body: ""),
        }

      });
    }catch(ex){
      print("fallas");
    }
  }

  static void onStart(ServiceInstance service){
    print("Inician las notificaciones");
    LocalNotificationService().coneccionNoti();
    var notifictions = LocalNotificationService();
    notifictions.intialize();
    infoUserRepository().getInfoUser().then((user) => {
        Timer.periodic(Duration(minutes:1), (timer) {
        var now = DateTime.now();
        var formattedTime = DateFormat.Hm().format(now);
        String Basal = "8:00:00";
        if(Basal.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Conectar basal", body: "Se debe ingerir insulina Basal");
        }
        if(user.breakfast_start.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Hora Desayuno", body: "Recordatiorio para comer");
        }
        if(user.breakfast_end.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Hora Desayuno", body: "Recordatiorio para comer");
        }
        if(user.lunch_start.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Hora Almuerzo", body: "Recordatiorio para comer");
        }
        if(user.lunch_end.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Hora Almuerzo", body: "Recordatiorio para comer");
        }
        if(user.dinner_start.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Hora Cenar", body: "Recordatiorio para comer");
        }
        if(user.dinner_end.contains(formattedTime.toString())){
        notifictions.showNotification(id: 0, title: "Hora Cenar", body: "Recordatiorio para comer");
        }
        }),
    });

  }


}

