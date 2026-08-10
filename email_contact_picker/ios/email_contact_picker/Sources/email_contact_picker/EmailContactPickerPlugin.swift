import Flutter
import UIKit
import ContactsUI

public class EmailContactPickerPlugin: NSObject, FlutterPlugin, CNContactPickerDelegate {
    var flutterResult: FlutterResult?
    var viewController: UIViewController?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "email_contact_picker", binaryMessenger: registrar.messenger())
        let instance = EmailContactPickerPlugin()
        instance.viewController = UIApplication.shared.delegate?.window??.rootViewController
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "pickEmail" {
            flutterResult = result
            showEmailPicker()
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func showEmailPicker() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        picker.displayedPropertyKeys = [CNContactEmailAddressesKey]
        viewController?.present(picker, animated: true, completion: nil)
    }

    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        if contactProperty.key == CNContactEmailAddressesKey,
           let emailValue = contactProperty.value as? String {
            let contactName = CNContactFormatter.string(from: contactProperty.contact, style: .fullName) ?? ""
            flutterResult?(["name": contactName, "email": emailValue])
        } else {
            flutterResult?(nil)
        }
    }

    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        flutterResult?(nil)
    }
}
