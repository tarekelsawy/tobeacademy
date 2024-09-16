import 'package:get/get.dart';

import '../../models/title_model.dart';

class DropDownController<M extends TitleModel> extends GetxController{

  ///Data **********************************************
  var selectedValue=Rx<M?>(null);

  /// Listeners ****************************************
  setSelectedValue (M? value){
    selectedValue.value=value;
    // update();
  }
}