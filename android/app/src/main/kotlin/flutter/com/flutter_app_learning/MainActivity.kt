package flutter.com.flutter_app_learning

import android.annotation.SuppressLint
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Base64
import android.util.Log
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        generateFBKeyHash()
        GeneratedPluginRegistrant.registerWith(this)
    }

    @SuppressLint("PackageManagerGetSignatures")
    fun generateFBKeyHash() {
        try {
            var info: PackageInfo? = null
            try {
                info = packageManager.getPackageInfo(
                        "flutter.com.flutter_app_learning",
                        PackageManager.GET_SIGNATURES)
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }

            if (info != null) {
                for (signature in info.signatures) {
                    val md = MessageDigest.getInstance("SHA")
                    md.update(signature.toByteArray())
                    Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT))
                }
            }
        } catch (e: NoSuchAlgorithmException) {

        }

    }


}
