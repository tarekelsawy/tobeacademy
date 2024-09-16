import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icourseapp/theme/app_themes.dart';
import '../../theme/app_colors.dart';
import 'country_selection_theme.dart';
import 'selection_list.dart';
import 'support/code_countries_en.dart';
import 'support/code_country.dart';
import 'support/code_countries.dart';
export 'support/code_country.dart';
export 'country_selection_theme.dart';

class CountryListPick extends StatefulWidget {
  const CountryListPick(
      {Key? key, this.onChanged,
        this.initialSelection,
        this.appBar,
        this.pickerBuilder,
        this.countryBuilder,
        this.theme,
        this.useUiOverlay = true,
        this.useSafeArea = false}) : super(key: key);

  final String? initialSelection;
  final ValueChanged<CountryCode>? onChanged;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, CountryCode countryCode)?
  pickerBuilder;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode countryCode)?
  countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;

  @override
  _CountryListPickState createState() {
    return _CountryListPickState();
  }


}

class _CountryListPickState extends State<CountryListPick> {
  CountryCode? selectedItem;
  List elements = [];

  @override
  void initState() {
    elements=_doOnCreate();
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
              (e) =>
          (e.code.toUpperCase() == widget.initialSelection?.toUpperCase()) ||
              (e.dialCode == widget.initialSelection),
          orElse: () => elements[0] as CountryCode);
    } else {
      selectedItem = elements[0];
    }
    widget.onChanged!(selectedItem!);
    super.initState();
  }

  List _doOnCreate(){
    List<Map> jsonList =
    widget.theme?.showEnglishName ?? true ? countriesEnglish : codes;

    List elements = jsonList
        .map((s) => CountryCode(
      name: s['name'],
      code: s['code'],
      dialCode: s['dial_code'],
      flagUri: 'flags/${s['code'].toLowerCase()}.png',
    ))
        .toList();
    return elements;
  }

  void _awaitFromSelectScreen(BuildContext context, PreferredSizeWidget appBar,
      CountryTheme theme) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectionList(
            elements,
            selectedItem!,
            appBar: widget.appBar ??
                AppBar(
                  backgroundColor: kPrimary,
                  title:Text('select_country'.tr, style: Get.textTheme.displayMedium?.copyWith(color: kBlack, fontSize: 14)),
                ),
            theme: theme,
            countryBuilder: widget.countryBuilder!,
            useUiOverlay: widget.useUiOverlay,
            useSafeArea: widget.useSafeArea,
          ),
        ));

    setState(() {
      selectedItem = result ?? selectedItem;
      widget.onChanged!(result ?? selectedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _awaitFromSelectScreen(context, widget.appBar!, widget.theme!);
      },
      child: widget.pickerBuilder != null
          ? widget.pickerBuilder!(context, selectedItem!)
          : Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.theme?.isShowFlag ?? true == true)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.asset(
                  selectedItem!.flagUri!,
                  package: 'country_list_pick',
                  width: 24,
                ),
              ),
            ),
          if (widget.theme?.isShowCode ?? true == true)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(selectedItem.toString(),
                    style: Get.textTheme.displayMedium!
                        .copyWith(fontFamily: kLight, fontSize: 14)),
              ),
            ),
          if (widget.theme?.isShowTitle ?? true == true)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(selectedItem!.toCountryStringOnly()),
              ),
            ),
          if (widget.theme?.isDownIcon ?? true == true)
            const Flexible(
              child: Icon(Icons.keyboard_arrow_down),
            )
        ],
      ),
    );
  }
}
