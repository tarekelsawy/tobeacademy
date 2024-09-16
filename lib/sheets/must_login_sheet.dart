import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MustLoginSheet extends StatefulWidget {
  final String? title;
  final Function? onOk;
  final String? btnTitle;

  const MustLoginSheet({Key? key, this.title, this.onOk, this.btnTitle})
      : super(key: key);

  @override
  _LoginSheetState createState() => _LoginSheetState();
}

class _LoginSheetState extends State<MustLoginSheet> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            child: const SafeArea(
              child:  SizedBox()
              // MustLoginWidget(
              //   title: widget.title,
              //   btnTitle: widget.btnTitle,
              //   onOk: widget.onOk,
              // ),
            ))
      ],
    );
  }
}
