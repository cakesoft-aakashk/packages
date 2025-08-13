import 'email_contact_picker_platform_interface.dart';
import 'model/PickedContact.dart';

class EmailContactPicker {
  Future<String?> getPlatformVersion() {
    return EmailContactPickerPlatform.instance.getPlatformVersion();
  }

  Future<PickedContact?> pickEmail() async {
    return EmailContactPickerPlatform.instance.pickEmail();
  }
}
