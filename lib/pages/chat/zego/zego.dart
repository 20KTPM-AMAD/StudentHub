import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studenthub/utils/auth_provider.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoCallPage extends StatelessWidget {
  final String conferenceID;

  const VideoCallPage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   var loginUser =
            Provider.of<AuthProvider>(context, listen: false).loginUser;

    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID:
            916369138, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            "b5e1b596bc2cfcda0290884f4d1cc36cc55d0f960f25b5694a2ba1c494dc171c", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: loginUser!.id.toString(),
        userName: loginUser.fullname ?? '',
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}