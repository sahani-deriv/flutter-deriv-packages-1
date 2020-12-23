import Flutter
import UIKit

@objc public class SwiftSurveyMonkeyPlugin: UIViewController, FlutterPlugin {
    
    public var rootViewController: UIViewController?
    private var flutterResult: FlutterResult?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "survey_monkey", binaryMessenger: registrar.messenger())
        let instance = SwiftSurveyMonkeyPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "start":
            if let myArgs = call.arguments as? [String: Any?],
               let surveyHash : String = myArgs["surveyHash"] as? String {
                
                flutterResult = result
                
                let surveyViewController = SurveyViewController()
                surveyViewController.surveyHash = surveyHash
                
                rootViewController = UIApplication.shared.keyWindow?.rootViewController
                
                // Set notification observor to get survey monkey results.
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "survey-monkey-status"),
                                                       object: nil, queue: nil, using: getStatus)
                
                let navigationController:UINavigationController! = UINavigationController(rootViewController: surveyViewController)
                
                navigationController?.setNavigationBarHidden(true, animated: true)
                rootViewController?.present(navigationController, animated: true, completion: nil)
                
            }
        default:
            let response: [String: String] = ["response": "Method is not defined!"]
            result(response.toJson)
        }
    }
    
    func getStatus(notification: Notification) -> Void {
        rootViewController?.dismiss(animated: true, completion: nil)
        
        if let extractInfo = notification.userInfo {
            let description = extractInfo["description"] as! String
            if(description != ""){
                let smRespondent: SMRespondent = SMRespondent(respondent_id: "",
                                                              completion_status: "",
                                                              error: description)
                
                let response: [String: String?] = ["response": smRespondent.toJson]
                flutterResult!(response.toJson)      
            } else {
                let smRespondent: SMRespondent = SMRespondent(respondent_id: extractInfo["respondentId"] as! String,
                                                              completion_status: extractInfo["status"] as! String,
                                                              error: "")
                
                let response: [String: String?] = ["response": smRespondent.toJson]
                flutterResult!(response.toJson)
            }            
            
        }
    }
}
