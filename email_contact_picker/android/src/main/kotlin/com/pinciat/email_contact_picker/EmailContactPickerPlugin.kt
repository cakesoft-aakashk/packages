package com.pinciat.email_contact_picker

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class EmailContactPickerPlugin: FlutterPlugin, MethodChannel.MethodCallHandler,
  ActivityAware, PluginRegistry.ActivityResultListener {

  private lateinit var channel: MethodChannel
  private var activity: Activity? = null
  private var pendingResult: MethodChannel.Result? = null
  private val REQUEST_CODE_PICK_EMAIL = 1001

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "email_contact_picker")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "pickEmail") {
      pickEmail(result)
    } else {
      result.notImplemented()
    }
  }

  private fun pickEmail(result: MethodChannel.Result) {
    pendingResult = result
    val intent = Intent(Intent.ACTION_PICK).apply {
      type = ContactsContract.CommonDataKinds.Email.CONTENT_TYPE
    }
    activity?.startActivityForResult(intent, REQUEST_CODE_PICK_EMAIL)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == REQUEST_CODE_PICK_EMAIL) {
      if (resultCode == Activity.RESULT_OK && data != null) {
        val contactUri: Uri? = data.data
        val projection = arrayOf(
          ContactsContract.CommonDataKinds.Email.ADDRESS,
          ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME
        )
        activity?.contentResolver?.query(contactUri!!, projection, null, null, null).use { cursor ->
          if (cursor != null && cursor.moveToFirst()) {
            val email = cursor.getString(cursor.getColumnIndexOrThrow(
              ContactsContract.CommonDataKinds.Email.ADDRESS
            ))
            val name = cursor.getString(cursor.getColumnIndexOrThrow(
              ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME
            ))
            pendingResult?.success(mapOf("name" to name, "email" to email))
          } else {
            pendingResult?.success(null)
          }
        }
      } else {
        pendingResult?.success(null)
      }
      return true
    }
    return false
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
