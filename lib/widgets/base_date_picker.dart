import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_colors.dart';
import '../utils/date_time_util.dart';

class BaseDatePicker extends StatefulWidget {
  final String hintTxt;
  final String? yearPickerTitle;
  final FormFieldSetter<String>? onSave;
  final FormFieldSetter<TextEditingController>? textEditingController;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final ValueChanged<String>? onChange;
  final Color containerColor;
  final Color borderColor;
  final ValueChanged<DateTime>? onDateChanged;
  final TextEditingController? textController;
  final double radius;
  final Color? textColor;
  final Color? iconColor;
  final Color? hintColor;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final FocusNode? focusNode;
  final bool disable;
  final DatePickerMode pickerMode;

  @override
  _BaseDatePicker createState() => _BaseDatePicker();

  const BaseDatePicker({
    Key? key,
    required this.hintTxt,
     this.yearPickerTitle,
    this.onSave,
    this.textEditingController,
    this.validator,
    this.onChange,
    this.textController,
    this.onDateChanged,
    this.firstDate,
    this.containerColor = kWhite,
    this.initialValue,
    this.hintColor,
    this.focusNode,
    this.radius = 25,
    this.borderColor = kGreyHint,
    this.textColor,
    this.iconColor,
    this.lastDate,
    this.disable = false,
    this.pickerMode = DatePickerMode.day,
  }) : super(key: key);
}

class _BaseDatePicker extends State<BaseDatePicker> {
  //Data
  TextEditingController? controller;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    controller = widget.textController ?? TextEditingController();
    selectedDate = widget.initialValue != null
        ? DateTimeUtil.strYYYYMMMDDToDatetime(widget.initialValue!)
        : widget.firstDate ?? widget.lastDate ?? DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialValue == null) return;
      controller!.text = DateTimeUtil.toddMMYYYYFormat(selectedDate!);
      controller!.addListener(() {
        widget.onChange?.call(controller!.text);
        widget.onDateChanged?.call(selectedDate!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      controller: controller,
      autofocus: false,
      readOnly: true,
      maxLines: 1,
      onTap: () => !widget.disable ? _selectDate(context) : null,
      style: Get.textTheme.bodyLarge!.copyWith(fontSize: 14, color: kBlack),
      cursorColor: kPrimary,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: widget.hintTxt,
          hintStyle: Get.textTheme.bodyLarge!
              .copyWith(fontSize: 14, color: widget.hintColor ?? kGreyHint),
          errorStyle:
              Get.textTheme.bodyLarge!.copyWith(color: kRed, fontSize: 14),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 5, top: 5, right: 14.0),
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
                color: widget.iconColor ?? kBlack,
              ).paddingSymmetric(horizontal: 8),
            ],
          )),
      onSaved: (input) => widget.onSave!.call(input),
      validator: (input) => widget.validator?.call(input),
      onChanged: (String value) {
        widget.textEditingController!.call(controller);
        widget.onChange!.call(value);
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    if (widget.pickerMode == DatePickerMode.year) {
      await showDialog(
        context: context,
        builder: (context) => Center(
          child: SizedBox(
            height: Get.height * 0.53,
            child: Card(
              child: Scrollbar(
                thickness: 2,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8,),
                      Center(child: Text(widget.yearPickerTitle?? '' , style: Get.textTheme.headlineLarge?.copyWith(color: kPrimary,fontSize: 16),)),
                      const SizedBox(height: 8,),
                      SizedBox(
                        height: Get.height * 0.5,
                        child: YearPicker(
                            firstDate: widget.firstDate ?? DateTime(1900),
                            lastDate: widget.lastDate ?? DateTime.now(),
                            selectedDate: selectedDate!,
                            onChanged: (picked) {
                              if ( picked != selectedDate) selectedDate = picked;
                              widget.onDateChanged?.call(picked);
                              controller!.text = DateTimeUtil.toYYYYFormat(picked);
                              Get.back();
                              // widget.onChange?.call(controller?.text ?? '');
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ).marginSymmetric(horizontal: 24),
      );
    } else {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate!,
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime.now(),
          builder: (BuildContext? context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: kPrimary,
                colorScheme: const ColorScheme.light(primary: kPrimary),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
          initialDatePickerMode: widget.pickerMode);

      if (picked != null && picked != selectedDate) selectedDate = picked;
      controller!.text = DateTimeUtil.toddMMYYYYFormat(picked!);
      widget.onChange?.call(controller?.text ?? '');
      widget.onDateChanged?.call(picked);
    }
  }
}
