import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'dart:math' as math;

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  //late final RtcEngine _rtcEngine;
  int? remoteUid;

  @override
  void initState() {
    super.initState();
    //initializeAgora();
  }

  // Future<void> initializeAgora() async {
  //   _rtcEngine = await RtcEngine.create('YOUR_AGORA_APP_ID');
  //   await _rtcEngine.enableVideo();
  //   _rtcEngine.setEventHandler(RtcEngineEventHandler(
  //     joinChannelSuccess: (String channel, int uid, int elapsed) {
  //       print('joinChannelSuccess $channel $uid');
  //     },
  //     userJoined: (int uid, int elapsed) {
  //       setState(() {
  //         remoteUid = uid;
  //       });
  //     },
  //   ));
  //   await _rtcEngine.joinChannel(null, 'YOUR_CHANNEL_NAME', null, 0);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.pending_outlined, size: 30),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: _renderLocalPreview(),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: _renderRemoteVideo(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[400]
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_outlined),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey[400]
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.videocam_outlined),
                  ),
                ),
                Transform.rotate(
                  angle: math.pi/2,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[400]
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone_disabled),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderLocalPreview() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // Bo góc
        border: Border.all(color: Colors.white, width: 2), // Viền
        color: Colors.lightGreen[300], // Màu nền xanh
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.person, size: 100),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.mic_off_sharp, size: 30,),
          ),
          Positioned(
            bottom: 10,
            child: Text(
              'Alex',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderRemoteVideo() {
    if (remoteUid != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Bo góc
          border: Border.all(color: Colors.white, width: 2), // Viền
          color: Colors.blue[200], // Màu nền xanh
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.person, size: 100),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.mic_off_sharp, size: 30,),
            ),
            Positioned(
              bottom: 10,
              child: Text(
                'Alex Xu',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }
    // else {
    //   return SizedBox();
    // }
    else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Bo góc
          border: Border.all(color: Colors.white, width: 2), // Viền
          color: Colors.blue[200], // Màu nền xanh
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.person, size: 100),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.mic_off_sharp, size: 30,),
            ),
            Positioned(
              bottom: 10,
              child: Text(
                'Luis Pham',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }
  }

  // @override
  // void dispose() {
  //   _rtcEngine.leaveChannel();
  //   _rtcEngine.destroy();
  //   super.dispose();
  // }
}
