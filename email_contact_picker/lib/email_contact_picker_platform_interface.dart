import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'email_contact_picker_method_channel.dart';
import 'model/PickedContact.dart';

abstract class EmailContactPickerPlatform extends PlatformInterface {
  /// Constructs a EmailContactPickerPlatform.
  EmailContactPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static EmailContactPickerPlatform _instance =
      MethodChannelEmailContactPicker();

  /// The default instance of [EmailContactPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelEmailContactPicker].
  static EmailContactPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EmailContactPickerPlatform] when
  /// they register themselves.
  static set instance(EmailContactPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<PickedContact?> pickEmail() async {
    throw UnimplementedError('pickEmail() has not been implemented.');
  }
}
