import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:vzadi/core/utils/app_strings.dart';
import 'package:vzadi/core/utils/app_style.dart';

import '../../../../core/utils/app_colors.dart';
class MediaScreen extends StatefulWidget {
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      'https://st4.depositphotos.com/24244138/38173/v/600/depositphotos_381731600-stock-video-the-architecture-of-kyiv-ukraine.mp4'
    );

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon : Icon(Icons.arrow_back_ios,color: AppColors.white),
          onPressed: (){
          },
        ),
        backgroundColor: AppColors.primaryColor,
        title: Text(AppStrings.videoPlayer,style: secondaryTextStyle(color: AppColors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}