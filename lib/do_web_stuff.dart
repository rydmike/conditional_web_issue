import 'package:flutter/foundation.dart';

// If we are on WEB then this file that does not imports dart.io will be imported
// We will only import this file when dart.io is not supported
void doPlatformStuff() {
  if (kIsWeb) {
    debugPrint('I am running on WEB!');
    debugPrint(
        "The 'do_web_stuff.dart' file does not import or use dart.io.");
    debugPrint(
        'The web app will start just fine.');
  } else {
    debugPrint('I am on a platform that is not supported by dart.io');
    debugPrint('but it is something else than WEB, unknown what it is!');
  }
}
