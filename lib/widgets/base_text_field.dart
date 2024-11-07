import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class BaseTextField extends StatefulWidget {
  final bool integerVal;
  final bool decimal;
  final String hintTxt;
  final TextStyle? hintStyle;
  final FormFieldSetter<String>? onSave;
  final FormFieldValidator<String>? validator;
  final bool password;
  final Color filledColor;
  final Color? borderColor;
  final bool readOnly;
  final int? maxLength;
  final TextEditingController? controller;
  final ValueChanged<String>? onChange;
  final String? initialValue;
  final double radius;
  final bool searchMode;
  final TextInputType? textInputType;
  final int maxLines;
  final int? minLines;
  final bool expands;
  final bool obscureText;
  final double fontSize;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double verticalPadding;
  final Widget? suffixIcon;
  final String? suffixText;
  final FocusNode? focusNode;
  final Function? onTap;
  final Widget? leading;
  final ValueChanged<String>? onSubmit;
  final bool? enabled;

  const BaseTextField(
      {Key? key,
      this.integerVal = false,
      this.decimal = false,
      this.obscureText = false,
      this.onSubmit,
      required this.hintTxt,
      this.hintStyle,
      this.leading,
      this.onSave,
      this.suffixIcon,
      this.initialValue,
      this.minLines,
      this.maxLength,
      this.controller,
      this.radius = 25,
      this.filledColor = Colors.transparent,
      this.borderColor,
      this.password = false,
      this.readOnly = false,
      this.searchMode = false,
      this.maxLines = 1,
      this.expands = false,
      this.onChange,
      this.validator,
      this.fontSize = 18,
      this.contentPaddingLeft = 14,
      this.contentPaddingRight = 14,
      this.verticalPadding = 5,
      this.textInputType,
      this.suffixText,
      this.focusNode,
      this.onTap, this.enabled})
      : super(key: key);

  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  late bool _obscureText;
  var key = GlobalKey();
  String? currentTxt;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _obscureText = widget.obscureText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: widget.enabled,
        onTap: () => widget.onTap?.call(),
        focusNode: widget.focusNode,
        key: key,
        controller: widget.searchMode ? _searchController : widget.controller,
        autofocus: false,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        initialValue: widget.initialValue,
        maxLength: widget.maxLength,
        readOnly: widget.readOnly,
        onFieldSubmitted: widget.onSubmit,
        onChanged: widget.searchMode
            ? (txt) {
                widget.onChange?.call(txt);

                setState(() {
                  currentTxt = txt;
                });
              }
            : widget.onChange,
        inputFormatters: widget.decimal
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)$')),
              ]
            : widget.integerVal
                ? [
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ]
                : null,
        style: Get.textTheme.displayMedium!.copyWith(
            fontSize: widget.fontSize,
            color: Get.textTheme.displayMedium!.color),
        cursorColor: Get.textTheme.displayMedium!.color,
        keyboardType: (widget.textInputType != null)
            ? widget.textInputType
            : widget.decimal
                ? TextInputType.number
                : widget.integerVal
                    ? TextInputType.phone
                    : TextInputType.text,
        decoration: InputDecoration(
          suffixText: widget.suffixText,
          suffixStyle: const TextStyle(color: kPrimary, fontSize: 16),
          filled: true,
          fillColor: widget.filledColor,
          hintText: widget.hintTxt,
          hintStyle: widget.hintStyle ??
              Get.textTheme.displayMedium!.copyWith(
                  fontSize: widget.fontSize,
                  color: Get.textTheme.displayMedium!.color!.withOpacity(0.5)),
          errorStyle:
              Get.textTheme.displayMedium!.copyWith(color: kRed, fontSize: 12),
          contentPadding: EdgeInsets.only(
              left: widget.contentPaddingLeft,
              bottom: widget.verticalPadding,
              top: widget.verticalPadding,
              right: widget.contentPaddingRight),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          prefixIcon: widget.leading,
          suffixIcon: _suffixIcon(),
        ),
        obscureText: _obscureText,
        onSaved: widget.onSave,
        validator: widget.validator);
  }

  Widget? _suffixIcon() {
    if (widget.suffixIcon != null) return widget.suffixIcon;
    return widget.obscureText
        ? GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: kPrimary,
            ),
          )
        : widget.searchMode
            ? GestureDetector(
                onTap: () {
                  if (currentTxt != null && currentTxt!.isNotEmpty) {
                    _searchController.text = "";
                  }
                  setState(() {
                    currentTxt = "";
                  });
                  if (widget.onChange != null) {
                    widget.onChange?.call('');
                  }
                },
                child: Icon(
                  currentTxt == null || currentTxt!.isEmpty
                      ? Icons.search
                      : Icons.close,
                  size: 20,
                  color: kGrayDark,
                ),
              )
            : null;
  }
}
