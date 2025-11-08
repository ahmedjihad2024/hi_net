// import 'dart:async';

// import 'package:back_button_interceptor/back_button_interceptor.dart';
// import 'package:hi_net/presentation/common/ui_components/platform_safe_area.dart';

// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:video_player/video_player.dart';

// /// Controller for CustomVideoPlayer that persists state when toggling fullscreen
// class CustomVideoPlayerController {
//   /// Current playback position
//   double currentPosition = 0.0;

//   /// Duration of the video
//   double duration = 0.0;

//   /// Buffered position
//   double bufferedPosition = 0.0;

//   /// Whether controls are visible
//   bool showControls = true;

//   /// Whether the player is in fullscreen mode
//   bool isFullScreen = false;

//   /// Current playback speed
//   double currentPlaybackSpeed = 1.0;

//   /// Whether progress bar is being dragged
//   bool isDraggingProgress = false;

//   /// Whether the video was playing before dragging began
//   bool wasPlayingBeforeDrag = false;

//   /// Timer for hiding controls
//   Timer? hideControlsTimer;

//   /// Video player controller
//   // final VideoPlayerController videoPlayerController;

//   CustomVideoPlayerController();

//   /// Dispose resources
//   void dispose() {
//     hideControlsTimer?.cancel();
//   }
// }

// class CustomVideoPlayer extends StatefulWidget {
//   final VideoPlayerController controller;
//   final Color progressColor;
//   final Color bufferedColor;
//   final Color controlsBackgroundColor;
//   final Color controlsColor;
//   final Duration autoHideControlsAfter;
//   final bool allowFullScreen;
//   final Widget? placeholder;
//   final double controlsOpacity;
//   final List<double> playbackSpeeds;
//   final double progressBarHeight;
//   final double progressThumbSize;
//   final TextStyle timeTextStyle;
//   final TextStyle speedTextStyle;
//   final BorderRadius speedButtonBorderRadius;
//   final EdgeInsets controlsPadding;
//   final ButtonStyle fullScreenButtonStyle;
//   final ButtonStyle playPauseButtonStyle;
//   final Duration controlsAnimationDuration;
//   final Curve controlsAnimationCurves;
//   final double? customAspectRatio;
//   final Widget? next10SecondsButtonIcon;
//   final Widget? previous10SecondsButtonIcon;
//   final ButtonStyle? next10SecondsButtonStyle;
//   final ButtonStyle? previous10SecondsButtonStyle;
//   final CustomVideoPlayerController? playerController;

//   const CustomVideoPlayer({
//     super.key,
//     required this.controller,
//     this.progressColor = Colors.white,
//     this.bufferedColor = Colors.grey,
//     this.controlsBackgroundColor = Colors.transparent,
//     this.controlsColor = Colors.white,
//     this.autoHideControlsAfter = const Duration(seconds: 4),
//     this.allowFullScreen = true,
//     this.placeholder,
//     this.controlsOpacity = 1.0,
//     this.playbackSpeeds = const [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0],
//     this.progressBarHeight = 3.0,
//     this.progressThumbSize = 8.0,
//     this.speedButtonBorderRadius = const BorderRadius.all(Radius.circular(16)),
//     this.timeTextStyle = const TextStyle(color: Colors.white, fontSize: 12),
//     this.speedTextStyle = const TextStyle(
//         color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//     this.controlsPadding =
//         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     this.fullScreenButtonStyle = const ButtonStyle(
//       padding: WidgetStatePropertyAll(EdgeInsets.zero),
//       minimumSize: WidgetStatePropertyAll(Size(24.0, 24.0)),
//       backgroundColor: WidgetStatePropertyAll(Colors.transparent),
//       foregroundColor: WidgetStatePropertyAll(Colors.white),
//     ),
//     this.playPauseButtonStyle = const ButtonStyle(
//       padding: WidgetStatePropertyAll(EdgeInsets.zero),
//       minimumSize: WidgetStatePropertyAll(Size(24.0, 24.0)),
//       backgroundColor: WidgetStatePropertyAll(Colors.transparent),
//       foregroundColor: WidgetStatePropertyAll(Colors.white),
//     ),
//     this.controlsAnimationDuration = const Duration(milliseconds: 1000),
//     this.controlsAnimationCurves = Curves.fastEaseInToSlowEaseOut,
//     this.customAspectRatio,
//     this.next10SecondsButtonIcon,
//     this.previous10SecondsButtonIcon,
//     this.next10SecondsButtonStyle,
//     this.previous10SecondsButtonStyle,
//     this.playerController,
//   });

