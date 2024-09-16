import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class PageAttributes {
  //Data
  final String? title;
  final bool showAppBar,
      isHome,
      resizeToAvoidBottomInset,
      transparentAppBar,
      showCloseIc, showNav;
  final bool showLine;
  final bool doLogout;
  final double appBarElevation;
  final Color backBtnColor;
  final Color appBarColor;
  final Color titleColor;
  final double? toolbarHeight;
  final Widget? suffix;

  PageAttributes({
    this.backBtnColor = kGreyD9,
    this.appBarColor = kGreyF9,
      this.showAppBar = true,
      this.showNav = true,
      this.showLine = true,
      this.isHome = false,
      this.doLogout = false,
      this.appBarElevation = 0,
      this.transparentAppBar = false,
      this.suffix,
    this.toolbarHeight,
      this.title,
    this.titleColor = kPrimary,
      this.showCloseIc = false,
      this.resizeToAvoidBottomInset = false});
}
