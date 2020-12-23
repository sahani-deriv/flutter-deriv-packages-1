package com.deriv.survey_monkey

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.content.Intent
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.surveymonkey.surveymonkeyandroidsdk.SurveyMonkey
import com.surveymonkey.surveymonkeyandroidsdk.utils.SMError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.Serializable

/** SurveyMonkeyPlugin */
class SurveyMonkeyPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
        PluginRegistry.ActivityResultListener {

    companion object {
        const val SM_RESPONDENT = "smRespondent"
        const val SM_ERROR = "smError"
        const val SM_REQUEST_CODE = 0
    }

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var surveyMonkey: SurveyMonkey
    private lateinit var gson: Gson
    private lateinit var activity: Activity
    private lateinit var result: Result

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "survey_monkey")
        channel.setMethodCallHandler(this)

        surveyMonkey = SurveyMonkey()
        gson = Gson()
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        this.result = result
        if (call.method == "start") {
            val session = call.argument("surveyHash") ?: ""
            surveyMonkey.startSMFeedbackActivityForResult(activity, SM_REQUEST_CODE, session)

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {

        if (requestCode == SM_REQUEST_CODE && resultCode == RESULT_OK && data != null) {
            // success
            val respondent: String? = data.getStringExtra(SM_RESPONDENT)
            val smRespondent: SMRespondent = gson.fromJson(respondent, SMRespondent::class.java)

            result.success(gson.toJson(buildResponseBody(gson.toJson(smRespondent))))

        } else {
            // failure, errors, or cancellation
            val error: Serializable? = data?.getSerializableExtra(SM_ERROR)
            if (error is SMError) {
                val smRespondent =
                        SMRespondent("", "incomplete", error.description)
                result.success(gson.toJson(buildResponseBody(gson.toJson(smRespondent))))
            }
        }

        return true
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}

    private fun buildResponseBody(response: Any): Map<String, Any> = mapOf("response" to response)

}
