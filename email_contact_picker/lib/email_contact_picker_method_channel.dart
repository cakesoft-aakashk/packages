import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'email_contact_picker_platform_interface.dart';
import 'model/PickedContact.dart';

/// An implementation of [EmailContactPickerPlatform] that uses method channels.
class MethodChannelEmailContactPicker extends EmailContactPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('email_contact_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<PickedContact?> pickEmail() async {
    try {
      final result =
          await methodChannel.invokeMethod<Map<dynamic, dynamic>>('pickEmail');
      if (result != null) {
        final name = result["name"];
        final email = result["email"];
        return PickedContact(name: name ?? "", email: email ?? "");
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to pick email: $e\n${e.stacktrace}");
    }
    return null;
  }
}
