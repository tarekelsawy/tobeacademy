import 'package:icourseapp/helper/flavor_config.dart';
import 'main.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.dev; //set flavor to prod
  initApp();
}