//   @override
//   State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
// }

// class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
//   late CustomVideoPlayerController _playerController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controller or use provided one
//     _playerController =
//         widget.playerController ?? CustomVideoPlayerController();

//     widget.controller.addListener(_videoListener);
//     if (widget.controller.value.isInitialized) {
//       final duration =
//           widget.controller.value.duration.inMilliseconds.toDouble();
//       setState(() {
//         _playerController.duration = duration;
//       });
//     }
//     _resetHideControlsTimer();
//   }

//   @override
//   void dispose() {
//     if (widget.playerController == null) {
//       _playerController.dispose();
//     }
//     widget.controller.removeListener(_videoListener);
//     super.dispose();
//   }

//   void _videoListener() {
//     if (mounted && !_playerController.isDraggingProgress) {
//       final controller = widget.controller;
//       final position = controller.value.position.inMilliseconds.toDouble();
//       final duration = controller.value.duration.inMilliseconds.toDouble();
//       final buffered = controller.value.buffered.isNotEmpty
//           ? controller.value.buffered.last.end.inMilliseconds.toDouble()
//           : 0.0;

//       setState(() {
//         _playerController.currentPosition = position;
//         _playerController.duration = duration;
//         _playerController.bufferedPosition = buffered;
//       });
//     }
//   }

//   void _resetHideControlsTimer() {
//     _playerController.hideControlsTimer?.cancel();
//     _playerController.hideControlsTimer =
//         Timer(widget.autoHideControlsAfter, () {
//       if (mounted &&
//           widget.controller.value.isPlaying &&
//           !_playerController.isDraggingProgress) {
//         setState(() {
//           _playerController.showControls = false;
//         });
//       }
//     });
//   }

//   void _toggleControls() {
//     setState(() {
//       _playerController.showControls = !_playerController.showControls;
//     });

//     if (_playerController.showControls) {
//       _resetHideControlsTimer();
//     } else {
//       _playerController.hideControlsTimer?.cancel();
//     }
//   }

//   void _togglePlayPause() {
//     setState(() {
//       if (widget.controller.value.isPlaying) {
//         widget.controller.pause();
//       } else {
//         widget.controller.play();
//         _resetHideControlsTimer();
//       }
//     });
//   }

//   void _cyclePlaybackSpeed() {
//     // Find the next speed in the list
//     int currentIndex =
//         widget.playbackSpeeds.indexOf(_playerController.currentPlaybackSpeed);
//     int nextIndex = (currentIndex + 1) % widget.playbackSpeeds.length;
//     double nextSpeed = widget.playbackSpeeds[nextIndex];

//     setState(() {
//       _playerController.currentPlaybackSpeed = nextSpeed;
//       widget.controller.setPlaybackSpeed(nextSpeed);
//     });
//     _resetHideControlsTimer();
//   }

//   void _toggleFullScreen() async {
//     setState(() {
//       _playerController.isFullScreen = !_playerController.isFullScreen;
//     });

//     if (_playerController.isFullScreen) {
//       await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//       await SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//       BackButtonInterceptor.add(_backButtonInterceptor);
//     } else {
//       await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       await SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//       BackButtonInterceptor.remove(_backButtonInterceptor);
//     }

//     _resetHideControlsTimer();
//   }

//   bool _backButtonInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
//     if (_playerController.isFullScreen) {
//       _toggleFullScreen();
//       print("back button interceptor");
//       return true;
//     }
//     return false;
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));

//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     // this outer aspect ratio is used when the video is in portrait mode [width < height]
//     final outerAspectRatio = widget.controller.value.aspectRatio > 1
//         ? widget.controller.value.aspectRatio
//         : 16 / 9;
//     // this outer aspect ratio is used when the video is in landscape mode
//     final outerAspectRatioFullScreen = _playerController.isFullScreen
//         ? (1.sw / 1.sh)
//         : (widget.customAspectRatio ?? outerAspectRatio);

//     return GestureDetector(
//       onTap: _toggleControls,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Video player
//           widget.controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: outerAspectRatioFullScreen,
//                   child: Container(
//                     color: Colors.black,
//                     child: Center(
//                       child: AspectRatio(
//                         aspectRatio: widget.controller.value.aspectRatio,
//                         child: VideoPlayer(widget.controller),
//                       ),
//                     ),
//                   ),
//                 )
//               : widget.placeholder ??
//                   Container(
//                     color: Colors.black,
//                     child: Center(
//                       child: CircularProgressIndicator(
//                           color: widget.controlsColor),
//                     ),
//                   ),

