library rounded_loading_button;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_colors.dart';
import 'package:icourseapp/theme/app_themes.dart';
import 'package:rxdart/rxdart.dart';
import '../loaders/loader.dart';

enum LoadingState { idle, loading, success, error }

class RoundedLoadingButton extends StatefulWidget {
  final RoundedLoadingButtonController? controller;

  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The button's label
  final String? title;

  /// The button's icon-path
  final String? iconPath;

  /// The text - color
  final Color? textColor;

  /// The primary color of the button
  final Color? color;

  /// The vertical extent of the button.
  final double height;

  /// The horiztonal extent of the button.
  final double width;
  final double fontSize;

  /// The size of the CircularProgressIndicator
  final double loaderSize;

  /// The color of the static icons
  final Color? progressColor;

  /// The stroke width of the CircularProgressIndicator
  final double loaderStrokeWidth;

  /// Whether to trigger the animation on the tap event
  final bool animateOnTap;

  /// The color of the static icons
  final Color valueColor;

  /// The curve of the shrink animation
  final Curve curve;

  /// The radius of the button border
  final double borderRadius;

  /// The duration of the button animation
  final Duration duration;

  /// The elevation of the raised button
  final double elevation;

  /// The color of the button when it is in the error state
  final Color errorColor;

  final String? fontFamily;

  /// The color of the button when it is in the success state
  final Color? successColor;

  /// The color of the button when it is disabled
  final Color? disabledColor;

  Duration get _borderDuration {
    return Duration(milliseconds: (duration.inMilliseconds / 2).round());
  }

