import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:volume/volume.dart';

@pragma("vm:entry-point")
void overlayMain() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);


  runApp(const MaterialApp(
      home: Material (

          color: Colors.white,

          child:
            ElevatedButton(

                onPressed: FlutterOverlayWindow.closeOverlay,
                child: Text("Close")
            )
  )));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.phone.request();
  //await startKioskMode();

  final bool status = await FlutterOverlayWindow.isPermissionGranted();
  print ("asking permission");
  await FlutterOverlayWindow.requestPermission();

  runApp(const NotMyDodl());
}

class NotMyDodl extends StatelessWidget {
  const NotMyDodl({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotMyDodl',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const NotMyDodlApp(title: 'NotMyDodl'),
    );
  }
}

class NotMyDodlApp extends StatefulWidget {
  const NotMyDodlApp({super.key, required this.title});

  final String title;

  @override
  State<NotMyDodlApp> createState() => _NotMyDodlState();
}

class _NotMyDodlState extends State<NotMyDodlApp> {

  late Timer _timer;
  AudioManager audioManager = AudioManager.STREAM_VOICE_CALL;
  int maxVol=0, currentVol=0;

  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));

    /*_timer = Timer.periodic(const Duration(milliseconds:100), (timer) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
      SystemChrome.restoreSystemUIOverlays();
      print ("timer tick");
    });
*/

    super.initState();
    audioManager = AudioManager.STREAM_VOICE_CALL;
    initPlatformState();
    updateVolumes();

  }

  Future<void> initPlatformState() async {
    await Volume.controlVolume(AudioManager.STREAM_VOICE_CALL);
  }

  setVol(int i) async {
    await Volume.setVol(0);
  }

  updateVolumes() async {
    // get Max Volume
    maxVol = await Volume.getMaxVol;
    // get Current Volume
    currentVol = await Volume.getVol;
    setState(() {});
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: []);
    VolumeController().removeListener();
    super.dispose();
  }

  //volume
  double _volumeListenerValue = 0;
  double _getVolume = 0;
  double _setVolumeValue = 0;


  //debug
  int _counter = 0;
  String _debugInfo = '';

  //interactivty
  bool _isInkwellEnabled = true;

  String okEachDayButtonUrl = "";
  static const String okEachDayButtonNormalUrl = "assets/images/oked.png";
  static const String okEachDayButtonCheckedUrl = "assets/images/okedchecked.png";

  void _onOkEachDayButtonPressed() {
    setState(() {
      if (_isInkwellEnabled == true)
      {
        _debugInfo = "async API call [TBD]";
        _counter++;

        _isInkwellEnabled = false;
        okEachDayButtonUrl = okEachDayButtonCheckedUrl;
      }
      else {
        // do nada for now
      }
    });
  }

  void _muteVolume() {
    VolumeController().showSystemUI = false;
    VolumeController().muteVolume();

    Volume.controlVolume(AudioManager.STREAM_VOICE_CALL);
    setVol(0);
    updateVolumes();
    Volume.controlVolume(AudioManager.STREAM_SYSTEM);
    setVol(0);
    updateVolumes();
    Volume.controlVolume(AudioManager.STREAM_RING);
    setVol(0);
    updateVolumes();
    Volume.controlVolume(AudioManager.STREAM_MUSIC);
    setVol(0);
    updateVolumes();
    Volume.controlVolume(AudioManager.STREAM_ALARM);
    setVol(0);
    updateVolumes();
    Volume.controlVolume(AudioManager.STREAM_NOTIFICATION);
    setVol(0);
    updateVolumes();

  }

  void _callViaIntent() async {
    AndroidIntent intent = const AndroidIntent(

      action: 'android.intent.action.CALL',
      data: 'tel:01613581983',
      //data: 'tel:07538218716',
    );
    print("calling via intent");
    await intent.launch();
    //FlutterOverlayWindow.closeOverlay();

  }

  void _showOverlay() async {
    VolumeController().showSystemUI = false;
    await FlutterOverlayWindow.showOverlay(
      alignment: OverlayAlignment.center,
      height:3000,
      width:3000,
      enableDrag: true,
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    SystemChrome.restoreSystemUIOverlays();

  }

  void _callWithOverlay () async {
    VolumeController().showSystemUI = false;
    await FlutterOverlayWindow.showOverlay(
      alignment: OverlayAlignment.center,
      height:3000,
      width:3000,
      enableDrag: true,
    );

    _callViaIntent();
    //FlutterOverlayWindow.closeOverlay();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    SystemChrome.restoreSystemUIOverlays();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    if (_isInkwellEnabled == true)
    {
      okEachDayButtonUrl = okEachDayButtonNormalUrl;
    }
    else {
      okEachDayButtonUrl = okEachDayButtonCheckedUrl;
    }
    print (okEachDayButtonUrl);

    return Scaffold(
      /*appBar: AppBar(
        title: null,
      ),*/
      appBar: null,
      body:
      Center(
        child: GridView.count(
          primary: true,
          padding: const EdgeInsets.all(8),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget> [

            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),


            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),

            InkWell(
              splashColor: Colors.grey.withOpacity(0.0),
              onTap: _onOkEachDayButtonPressed, // Handle your callback.
              child: Ink(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(okEachDayButtonUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),
            Container(
              decoration: ShapeDecoration(
                  shape: Border.all (
                      color: Colors.transparent,
                      width: 0.1
                  )
              ),
              padding: const EdgeInsets.all(8),
              child:
              const Text(""),
            ),
          ],
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: null,
              //onPressed: _makeCall,
              onPressed: _callViaIntent,
              //onPressed: _callViaPhoneState,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.phone,
                size: 40,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: _muteVolume,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.volume_off,
                size: 40,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 100,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: _callWithOverlay,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.chat_bubble,
                size: 40,
              ),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),
    );
  }
}
