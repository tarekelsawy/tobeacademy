import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_colors.dart';
import '../../models/title_model.dart';
import 'dropdown_controller.dart';

// ignore: must_be_immutable
class DropDown<M extends TitleModel> extends StatelessWidget {
  ///Attributes *******
  final List<M> _list;
  final ValueChanged<M?> onChange;
  final ValueChanged<int>? onIndexChange;
  final Function? onTap;
  final FocusNode? focusNode;
  final M? initialValue;
  final Color? iconColor;
  final double verticalPadding;
  final double elevation;
  final double containerWidth;
  final Color? textColor;
  final double borderRadius;
  final Color? borderColor;
  final String? hint;
  final Color backgroundColor;
  final double? fontSize;
  final Color containerColor;
  final bool allowRead;
  final bool showRequired;
  final String? tag;
  bool allowFirst;
  final Color hintColor;
  final bool disableRtl;
  final bool canReset;
  final FormFieldSetter<M>? onSave;
  final FormFieldValidator<M>? validator;

  final GlobalKey<FormFieldState>? formKey;

  DropDown(this._list,
      {required this.onChange,
      this.initialValue,
      this.containerWidth = double.infinity,
      this.formKey,
      this.onSave,
      this.validator,
      this.verticalPadding = 5,
      this.elevation = 0,
      this.borderRadius = 25,
      this.onIndexChange,
      this.hint,
      this.tag,
      this.disableRtl = false,
      this.hintColor = kGreyHint,
      this.borderColor,
      this.allowRead = true,
      this.fontSize = 14,
      this.canReset = false,
      this.backgroundColor = kWhite,
      this.containerColor = kWhite,
      this.textColor,
      this.iconColor = kBlack,
      this.focusNode,
      this.onTap,
      this.allowFirst = true,
      this.showRequired = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))
    // border: Border.all(color: borderColor ?? kGreyHint),
    // borderRadius: BorderRadius.circular(borderRadius)
    return GetBuilder<DropDownController>(
        init: DropDownController(),
        tag: tag ?? 'dropDown',
        builder: (_) {
          if (initialValue != null && allowFirst) {
            _.setSelectedValue(initialValue!);
            onChange.call(initialValue);
            allowFirst = false;
          }else if(initialValue !=null){
            _.setSelectedValue(initialValue!);
          } else {
            _.selectedValue.value = null;
          }
          return Obx(() => DropdownButtonFormField<M>(
                key: formKey,
                decoration: InputDecoration(
                  errorStyle:
                  Get.textTheme.displayMedium!.copyWith(color: kRed, fontSize: 12),
                  contentPadding: EdgeInsets.only(
                      left: 14.0,
                      bottom: verticalPadding,
                      top: verticalPadding,
                      right: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor ?? kGreyHint),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor ?? kGreyHint),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kRed),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kRed),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                value: _.selectedValue.value as M?,
                onSaved: onSave,
                validator: validator,
                isExpanded: true,
                iconEnabledColor: iconColor,
                iconDisabledColor: kGreyHint,
                hint: Text(
                    hint != null
                        ? hint!
                        : _list.isNotEmpty
                            ? _list.first.title
                            : '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayMedium!
                        .copyWith(fontSize: fontSize, color: hintColor)),
                isDense: true,
                disabledHint: Text(
                  hint != null ? hint! : initialValue?.title ?? "",
                  style: Get.textTheme.displayMedium!
                      .copyWith(fontSize: fontSize, color: hintColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                dropdownColor: backgroundColor,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: !allowRead ? kGreyHint : iconColor,
                    ),
                    if (showRequired)
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: kPrimary,
                      ),
                  ],
                ),
                iconSize: 25,
                // underline: const SizedBox(),
                items: _list.map((M value) {
                  return DropdownMenuItem<M>(
                      value: value,
                      child: disableRtl
                          ? Directionality(
                              textDirection: TextDirection.ltr,
                              child: _menuText(value))
                          : _menuText(value));
                }).toList(),
                onChanged: !allowRead
                    ? null
                    : (value) {
                        onChange(value);
                        if (onIndexChange != null) {
                          onIndexChange!(_list.indexOf(value!));
                        }
                        _.setSelectedValue(canReset? null : value);
                      },

                focusNode: focusNode,
                onTap: () => onTap,
              ));
        });
  }

  Widget _menuText(M value) {
    return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          value.title,
          style: Get.textTheme.displayMedium!
              .copyWith(fontSize: fontSize),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
