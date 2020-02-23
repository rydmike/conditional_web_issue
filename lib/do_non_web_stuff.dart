import 'dart:io';
import 'package:flutter/foundation.dart';

// If we are on WEB then this file that imports dart.io cannot be imported
// so we should never import this file on WEB
void doPlatformStuff() {
  if (kIsWeb) {
    debugPrint('I am running on WEB!');
    debugPrint("This file 'do_non_web_stuff.dart' should NOT be imported on ");
    debugPrint("WEB because it imports dart.io");
    debugPrint('App will freeze because it imported unsupported dart.io');
    debugPrint(' ');
  } else {
    debugPrint('I am not running on WEB and importing dart.io is fine');
    debugPrint('as is doing other things not supported on WEB yet.');
    debugPrint(' ');
  }

  /// To ensure we actually get dart.io imported let's also do something with it
  /// like using [Platform] to then set the [debugDefaultTargetPlatformOverride]
  //

  if (Platform.isLinux || Platform.isWindows) {
    /// No need to handle macOS, as it has now been added to [TargetPlatform].
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    //
    if (Platform.isLinux) debugPrint('I am running on Linux!');
    if (Platform.isWindows) debugPrint('I am running on Windows!');
    debugPrint('I only work on Flutter master, to use me you can set');
    debugPrint('debugDefaultTargetPlatformOverride to Fuchsia.');
    debugPrint(' ');
    debugPrint('To check Platform you need dart.io, but dart.io is');
    debugPrint('not supported on WEB and with the dart.io now being');
    debugPrint('imported by web and crashing when doing so on master,');
    debugPrint('you can no longer develop an app that support, web');
    debugPrint('and windows and linux, as the latter two are only');
    debugPrint('available on the Flutter master channel!');
  }
}
