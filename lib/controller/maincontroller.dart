import 'package:asto/model/model.dart';
import 'package:asto/services/realtime_base.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class MainController extends GetxController {
  Rx<DataModel> data = DataModel().obs;
  Rx<String> state = "Room1".obs;
  dynamic riveArtboardLight = RuntimeArtboard().obs;
  dynamic riveArtboardFan = RuntimeArtboard().obs;
  RiveAnimationController controller = OneShotAnimation("light-controller");
  RealtimeServices services = RealtimeServices();
  @override
  void onInit() async {
    try {
      data.value = await services.getData();
    } catch (e) {
      Room1 room = Room1(fan: "Low", light: "Low");
      DataModel data = DataModel(room1: room);
      services.setData(data);
    }
    super.onInit();
  }

  setArtBoardLight(Artboard board) {
    riveArtboardLight.value = board;
  }

  setArtBoardFan(Artboard board) {
    riveArtboardFan.value = board;
  }

  void setData(String type) async {
    data.value = await services.getData();

    try {
      switch (type) {
        case "Fan":
          data.value.room1!.fan =
              data.value.room1!.fan == "LOW" ? "HIGH" : "LOW";
          services.setData(data.value);
          break;
        case "Light":
          data.value.room1!.light =
              data.value.room1!.light == "LOW" ? "HIGH" : "LOW";
          services.setData(data.value);
          break;
      }
    } catch (e) {
      Room1 room = Room1(fan: "Low", light: "Low");
      DataModel data = DataModel(room1: room);
      services.setData(data);
    }
  }

  changeState(String value) {
    state.value = value;
  }
}
