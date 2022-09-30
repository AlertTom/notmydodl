package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.androidintent.AndroidIntentPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin android_intent_plus, dev.fluttercommunity.plus.androidintent.AndroidIntentPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new flutter.overlay.window.flutter_overlay_window.FlutterOverlayWindowPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_overlay_window, flutter.overlay.window.flutter_overlay_window.FlutterOverlayWindowPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.hustlance.fullscreen.FullscreenPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin fullscreen, com.hustlance.fullscreen.FullscreenPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin permission_handler, com.baseflow.permissionhandler.PermissionHandlerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new in.jvapps.system_alert_window.SystemAlertWindowPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin system_alert_window, in.jvapps.system_alert_window.SystemAlertWindowPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.systemshortcuts.SystemShortcutsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin system_shortcuts, com.example.systemshortcuts.SystemShortcutsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.volume.VolumePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin volume, com.example.volume.VolumePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.kurenai7968.volume_controller.VolumeControllerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin volume_controller, com.kurenai7968.volume_controller.VolumeControllerPlugin", e);
    }
  }
}
