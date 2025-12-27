package com.farkmi.spinsnitch_mobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.provider.Settings
import android.os.Build

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.farkmi.spinsnitch_mobile/recognition"
    private var channel: MethodChannel? = null

    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == "com.farkmi.spinsnitch_mobile.NOW_PLAYING") {
                val title = intent.getStringExtra("title")
                val text = intent.getStringExtra("text")
                channel?.invokeMethod("onTrackRecognized", mapOf(
                    "title" to title,
                    "text" to text
                ))
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        
        channel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "hasPermission" -> {
                    result.success(isNotificationServiceEnabled())
                }
                "openPermissionSettings" -> {
                    startActivity(Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"))
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        val filter = IntentFilter("com.farkmi.spinsnitch_mobile.NOW_PLAYING")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(receiver, filter, Context.RECEIVER_EXPORTED)
        } else {
            registerReceiver(receiver, filter)
        }
    }

    private fun isNotificationServiceEnabled(): Boolean {
        val pkgName = packageName
        val flat = Settings.Secure.getString(contentResolver, "enabled_notification_listeners")
        if (flat != null && flat.isNotEmpty()) {
            val names = flat.split(":").toTypedArray()
            for (name in names) {
                if (name.contains(pkgName)) {
                    return true
                }
            }
        }
        return false
    }

    override fun onDestroy() {
        unregisterReceiver(receiver)
        super.onDestroy()
    }
}
