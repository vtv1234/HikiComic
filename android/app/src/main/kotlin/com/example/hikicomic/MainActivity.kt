package com.example.hikicomic

import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.hikicomic/androidId"

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if(call.method=="getAndroidId")
      {
        var androidId= Settings.Secure.getString(
            this.contentResolver,
            Settings.Secure.ANDROID_ID
        )
        result.success(androidId);
      }
      else {
        result.notImplemented()
      }
  }
}
}