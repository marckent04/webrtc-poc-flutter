import 'package:livekit_client/livekit_client.dart';

class MyWebRtc {
  late final Room _room;
  final _url = "wss://testwebrtc.livekit.cloud";

  Room get room {
    return _room;
  }

  final String _token =
      //  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzMxNjY0NzMsImlzcyI6IkFQSVp2bm1yZjlKRHN0SCIsIm5iZiI6MTY3MzA4MDA3Mywic3ViIjoidXNlci05YmMxZmM1NyIsInZpZGVvIjp7InJvb20iOiJyb29tLTg5ZTAyZDU4Iiwicm9vbUpvaW4iOnRydWV9fQ.R47EujxRD3dvodB-98vafKf7AhfkL4Q0xEAHajwDH-0";
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzMxNjY0NzMsImlzcyI6IkFQSVp2bm1yZjlKRHN0SCIsIm5iZiI6MTY3MzA4MDA3Mywic3ViIjoidXNlci03YmUzNGY5MCIsInZpZGVvIjp7InJvb20iOiJyb29tLTg5ZTAyZDU4Iiwicm9vbUpvaW4iOnRydWV9fQ.sa62XjIbfWmD9jwuuetRitgEAnBi3BK3jMPvGy_OJzM";

  RoomOptions get _roomOptions {
    return const RoomOptions(
      adaptiveStream: true,
      dynacast: true,
      // ... your room options
    );
  }

  ConnectOptions get _connectOptions {
    return const ConnectOptions();
  }

  MyWebRtc() {
    _room = Room(connectOptions: _connectOptions, roomOptions: _roomOptions);
  }
  Future<bool> connect() async {
    try {
      await _room.connect(_url, _token, roomOptions: _roomOptions);
      await _room.localParticipant!.setCameraEnabled(true);
      await _room.localParticipant!.setMicrophoneEnabled(true);

      return true;
    } catch (error) {
      print('Could not publish video, error: $error');
      return false;
    }
  }
}
