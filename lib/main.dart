import 'package:flutter/material.dart';
import 'package:webrtc/webrtc/client.dart';
import 'package:webrtc/webrtc/widgets/room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool? loaded;
  final MyWebRtc _rtc = MyWebRtc();

  @override
  void initState() {
    _rtc.connect().then((value) {
      setState(() {
        loaded = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (loaded == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (loaded == false) {
          return const Center(child: Text("Desole une erreur est survenue"));
        }

        return RoomWidget(_rtc.room);
      }),
    );
  }
}
