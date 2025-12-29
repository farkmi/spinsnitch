package com.farkmi.spinsnitch_mobile

import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class NowPlayingListenerService : NotificationListenerService() {

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        val packageName = sbn.packageName
        
        // Pixel "Now Playing" package
        if (packageName == "com.google.intelligence.sense") {
            val extras = sbn.notification.extras
            val title = extras.getString("android.title")
            val text = extras.getString("android.text")
            
            Log.d("NowPlayingListener", "Caught: title=$title, text=$text")
            
            val intent = Intent("com.farkmi.spinsnitch_mobile.NOW_PLAYING")
            intent.putExtra("title", title)
            intent.putExtra("text", text)
            sendBroadcast(intent)
        }
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification) {
        // Not needed for now
    }
}
