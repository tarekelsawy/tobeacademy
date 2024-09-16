part of 'package:icourseapp/widgets/pod_package/src/pod_player.dart';

class FullScreenView extends StatefulWidget {
  final String tag;
  final String? tagData;
  const FullScreenView({
    required this.tag,
    required this.tagData,
    super.key,
  });

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView>
    with TickerProviderStateMixin {
  late PodGetXVideoController _podCtr;
  @override
  void initState() {
    _controller = Get.find<PlayerController>( tag: widget.tagData);
    _podCtr = Get.find<PodGetXVideoController>(tag: widget.tag);
    _podCtr.fullScreenContext = context;
    _podCtr.keyboardFocusWeb?.removeListener(_podCtr.keyboadListner);

    super.initState();
  }

  @override
  void dispose() {
    _podCtr.keyboardFocusWeb?.requestFocus();
    _podCtr.keyboardFocusWeb?.addListener(_podCtr.keyboadListner);
    super.dispose();
  }

  late PlayerController _controller;
  @override
  Widget build(BuildContext context) {
    final loadingWidget = _podCtr.onLoading?.call(context) ??
        const CircularProgressIndicator(
          backgroundColor: Colors.black87,
          color: Colors.white,
          strokeWidth: 2,
        );

    return WillPopScope(
      onWillPop: () async {
        if (kIsWeb) {
          await _podCtr.disableFullScreen(
            context,
            widget.tag,
            enablePop: false,
          );
        }
        if (!kIsWeb) await _podCtr.disableFullScreen(context, widget.tag);
        return true;
      },
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: GetBuilder<PodGetXVideoController>(
          tag: widget.tag,
          builder: (podCtr) => Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: ColoredBox(
                color: Colors.black,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Center(
                        child: podCtr.videoCtr == null
                            ? loadingWidget
                            : podCtr.videoCtr!.value.isInitialized
                            ? _PodCoreVideoPlayer(
                          tag: widget.tag,
                          videoPlayerCtr: podCtr.videoCtr!,
                          videoAspectRatio:
                          podCtr.videoCtr?.value.aspectRatio ?? 16 / 9,
                        )
                            : loadingWidget,
                      ),
                      if(pref.client != null)
                        WaterMarkWidget(
                 
                    ),
                      if(pref.client != null)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: Text(
                                pref.client?.phone ?? '',
                                style: Get.textTheme.displayLarge!.copyWith(
                                    color: kBlack.withOpacity(0.3),
                                    fontSize: 18,
                                    backgroundColor: kWhite.withOpacity(0.2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*


* */