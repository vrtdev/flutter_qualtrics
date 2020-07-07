package be.vrt.flutter_qualtrics

import android.content.Context
import androidx.annotation.NonNull
import com.qualtrics.digital.Qualtrics
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** QualtricsFlutterPlugin */
public class QualtricsFlutterPlugin : FlutterPlugin, MethodCallHandler {

    private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_qualtrics")
        val plugin = QualtricsFlutterPlugin()
        plugin.context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(plugin)
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_qualtrics")
            val plugin = QualtricsFlutterPlugin()
            plugin.context = registrar.context()
            channel.setMethodCallHandler(plugin)
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (val data = Extractor.qualtricsCallFromCall(call)) {
            is Extractor.QualtricsCall.Init -> init(data, result)
            is Extractor.QualtricsCall.EvaluateTargetingLogic -> evaluateTargetingLogic(result)
            is Extractor.QualtricsCall.Display -> display(result)
            is Extractor.QualtricsCall.DisplayTarget -> displayTarget(data, result)
            is Extractor.QualtricsCall.Hide -> hide(result)
            is Extractor.QualtricsCall.RegisterViewVisit -> registerViewVisit(data, result)
            is Extractor.QualtricsCall.ResetTimer -> resetTimer(result)
            is Extractor.QualtricsCall.ResetViewCounter -> resetViewCounter(result)
            is Extractor.QualtricsCall.SetStringProperty -> setStringProperty(data, result)
            Extractor.QualtricsCall.Unknown -> result.notImplemented()
        }.exhaustive
    }

    private fun init(parameters: Extractor.QualtricsCall.Init, result: Result) {
        Qualtrics.instance().initialize(parameters.brandId, parameters.zoneId, parameters.interceptId, context)
        result.success(true)
    }

    private fun evaluateTargetingLogic(result: Result) {
        Qualtrics.instance().evaluateTargetingLogic {
            if (it.error != null) {
                result.error("-1", it.error.message, it.error.localizedMessage)
            } else {
                result.success(it.passed())
            }
        }
    }

    private fun display(result: Result) {
        result.success(Qualtrics.instance().display(context))
    }

    private fun displayTarget(parameter: Extractor.QualtricsCall.DisplayTarget, result: Result) {
        Qualtrics.instance().displayTarget(context, parameter.target)
        result.success(true)
    }

    private fun hide(result: Result) {
        result.success(Qualtrics.instance().hide())
    }

    private fun registerViewVisit(parameter: Extractor.QualtricsCall.RegisterViewVisit, result: Result) {
        Qualtrics.instance().registerViewVisit(parameter.viewName)
        result.success(true)
    }

    private fun resetTimer(result: Result) {
        Qualtrics.instance().resetTimer()
        result.success(true)
    }

    private fun resetViewCounter(result: Result) {
        Qualtrics.instance().resetViewCounter()
        result.success(true)
    }

    private fun setStringProperty(parameter: Extractor.QualtricsCall.SetStringProperty, result: Result) {
        Qualtrics.instance().properties.setString(parameter.key, parameter.value)
        result.success(true)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

}

private val <T> T.exhaustive: T
    get() = this