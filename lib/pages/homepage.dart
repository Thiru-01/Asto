import 'package:asto/controller/maincontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainController controller = Get.find(tag: "mainController");

  SMIInput<bool>? _startLight;
  SMIInput<bool>? _startFan;

  @override
  void initState() {
    rootBundle.load("assets/rive/light.riv").then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      StateMachineController? _controller1 =
          StateMachineController.fromArtboard(
        artboard,
        'MainMachine',
      );
      if (_controller1 != null) {
        artboard.addController(_controller1);
        _startLight = _controller1.findInput("state");
      }

      controller.setArtBoardLight(artboard);
    });

    rootBundle.load("assets/rive/fan.riv").then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      StateMachineController? _controller2 =
          StateMachineController.fromArtboard(artboard, 'Machine');
      if (_controller2 != null) {
        artboard.addController(_controller2);
        _startFan = _controller2.findInput("on");
      }

      controller.setArtBoardFan(artboard);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ASTO',
          style: TextStyle(color: Colors.red),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.redAccent, width: 1)),
                    child: Obx(() => DropdownButton<String>(
                        value: controller.state.value,
                        underline: const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        dropdownColor: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 0,
                        items: const [
                          DropdownMenuItem(
                            value: "Room1",
                            child: Text("Room1"),
                          ),
                          DropdownMenuItem(
                            value: "Room2",
                            child: Text("Room2"),
                          )
                        ],
                        onChanged: (value) {
                          controller.changeState(value!);
                        })),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.9,
                height: height * 0.5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: true,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.3,
                            width: width - height * 0.03,
                            child: Obx(() => GestureDetector(
                                onTap: () {
                                  controller.setData("Fan");
                                  _startFan!.value = !_startFan!.value;
                                },
                                child: Rive(
                                  artboard: controller.riveArtboardFan.value,
                                ))),
                          ),
                          Padding(
                              padding: EdgeInsets.all(height * 0.01),
                              child: Text(
                                "Fan",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          16,
                                ),
                              ))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.3,
                            width: width - height * 0.03,
                            child: Obx(() => GestureDetector(
                                onTap: () {
                                  controller.setData("Light");
                                  _startLight!.value = !_startLight!.value;
                                },
                                child: Rive(
                                  artboard: controller.riveArtboardLight.value,
                                  fit: BoxFit.fitHeight,
                                ))),
                          ),
                          Padding(
                              padding: EdgeInsets.all(height * 0.01),
                              child: Text(
                                "Light",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          16,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Text("Light"),
//                     Obx(() => TextButton(
//                           onPressed: () async {
//                             controller.setData("Light");
//                           },
//                           child: Obx(() => Text(
//                                 controller.data.value.room1?.light == "LOW"
//                                     ? "On"
//                                     : "Off",
//                                 style: const TextStyle(color: Colors.white),
//                               )),
//                           style: TextButton.styleFrom(
//                               backgroundColor:
//                                   controller.data.value.room1?.light == "LOW"
//                                       ? Colors.green
//                                       : Colors.red),
//                         ))
//                   ],
//                 ),

// Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Text("Fan"),
//                     Obx(() => TextButton(
//                           onPressed: () async {
//                             controller.setData("Fan");
//                           },
//                           child: Obx(() => Text(
//                                 controller.data.value.room1?.fan == "LOW"
//                                     ? "On"
//                                     : "Off",
//                                 style: const TextStyle(color: Colors.white),
//                               )),
//                           style: TextButton.styleFrom(
//                               backgroundColor:
//                                   controller.data.value.room1?.fan == "LOW"
//                                       ? Colors.green
//                                       : Colors.red),
//                         ))
//                   ],
//                 ),