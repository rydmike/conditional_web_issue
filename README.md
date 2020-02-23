# conditional_web_master_issue
FLUTTER Conditional dart.io import issue on Flutter master

-----------------------------------------------------------------------------------------------

NOTE:

This issue with similar text as below is reported as an issue here:
https://github.com/flutter/flutter/issues/51290

Noticed after creating the issue that there is a very similar or even same issue already posted here:
https://github.com/flutter/flutter/issues/50801


The added value in this report might be that for those that only use dart.io for Platform checks to set debugDefaultTargetPlatformOverride to Fuchsia to be able to build Linux and Windows apps on master, then this report contains a simple work-around example to still allow them to use master and build web, linux and windows apps on master.

-----------------------------------------------------------------------------------------------

Noticed on Feb 16, 2020 on Flutter version 1.15.4-pre.82 channel master, that when doing a conditional import to avoid dart.io on WEB, it nonetheless does the dart.io importing branch. The issue is still in effect today Feb 23, 2020 on version Flutter 1.15.4-pre.139 channel master.

This repo demonstrates the issue, the repo is just the standard template counter app that conditionally check if dart.io is supported, if it is supported it exports a file that imports and uses dart.io and if it is not supported, then another file is imported that contains the same function(s), but that does not import or use dart.io.

In this example case the used functionality from dart.io is just the Platform.isLinux and Platform.isWindows calls needed to check if we are on either of those platforms so we can set the debugDefaultTargetPlatformOverride to Fuchsia, so we can then build debug versions of Windows and Linux desktop apps on master channel. However, if this same app is built on master channel for Web target, then web build will now freeze in the file that imports dart.io when the Platform.isWindows or Platform.isLinux calls are made. This is demonstrated on master channel using this repo with Flutter version:

conditional_web_issue> flutter --version
Flutter 1.15.4-pre.139 • channel master • https://github.com/flutter/flutter.git
Framework • revision 4df8fdb7df (11 hours ago) • 2020-02-22 18:24:03 -0800
Engine • revision f2f8c342be
Tools • Dart 2.8.0 (build 2.8.0-dev.9.0 0f141be8bd)

If we change to the dev channel, then the conditional import of dart.io will work OK and the web build will work, as dart.io calls are correctly avoided by never even being imported. The issue with using the dev channel is of course that Windows and Linux builds cannot be tested on the dev channel, master is required for that. The same code runs fine when building for Web on the dev channel.

conditional_web_issue> flutter --version
Flutter 1.15.3 • channel dev • https://github.com/flutter/flutter.git
Framework • revision 67826bdce5 (13 days ago) • 2020-02-10 14:59:32 -0800
Engine • revision 6158f03ef5
Tools • Dart 2.8.0 (build 2.8.0-dev.8.0 514a8d4c84)

I did notice that if I in the file ‘do_non_web_stuff.dart’ in the example repo wrap the block

if (Platform.isLinux || Platform.isWindows) {  }

with an if state like this:

if (!kIsWeb) {
  if (Platform.isLinux || Platform.isWindows) {  }
}

That a Web app will in this particular example actually be built and run on master even though the Web app is actually still an import branch that imports dart.io. Thus for this particular use case of dart.io on Web platform, this is an intermediate workaround.
As there is no info on what functions in dart.io will cause Web platform builds to hang or perhaps all of them the do, the solution is a bit of “hack” compared to the previously recommended and in very commonly used solution of using a conditional import to avoid importing dart.io on Web platform entirely. Quite many experimental apps that use both web and desktop (Windows/Linux) and have to use master channel now fail due to this issue. The workaround presented above might provide a quick intermediate fix in some cases for others that may be affected by this issue.

I suspected last week when I noticed this issue that there might be work on-going to reconcile dart.io so that it will work and can be imported on Web platform too and that it now gets imported on Web builds on master channel is part of such work. I heard yesterday (Feb 22, 2020) on Twitter via Eric Seidel that there is indeed some work on this going on and that Kevin More is driving it (https://twitter.com/_eseidel/status/1231383332467855363).

If there is a timeline for when such re-consolidation will be functional on master, that would be useful information too.
