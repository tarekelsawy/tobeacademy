import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_colors.dart';
import '../utils/date_time_util.dart';

class BaseTimePicker extends StatefulWidget {
  final String hintTxt;
  final FormFieldSetter<String>? onSave;
  final FormFieldSetter<TextEditingController>? textEditingController;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final ValueChanged<String>? onChange;
  final Color containerColor;
  final Color borderColor;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final TextEditingController? textController;
  final double radius;
  final Color? textColor;
  final Color? iconColor;
  final Color? hintColor;
  final FocusNode? focusNode;
  final bool disable;
  @override
  _BaseTimePicker createState() => _BaseTimePicker();

  const BaseTimePicker(
      {Key? key,
        required this.hintTxt,
        this.onSave,
        this.textEditingController,
        this.validator,
        this.onChange,
        this.textController,
        this.onTimeChanged,
        this.containerColor = kWhite,
        this.initialValue,
        this.hintColor,
        this.focusNode,
        this.radius = 25,
        this.borderColor = kGreyHint,
        this.textColor,
        this.iconColor,
        this.disable = false,
      })
      : super(key: key);
}

class _BaseTimePicker extends State<BaseTimePicker> {
  //Data
  TextEditingController? controller;
  // TimeOfDay? selectedDate;

  @override
  void initState() {
    super.initState();
    controller = widget.textController ?? TextEditingController();
    // selectedDate = widget.initialValue != null
    //     ? DateTimeUtil.strYYYYMMMDDToDatetime(widget.initialValue!) : widget.lastDate ?? DateTime.now();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   if(widget.initialValue==null) return;
    //   controller!.text = DateTimeUtil.toddMMYYYYFormat(selectedDate!);
    //   controller!.addListener(() {
    //     widget.onChange?.call(controller!.text);
    //     widget.onDateChanged?.call(selectedDate!);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      focusNode: widget.focusNode,
      controller: controller,
      autofocus: false,
      readOnly: true,
      maxLines: 1,
      onTap: () => !widget.disable ? _selectTime(context) : null,
      style: Get.textTheme.bodyLarge!.copyWith(fontSize: 14, color: kBlack),
      cursorColor: kPrimary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: widget.hintTxt,
          hintStyle: Get.textTheme.bodyLarge!.copyWith(
              fontSize: 14, color: widget.hintColor ?? kGreyHint),
          errorStyle:
          Get.textTheme.bodyLarge!.copyWith(color: kRed, fontSize: 14),
          contentPadding: const EdgeInsets.only(
              left: 14.0,
              bottom: 5,
              top: 5,
              right: 14.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kRed),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kRed),
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.date_range,
                color:widget.iconColor ?? kBlack,
              ).paddingSymmetric(horizontal: 8),
            ],
          )),
      onSaved: (input) => widget.onSave?.call(input),
      validator: (input) => widget.validator?.call(input),
      onChanged: (String value) {
        widget.textEditingController!.call(controller);
        widget.onChange!.call(value);
      },
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    var now = TimeOfDay.now();
    TimeOfDay?  picked = await showTimePicker(context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute),);
    if(picked == null) return;
    controller!.text = DateTimeUtil.parseTime(picked);
    widget.onChange?.call(controller?.text?? '');
    widget.onTimeChanged?.call(picked);
  }
}
