import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart'
    as youtube_explode;
import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:http/http.dart' as http;

class CustomVideoPlayer extends StatefulWidget {
  CustomVideoPlayer({
    super.key,
    required this.youtubeId,
    this.hlsVideo,
    this.autoPlay = true,
    this.addListener,
    this.isDesktop = false,
    required this.name,
    required this.phone,
  }) {
    MediaKit.ensureInitialized();
  }

  final String name;
  final String phone;

  bool isDesktop = false;
  String youtubeId = '';
  String? hlsVideo = '';
  bool? autoPlay = true;
  Function(
    Duration currentPosition,
    Duration duration,
  )? addListener;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerYoutubeState();
}

class _CustomVideoPlayerYoutubeState extends State<CustomVideoPlayer> {
  List<CustomVideoModel> videoQualities = [];
  final player = Player();
  final speedRates = {
    '1.0x': 1.0,
    '1.5x': 1.5,
    '1.75x': 1.75,
    '2.0x': 2.0,
    '2.5x': 2.5,
    '3.0x': 3.0,
    '3.5x': 3.5,
    '4.0x': 4.0,
  };
  final configuration = ValueNotifier<VideoControllerConfiguration>(
    const VideoControllerConfiguration(enableHardwareAcceleration: true),
  );
  late final VideoController controller = VideoController(
    player,
    configuration: configuration.value,
  );
  late CustomVideoModel video;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.youtubeId.isNotEmpty) {
      youtubeVideo();
    } else if (widget.hlsVideo!.isNotEmpty) {
      hlsVideo();
    } else {
      throw 'No video source provided';
    }
  }

  youtubeVideo() async {
    await fetchVideoYoutubeQualities(widget.youtubeId).then((value) {
      videoQualities = value;
    });
    debugPrint('videoQualities: $videoQualities');
    debugPrint('videoQualities: ${videoQualities.length}');

    video = videoQualities.firstWhere(
        (element) =>
            element.qualityLabel == '720p' || element.qualityLabel == '720p50',
        orElse: () => videoQualities.first);

    await player.open(
      Media(
        video.videoUrl,
      ),
      play: widget.autoPlay!,
    );
    await Future.delayed(Duration(milliseconds: 500));

    await player.setAudioTrack(AudioTrack.uri(
      video.audioUrl,
      title: "default",
      language: "default",
    ));
    setState(() {});
    final duration = await player.stream.duration.first;
    player.stream.position.listen((position) {
      if (widget.addListener != null) {
        widget.addListener!(position, duration);
      }
    });
    player.stream.error.listen((error) => debugPrint(error));
  }

  hlsVideo() {}

  Future<List<CustomVideoModel>> fetchVideoHLSQualities(String hlsUrl) async {
    List<CustomVideoModel> videoQualities = [];

    try {
      final response = await http.get(Uri.parse(hlsUrl));
      if (response.statusCode == 200) {
        final parser = HlsPlaylistParser.create();
        final playlist =
            await parser.parseString(Uri.parse(hlsUrl), response.body);

        if (playlist is HlsMasterPlaylist) {
          for (var variant in playlist.variants) {
            var qualityLabel = '${variant.format.height}p';
            var videoUrl = variant.url.toString();
            var audioUrl =
                ''; // Placeholder, as HLS may not separate audio in the same way

            var videoModel = CustomVideoModel(
              qualityLabel: qualityLabel,
              videoUrl: videoUrl,
              audioUrl: audioUrl,
            );

            videoQualities.add(videoModel);
          }
        }
      } else {
        print('Failed to load HLS playlist');
      }
    } catch (e) {
      print('Error fetching video qualities: $e');
    }

    // حذف أي جودة متكررة بناءً على label
    Set<String> seenQualities = Set();
    videoQualities.removeWhere((element) {
      if (seenQualities.contains(element.qualityLabel)) {
        return true; // احذف العنصر إذا كانت الجودة قد تمت رؤيتها من قبل
      } else {
        seenQualities.add(element.qualityLabel);
        return false; // احتفظ بالعنصر إذا كانت الجودة فريدة
      }
    });

    for (var video in videoQualities) {
      print('Quality: ${video.qualityLabel}');
    }
    return videoQualities;
  }

  Future<List<CustomVideoModel>> fetchVideoYoutubeQualities(
      String videoId) async {
    var yt = youtube_explode.YoutubeExplode();
    List<CustomVideoModel> videoQualities = [];

    try {
      youtube_explode.StreamManifest manifest =
          await yt.videos.streamsClient.getManifest(videoId);
      // معالجة كل جودة فيديو متاحة
      for (var video in manifest.videoOnly) {
        var qualityLabel = video.qualityLabel;
        var videoUrl = video.url.toString();
        var audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();

        var videoModel = CustomVideoModel(
          qualityLabel: qualityLabel,
          videoUrl: videoUrl,
          audioUrl: audioUrl,
        );

        videoQualities.add(videoModel);
      }
    } catch (e) {
      print('Error fetching video qualities: $e');
    } finally {
      yt.close();
    }
    //delete any quality that has the same videoUrl
    Set<String> seenQualities = Set();

    videoQualities.removeWhere((element) {
      if (seenQualities.contains(element.qualityLabel)) {
        return true; // احذف العنصر إذا كانت الجودة قد تمت رؤيتها من قبل
      } else {
        seenQualities.add(element.qualityLabel);
        return false; // احتفظ بالعنصر إذا كانت الجودة فريدة
      }
    });

    return videoQualities;
  }

  materialDesktopVideoControls() {
    return MaterialDesktopVideoControlsThemeData(
      seekBarThumbColor: Colors.red,
      seekBarPositionColor: Colors.red,
      toggleFullscreenOnDoublePress: false,
      bottomButtonBar: [
        const MaterialDesktopPlayOrPauseButton(),
        const MaterialDesktopVolumeButton(),
        const MaterialDesktopPositionIndicator(),
        const Spacer(),
        MaterialCustomButton(
          onPressed: () {
            changeQuality();
          },
          icon: Icon(Icons.hd_outlined),
        ),
        MaterialCustomButton(
          onPressed: () {
            changeSpeed();
          },
          icon: const Icon(Icons.speed),
        ),
        const MaterialDesktopFullscreenButton(),
      ],
    );
  }

  // for portrait and landscape
  materialVideoControls() {
    return MaterialVideoControlsThemeData(
      speedUpOnLongPress: true,
      speedUpFactor: 4.0,
      seekOnDoubleTap: true,
      visibleOnMount: true,
      topButtonBar: [
        const MaterialDesktopVolumeButton(),
        const Spacer(),
        //quality button
        MaterialCustomButton(
          onPressed: () {
            changeQuality();
          },
          icon: Icon(Icons.hd_outlined),
        ),
      ],
      seekBarMargin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.125),
      bottomButtonBar: [
        const MaterialPlayOrPauseButton(),
        const MaterialDesktopPositionIndicator(),
        const Spacer(),
        MaterialCustomButton(
          onPressed: () {
            changeSpeed();
          },
          icon: const Icon(Icons.speed),
        ),
        const MaterialDesktopFullscreenButton(),
      ],
    );
  }

  materialFullScreenVideoControls() {
    return MaterialVideoControlsThemeData(
      speedUpOnLongPress: true,
      speedUpFactor: 4.0,
      seekOnDoubleTap: true,
      visibleOnMount: true,
      topButtonBar: [
        const MaterialDesktopVolumeButton(),
        buildStudentIdentity(),
        //quality button
        MaterialCustomButton(
          onPressed: () {
            changeQuality();
          },
          icon: Icon(Icons.hd_outlined),
        ),
      ],
      seekBarMargin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.128),
      bottomButtonBar: [
        const MaterialPlayOrPauseButton(),
        const MaterialDesktopPositionIndicator(),
        buildStudentIdentity(),
        MaterialCustomButton(
          onPressed: () {
            changeSpeed();
          },
          icon: const Icon(Icons.speed),
        ),
        const MaterialDesktopFullscreenButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: widget.isDesktop
          ? MaterialDesktopVideoControlsTheme(
              normal: materialDesktopVideoControls(),
              fullscreen: materialDesktopVideoControls(),
              child: Scaffold(
                body: Video(
                  controller: controller,
                  controls: MaterialDesktopVideoControls,
                ),
              ),
            )
          : MaterialVideoControlsTheme(
              normal: materialVideoControls(),
              fullscreen: materialFullScreenVideoControls(),
              child: Scaffold(
                body: Video(
                  controller: controller,
                  controls: widget.isDesktop
                      ? MaterialDesktopVideoControls
                      : MaterialVideoControls,
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Widget buildStudentIdentity() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Text(
              widget.name,
              //  widget.text,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 18,
                  backgroundColor: Colors.white.withOpacity(0.2)),
            ),
          ),
          SizedBox(
            child: Text(
              widget.phone,
              //  widget.text,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 18,
                  backgroundColor: Colors.white.withOpacity(0.2)),
            ),
          ),
        ],
      ),
    );
  }

  //bottom sheet
  changeQuality() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: videoQualities.map<Widget>((k) {
                  final video = k;
                  if (video != null) {
                    return ListTile(
                      title: Text(k.qualityLabel),
                      selected: video.qualityLabel == this.video.qualityLabel,
                      selectedTileColor: Colors.grey,
                      selectedColor: Colors.white,
                      onTap: () async {
                        Navigator.pop(context);
                        final Duration currentPosition =
                            await player.stream.position.first;

                        debugPrint('audioUrl: ${video.audioUrl}');

                        await controller.player.open(
                          Media(
                            video.videoUrl,
                          ),
                          play: true,
                        );
                        await Future.delayed(Duration(milliseconds: 500));

                        //audio
                        await controller.player.setAudioTrack(AudioTrack.uri(
                          video.audioUrl,
                          title: "default",
                          language: "default",
                        ));
                        await controller.player.seek(currentPosition);

                        this.video = video;
                      },
                    );
                  } else {
                    return Container(); // أو أضف رسالة خطأ هنا إذا لزم الأمر
                  }
                }).toList(),
              ),
            ),
          ),
        );
      },
    );

    // setState(() {});
    // await player.seek(currentPosition);
  }

  void changeSpeed() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: speedRates.keys.map<Widget>((k) {
                  final v = speedRates[k];
                  if (v != null) {
                    return ListTile(
                      title: Text(k),
                      onTap: () {
                        if (controller.player != null) {
                          controller.player.setRate(v);
                        }
                        Navigator.pop(context);
                      },
                    );
                  } else {
                    return Container(); // أو أضف رسالة خطأ هنا إذا لزم الأمر
                  }
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomVideoModel {
  final String qualityLabel;
  final String videoUrl;
  final String audioUrl;

  CustomVideoModel({
    required this.qualityLabel,
    required this.videoUrl,
    required this.audioUrl,
  });
}