//           // background
//           if (_playerController.showControls)
//             AnimatedOpacity(
//               opacity: _playerController.showControls ? 1.0 : 0.0,
//               duration: widget.controlsAnimationDuration,
//               curve: widget.controlsAnimationCurves,
//               child: AspectRatio(
//                 aspectRatio: outerAspectRatioFullScreen,
//                 child: Container(
//                   color: widget.controlsBackgroundColor,
//                 ),
//               ),
//             ),

//           // Play/Pause button (centered)
//           if (_playerController.showControls)
//             AnimatedOpacity(
//               opacity: _playerController.showControls ? 1.0 : 0.0,
//               duration: widget.controlsAnimationDuration,
//               curve: widget.controlsAnimationCurves,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 spacing: 12.w,
//                 children: [
//                   // seek 10 seconds back
//                   IconButton(
//                     icon: widget.previous10SecondsButtonIcon ??
//                         Icon(
//                           Icons.replay_10_rounded,
//                         ),
//                     onPressed: () {
//                       widget.controller.seekTo(Duration(
//                           milliseconds:
//                               _playerController.currentPosition.toInt() -
//                                   (10 * 1000)));
//                     },
//                     padding: EdgeInsets.zero,
//                     style: widget.previous10SecondsButtonStyle,
//                     constraints: BoxConstraints(),
//                   ),

//                   IconButton(
//                     icon: Icon(
//                       (widget.controller.value.isPlaying
//                           ? Icons.pause_rounded
//                           : Icons.play_arrow_rounded),
//                     ),
//                     onPressed: _togglePlayPause,
//                     padding: EdgeInsets.zero,
//                     style: widget.playPauseButtonStyle,
//                     constraints: BoxConstraints(),
//                   ),

//                   // seek 10 seconds forward
//                   IconButton(
//                     icon: widget.next10SecondsButtonIcon ??
//                         Icon(
//                           Icons.forward_10_rounded,
//                         ),
//                     onPressed: () {
//                       widget.controller.seekTo(Duration(
//                           milliseconds:
//                               _playerController.currentPosition.toInt() +
//                                   (10 * 1000)));
//                     },
//                     padding: EdgeInsets.zero,
//                     style: widget.next10SecondsButtonStyle,
//                     constraints: BoxConstraints(),
//                   ),
//                 ],
//               ),
//             ),