  const RoundedLoadingButton(
      {Key? key,
      this.controller,
      this.onPressed,
      this.color,
      this.iconPath,
      this.textColor = kWhite,
      this.title,
      this.progressColor,
      this.fontFamily,
      this.fontSize = 18,
      this.height = 40,
      this.width = 300,
      this.loaderSize = 40.0,
      this.loaderStrokeWidth = 2.0,
      this.animateOnTap = true,
      this.valueColor = Colors.white,
      this.borderRadius = 25,
      this.elevation = 2,
      this.duration = const Duration(milliseconds: 500),
      this.curve = Curves.easeInOutCirc,
      this.errorColor = kRed,
      this.successColor,
      this.disabledColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RoundedLoadingButtonState();
}

class RoundedLoadingButtonState extends State<RoundedLoadingButton>
    with TickerProviderStateMixin {
  AnimationController? _buttonController;
  AnimationController? _borderController;
  AnimationController? _checkButtonController;

  Animation? _squeezeAnimation;
  Animation? _bounceAnimation;
  Animation? _borderAnimation;

  final _state = BehaviorSubject<LoadingState>.seeded(LoadingState.idle);

  Widget textWidget() {
    return Text(widget.title!,
        style: Get.theme.textTheme.headlineMedium?.copyWith(
            color: widget.textColor ?? Get.theme.appBarTheme.iconTheme?.color,
            fontSize: widget.fontSize,
            fontFamily: widget.fontFamily ?? kMedium));
  }

  Widget iconWidget() {
    return widget.iconPath == null
        ? const SizedBox()
        : SvgPicture.asset(
            widget.iconPath!,
            width: 20,
            height: 20,
          );
  }

  Widget child() {
    return Center(
        child: Row(
      children: [
        Expanded(child: Container()),
        iconWidget(),
        if (widget.iconPath != null)
          const Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
        textWidget(),
        Expanded(child: Container()),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    var _check = Container(
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: widget.successColor ?? kWhite,
          borderRadius:
              BorderRadius.all(Radius.circular(_bounceAnimation?.value / 2)),
        ),
        width: _bounceAnimation?.value,
        height: _bounceAnimation?.value,
        child: _bounceAnimation?.value > 20
            ? Icon(
                Icons.check,
                color: widget.valueColor,
              )
            : null);

    var _cross = Container(
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: widget.errorColor,
          borderRadius:
              BorderRadius.all(Radius.circular(_bounceAnimation?.value / 2)),
        ),
        width: _bounceAnimation?.value,
        height: _bounceAnimation?.value,
        child: _bounceAnimation?.value > 20
            ? Icon(
                Icons.close,
                color: widget.valueColor,
              )
            : null);

    var _loader = SizedBox(
        height: widget.loaderSize,
        width: widget.loaderSize,
        child: const Loader(color: kWhite));

    var childStream = StreamBuilder(
      stream: _state,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: snapshot.data == LoadingState.loading ? _loader : child());
      },
    );

    var _btn = ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: _borderAnimation?.value),
        minWidth: _squeezeAnimation?.value,
        height: widget.height,
        child: ElevatedButton(
            onPressed: widget.onPressed == null ? null : _btnPressed,
            child: childStream,
            style: ElevatedButton.styleFrom(
              shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius))),
              padding: const EdgeInsets.all(6),
              backgroundColor: widget.color ?? Get.theme.primaryColor,
              foregroundColor: widget.color == kWhite || widget.color == Colors.white
                  ? Colors.black.withOpacity(0.4)
                  : Colors.white.withOpacity(0.4),
              elevation: widget.elevation,
            )));

    return SizedBox(
      width: widget.width,
        height: widget.height,
        child: Center(
            child: _state.value == LoadingState.error
                ? _cross
                : _state.value == LoadingState.success
                    ? _check
                    : _btn));
  }

  @override
  void initState() {
    super.initState();

    _buttonController =
        AnimationController(duration: widget.duration, vsync: this);

    _checkButtonController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _borderController =
        AnimationController(duration: widget._borderDuration, vsync: this);

    _bounceAnimation = Tween<double>(begin: 0, end: widget.height).animate(
        CurvedAnimation(
            parent: _checkButtonController!, curve: Curves.elasticOut));
    _bounceAnimation?.addListener(() {
      setState(() {});
    });

    _squeezeAnimation = Tween<double>(begin: widget.width, end: widget.height)
        .animate(
            CurvedAnimation(parent: _buttonController!, curve: widget.curve));

    _squeezeAnimation?.addListener(() {
      setState(() {});
    });

    _squeezeAnimation?.addStatusListener((state) {
      if (state == AnimationStatus.completed && widget.animateOnTap) {
        // widget.onPressed();
      }
    });

    _borderAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(widget.borderRadius),
            end: BorderRadius.circular(widget.height))
        .animate(_borderController!);

    _borderAnimation?.addListener(() {
      setState(() {});
    });

    widget.controller?._addListeners(_start, _stop, _success, _error, _reset);
  }

  @override
  void dispose() {
    _buttonController?.dispose();
    _checkButtonController?.dispose();
    _borderController?.dispose();
    _state.close();
    super.dispose();
  }

  _btnPressed() async {
    if (widget.animateOnTap) {
      widget.onPressed!();
    } else {}
  }

  _start() {
    _state.sink.add(LoadingState.loading);
    _borderController?.forward();
    _buttonController?.forward();
  }

  _stop() {
    _state.sink.add(LoadingState.idle);
    _buttonController?.reverse();
    _borderController?.reverse();
  }

  _success() {
    _state.sink.add(LoadingState.success);
    _checkButtonController?.forward();
  }

  _error() {
    _state.sink.add(LoadingState.error);
    _checkButtonController?.forward();
  }

  _reset() {
    _state.sink.add(LoadingState.idle);
    _buttonController?.reverse();
    _borderController?.reverse();
    _checkButtonController?.reset();
  }
}

class RoundedLoadingButtonController {
  VoidCallback? _startListener;
  VoidCallback? _stopListener;
  VoidCallback? _successListener;
  VoidCallback? _errorListener;
  VoidCallback? _resetListener;

  _addListeners(
      VoidCallback startListener,
      VoidCallback stopListener,
      VoidCallback successListener,
      VoidCallback errorListener,
      VoidCallback resetListener) {
    _startListener = startListener;
    _stopListener = stopListener;
    _successListener = successListener;
    _errorListener = errorListener;
    _resetListener = resetListener;
  }

  start() {
    _startListener!();
  }

  stop() {
    _stopListener!();
  }

  success() {
    _successListener!();
  }

  error() {
    _errorListener!();
  }

  reset() {
    _resetListener!();
  }
}
