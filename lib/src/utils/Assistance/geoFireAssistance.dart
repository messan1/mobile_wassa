import 'package:ucolis/src/Model/NearByAvailabaleDriver.dart';

class GeoFireAssistance {
  static List<NearByAvailabaleDriver> nearByAvailabaleDriversList = [];

  static void removeDriver(String key) {
    int index =
        nearByAvailabaleDriversList.indexWhere((element) => element.key == key);
    nearByAvailabaleDriversList.removeAt(index);
  }

  static void updateDriverposition(NearByAvailabaleDriver driver){
   int index =
        nearByAvailabaleDriversList.indexWhere((element) => element.key == driver.key);
        nearByAvailabaleDriversList[index].longitude=driver.longitude;
        nearByAvailabaleDriversList[index].latitude=driver.latitude;
  }
}
