import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:webrtc/webrtc/widgets/participant.dart';

class RoomWidget extends StatefulWidget {
  final Room room;

  const RoomWidget(this.room, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _RoomState();
  }
}

class _RoomState extends State<RoomWidget> {
  late final EventsListener<RoomEvent> _listener = widget.room.createListener();

  Participant? _participant;
  connectParticipantIfPresent() {
    final a = widget.room.participants;
    if (widget.room.participants.isNotEmpty) {
      setState(() {
        _participant = widget.room.participants.values.firstWhere((element) =>
            element.identity != widget.room.localParticipant?.identity);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // used for generic change updates
    widget.room.addListener(_onChange);

    connectParticipantIfPresent();
    // used for specific events
    _listener
      ..on<RoomDisconnectedEvent>((_) {
        // handle disconnect
      })
      ..on<ParticipantDisconnectedEvent>((_) {
        setState(() {
          _participant = null;
        });
      })
      ..on<ParticipantConnectedEvent>((e) {
        setState(() {
          _participant = e.participant;
        });
        print("participant joined: ${e.participant.identity}");
      });
  }

  @override
  void dispose() {
    // be sure to dispose listener to stop listening to further updates
    _listener.dispose();
    widget.room.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    final part = widget.room.participants.values;
    // perform computations and then call setState
    // setState will trigger a build
    setState(() {
      // your updates here
    });
  }

  @override
  Widget build(BuildContext context) {
    //return ParticipantWidget(widget.room.localParticipant!);
    return Stack(
      children: [
        Positioned.fill(child: Builder(builder: (context) {
          if (_participant == null) {
            return const Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                  child: Text(
                "Votre interlocuteur n'est pas encore connecté, veuillez patienter",
                textAlign: TextAlign.center,
              )),
            );
          }

          return ParticipantWidget(_participant!);
        })),
        Positioned(
            bottom: 15,
            right: 15,
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.5,
                child: ParticipantWidget(widget.room.localParticipant!)))
      ],
    );
  }
}
