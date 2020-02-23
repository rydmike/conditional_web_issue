// Export file 'do_web_stuff.dart', but if dart.io is supported then export 'do_non_web_stuff.dart'
export 'do_web_stuff.dart' if (dart.library.io) 'do_non_web_stuff.dart';
