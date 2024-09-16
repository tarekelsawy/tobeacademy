import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../utils/paths.dart';
import 'country_list_pick.dart';

class CountryCodePicker extends StatelessWidget {
  /// Constructor *************************************
  final ValueChanged<CountryCode>? onChanged;
  final bool showFlag;
  final String initialCC;
  const CountryCodePicker(
      {Key? key,
      required this.onChanged,
      this.initialCC = 'EG',
      this.showFlag = true})
      : super(key: key);

  /// build ****************************************************
  @override
  Widget build(BuildContext context) {
    return CountryListPick(
      appBar: AppBar(
        backgroundColor: kPrimary,
        iconTheme: Get.theme.iconTheme.copyWith(color: kWhite),
        title: Text('select_cc'.tr,
            style: Get.textTheme.displayMedium
                ?.copyWith(color: Colors.white, fontSize: 14)),
      ),
      countryBuilder: (_, CountryCode e) => getListCountry(e),
      pickerBuilder: (context, CountryCode countryCode) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              assetsPath + countryCode.flagUri!,
              width: 40,
              fit: BoxFit.cover,
              height: 26,
            ),
          ),
        );
      },
      theme: CountryTheme(
        alphabetSelectedTextColor: kWhite,
        alphabetTextColor: kBlack,
        alphabetSelectedBackgroundColor: kPrimary,
        lastPickText: 'last_pick'.tr,
        searchHintText: 'search_countries_hint'.tr,
        searchText: 'search'.tr,
      ),
      // Set default value
      // or
      initialSelection: 'EG',
      onChanged: onChanged,
      useUiOverlay: false,
    );
  }

  Widget getListCountry(CountryCode e) {
    return Container(
      height: Get.height * 0.06,
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          leading: Image.asset(
            assetsPath + e.flagUri!,
            width: Get.width * 0.1,
          ),
          title: Text(e.name!, style: Get.textTheme.bodyMedium),
          onTap: () {
            _sendDataBack(Get.context!, e);
          },
        ),
      ),
    );
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }
}
