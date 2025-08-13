import 'package:email_contact_picker/email_contact_picker.dart';
import 'package:email_contact_picker/email_contact_picker_method_channel.dart';
import 'package:email_contact_picker/email_contact_picker_platform_interface.dart';
import 'package:email_contact_picker/model/PickedContact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEmailContactPickerPlatform
    with MockPlatformInterfaceMixin
    implements EmailContactPickerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<PickedContact?> pickEmail() {
    throw UnimplementedError();
  }
}

void main() {
  final EmailContactPickerPlatform initialPlatform =
      EmailContactPickerPlatform.instance;

  test('$MethodChannelEmailContactPicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEmailContactPicker>());
  });

  test('getPlatformVersion', () async {
    EmailContactPicker emailContactPickerPlugin = EmailContactPicker();
    MockEmailContactPickerPlatform fakePlatform =
        MockEmailContactPickerPlatform();
    EmailContactPickerPlatform.instance = fakePlatform;

    expect(await emailContactPickerPlugin.getPlatformVersion(), '42');
  });
}
