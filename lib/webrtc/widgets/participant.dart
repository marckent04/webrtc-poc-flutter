import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class ParticipantWidget extends StatefulWidget {
  final Participant participant;

  const ParticipantWidget(this.participant);

  @override
  State<StatefulWidget> createState() {
    return _ParticipantState();
  }
}

class _ParticipantState extends State<ParticipantWidget> {
  TrackPublication? videoPub;

  @override
  void initState() {
    super.initState();
    // When track subscriptions change, Participant notifies listeners
    // Uses the built-in ChangeNotifier API
    widget.participant.addListener(_onChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.participant.removeListener(_onChange);
  }

  void _onChange() {
    TrackPublication? pub;
    final tracks = widget.participant.videoTracks;
    var visibleVideos = tracks.where((pub) {
      return pub.kind == TrackType.VIDEO && pub.subscribed && !pub.muted;
    });
    if (visibleVideos.isNotEmpty) {
      pub = visibleVideos.first;
    }
    // setState will trigger a build
    setState(() {
      // your updates here
      videoPub = pub;
    });
  }

  @override
  Widget build(BuildContext context) {
    var videoPub = this.videoPub;
    if (videoPub != null) {
      return VideoTrackRenderer(videoPub.track as VideoTrack);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