//           // Speed button
//           if (_playerController.showControls)
//             Positioned(
//               top: 0,
//               right: 0,
//               child: AnimatedOpacity(
//                 opacity: _playerController.showControls ? 1.0 : 0.0,
//                 duration: widget.controlsAnimationDuration,
//                 curve: widget.controlsAnimationCurves,
//                 child: Padding(
//                   padding: widget.controlsPadding,
//                   child: InkWell(
//                     onTap: _cyclePlaybackSpeed,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         '${_playerController.currentPlaybackSpeed}x',
//                         style: widget.speedTextStyle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//           // Bottom controls - Progress bar and time
//           if (_playerController.showControls)
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: AnimatedOpacity(
//                 opacity: _playerController.showControls
//                     ? widget.controlsOpacity
//                     : 0.0,
//                 duration: widget.controlsAnimationDuration,
//                 curve: widget.controlsAnimationCurves,
//                 child: Padding(
//                   padding: widget.controlsPadding,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Time and controls row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Time display
//                           Text(
//                             '${_formatDuration(Duration(milliseconds: _playerController.currentPosition.toInt()))} / ${_formatDuration(Duration(milliseconds: _playerController.duration.toInt()))}',
//                             style: widget.timeTextStyle,
//                           ),

//                           // Control buttons
//                           Row(
//                             children: [
//                               // Fullscreen button
//                               if (widget.allowFullScreen)
//                                 IconButton(
//                                   icon: Icon(
//                                     _playerController.isFullScreen
//                                         ? Icons.fullscreen_exit_rounded
//                                         : Icons.fullscreen_rounded,
//                                   ),
//                                   onPressed: _toggleFullScreen,
//                                   padding: EdgeInsets.zero,
//                                   style: widget.fullScreenButtonStyle,
//                                   constraints: BoxConstraints(),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       // Progress bar
//                       SliderTheme(
//                         data: SliderThemeData(
//                           trackHeight: widget.progressBarHeight,
//                           thumbShape: RoundSliderThumbShape(
//                             enabledThumbRadius: widget.progressThumbSize / 2,
//                           ),
//                           overlayShape: RoundSliderOverlayShape(
//                             overlayRadius: widget.progressThumbSize,
//                           ),
//                           trackShape: _CustomTrackShape(
//                             bufferedValue: _playerController.bufferedPosition /
//                                 (_playerController.duration > 0
//                                     ? _playerController.duration
//                                     : 1.0),
//                             bufferedColor: widget.bufferedColor,
//                           ),
//                           activeTrackColor: widget.progressColor,
//                           inactiveTrackColor:
//                               widget.progressColor.withOpacity(0.3),
//                           thumbColor: widget.progressColor,
//                           overlayColor: widget.progressColor.withOpacity(0.3),
//                         ),
//                         child: Slider(
//                           value: _playerController.currentPosition,
//                           min: 0.0,
//                           max: _playerController.duration > 0
//                               ? _playerController.duration
//                               : 1.0,
//                           onChanged: (value) {
//                             setState(() {
//                               _playerController.currentPosition = value;
//                             });
//                             // Seek in real-time while dragging
//                             widget.controller
//                                 .seekTo(Duration(milliseconds: value.toInt()));
//                           },
//                           onChangeStart: (value) {
//                             _playerController.wasPlayingBeforeDrag =
//                                 widget.controller.value.isPlaying;
//                             if (_playerController.wasPlayingBeforeDrag) {
//                               widget.controller.pause();
//                             }
//                             setState(() {
//                               _playerController.isDraggingProgress = true;
//                             });
//                           },
//                           onChangeEnd: (value) {
//                             // Final seek to ensure accuracy
//                             widget.controller
//                                 .seekTo(Duration(milliseconds: value.toInt()));
//                             if (_playerController.wasPlayingBeforeDrag) {
//                               widget.controller.play();
//                             }
//                             setState(() {
//                               _playerController.isDraggingProgress = false;
//                             });
//                             _resetHideControlsTimer();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // Custom track shape to show buffered progress
// class _CustomTrackShape extends RoundedRectSliderTrackShape {
//   final double bufferedValue;
//   final Color bufferedColor;

//   const _CustomTrackShape({
//     required this.bufferedValue,
//     this.bufferedColor = Colors.grey,
//   });

//   @override
//   void paint(
//     PaintingContext context,
//     Offset offset, {
//     required RenderBox parentBox,
//     required SliderThemeData sliderTheme,
//     required Animation<double> enableAnimation,
//     required TextDirection textDirection,
//     required Offset thumbCenter,
//     Offset? secondaryOffset,
//     bool isDiscrete = false,
//     bool isEnabled = false,
//     double additionalActiveTrackHeight = 0,
//   }) {
//     // Paint the regular track
//     super.paint(
//       context,
//       offset,
//       parentBox: parentBox,
//       sliderTheme: sliderTheme,
//       enableAnimation: enableAnimation,
//       textDirection: textDirection,
//       thumbCenter: thumbCenter,
//       isDiscrete: isDiscrete,
//       isEnabled: isEnabled,
//     );

//     // Paint the buffered track
//     final Rect trackRect = getPreferredRect(
//       parentBox: parentBox,
//       offset: offset,
//       sliderTheme: sliderTheme,
//       isEnabled: isEnabled,
//       isDiscrete: isDiscrete,
//     );

//     final double trackWidth = trackRect.width;
//     final double bufferedWidth = trackWidth * bufferedValue;

//     // Always paint the buffered track, not just when buffering
//     if (bufferedValue > 0) {
//       final Paint bufferedPaint = Paint()
//         ..color = bufferedColor
//         ..style = PaintingStyle.fill;

//       final Rect bufferedRect = textDirection == TextDirection.ltr
//           ? Rect.fromLTWH(
//               trackRect.left,
//               trackRect.top,
//               bufferedWidth,
//               trackRect.height,
//             )
//           : Rect.fromLTWH(
//               trackRect.right - bufferedWidth,
//               trackRect.top,
//               bufferedWidth,
//               trackRect.height,
//             );

//       context.canvas.drawRect(bufferedRect, bufferedPaint);
//     }
//   }
// }
