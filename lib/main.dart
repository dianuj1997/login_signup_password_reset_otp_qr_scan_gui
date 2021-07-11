import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sampleproject/login.dart';
import 'package:sampleproject/main_page.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';


//**********************************************************************************************************
// void callbackDispatcher() {
//   Workmanager.executeTask((task, inputData) {
//     print("Native called background task: $backgroundTask"); //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }
//*********************************************************************************************************
// Future<void> startService()
// async {
//   if(Platform.isAndroid)
//   {
//     var methodChannel=MethodChannel("com.example.messages");
//     String data=await methodChannel.invokeMethod("startService");
//     debugPrint(data);
//
//   }
// }

void main() {
  //******************************************************************************************************************************
  // Workmanager.initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );
  //******************************************************************************************************************************
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Login',
    home: PictureForm(),
    theme: ThemeData(
        primaryColor: Colors.indigoAccent, accentColor: Colors.indigoAccent),
  ));
}

class PictureForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PictureFormState();
  }
}

class _PictureFormState extends State<PictureForm> {

  final _minpad = 5.0;
  final cryptor = new PlatformStringCryptor();
  void getPermission() async {
    print("getPermission");
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }



  /// Initialise the state
  @override
  void initState() {
    getPermission();
    super.initState();

    /// We require the initializers to run after the loading screen is rendered
     Timer(Duration(seconds: 3), () {
       SchedulerBinding.instance.addPostFrameCallback((_) {

         runInitTasks();
       });
        });

  }
  @protected
  Future runInitTasks() async {
    String x=await getStringValuesSF();
    if (x!=null)
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return MainForm();
            }));
      }
    else {
      final String k1 = await cryptor.generateRandomKey();
      final String k2 = await cryptor.generateRandomKey();

      print("key1 :" + k1.toString());
      print("key2 :" + k2.toString());
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return LoginForm();
          }));
    }
  }

  // local_store() async {}

  // retrieving_keys() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey("userData")) {
  //     return "No user key found";
  //   }
  //   final extractedUserData =
  //       json.decode(prefs.getString("userData")) as Map<String, Object>;
  //   final k_username = extractedUserData["k_username"];
  //   print("Username Key: " + k_username.toString());
  //   return k_username;
  // }



  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle=Theme.of(context).textTheme.title;

    return Scaffold(
        backgroundColor: Colors.black,
        body: new InkWell(
          child: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
          /// Paint the area where the inner widgets are loaded with the
          /// background to keep consistency with the screen background
          new Container(
          decoration: BoxDecoration(color: Colors.black),
        ),
        /// Render the background image
        new Container(
          child: Image.asset('images/picture_fig.jpg', fit: BoxFit.cover),
        ),
        /// Render the Title widget, loader and messages below each other
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        new Expanded(
        flex: 3,
          child: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
            new Padding(
            padding: const EdgeInsets.only(top: 30.0),
          ),

          ],
        )),
    ),
    Expanded(
    flex: 1,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    /// Loader Animation Widget
    CircularProgressIndicator(
    valueColor: new AlwaysStoppedAnimation<Color>(
    Colors.white),
    ),
    Padding(
    padding: const EdgeInsets.only(top: 20.0),
    ),
    Text('Please Wait'),
    ],
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    );
  }
}
getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('stringValue');
  return stringValue;
}


