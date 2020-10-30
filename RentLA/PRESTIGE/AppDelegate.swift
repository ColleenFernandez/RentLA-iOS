//
//  AppDelegate.swift
//  PRESTIGE
//
//  Created by NEHAPRANYA on 26/08/20.
//  Copyright © 2020 kmmedical. All rights reserved.
//

/*
rahode1965@nic58.com
Admin@1q2w
 
 https://id.apple.com/IDMSEmailVetting/vetemail.html?language=GB-EN&key=001386-00-87959e4be75f1647757a03644a499a7812132da0c7a2084beaac8d3d20b08abcLTOW&type=DFT
 
 
*/
import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


 var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        UserDefaults.standard.set("\(ConstantsURL.deviceId)", forKey: "DEVICE_ID")
        
        UserDefaults.standard.set("Main", forKey: "STORY_BOARD")
        if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                UserDefaults.standard.set("MainP", forKey: "STORY_BOARD")
            case 1334:
                print("iPhone 6/6S/7/8")
                UserDefaults.standard.set("MainP", forKey: "STORY_BOARD")
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                    UserDefaults.standard.set("MainP", forKey: "STORY_BOARD")
            case 2436:
                print("iPhone X/XS/11 Pro")
                UserDefaults.standard.set("Main", forKey: "STORY_BOARD")
            case 2688:
                print("iPhone XS Max/11 Pro Max")
                UserDefaults.standard.set("Main", forKey: "STORY_BOARD")
            case 1792:
                print("iPhone XR/ 11 ")
            UserDefaults.standard.set("Main", forKey: "STORY_BOARD")

            default:
                print("Unknown")
            UserDefaults.standard.set("Main", forKey: "STORY_BOARD")
            }
        }
        
       // UserDefaults.standard.set("Main", forKey: "STORY_BOARD")
        let storyboard = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil)
                                                            
                   let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerOldResults") as! ViewControllerOldResults
                                   
                                   let navigationController = self.window?.rootViewController as! UINavigationController
                                   
                                   
                   navigationController.pushViewController(destinationViewController, animated: false)
        
        
        /*
        var office = UserDefaults.standard.string(forKey: "PATIENT_ID")
        
        
        
        if office == nil || "\(office!)" == ""
        {
            let storyboard = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil)
                                                     
            let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerPower") as! ViewControllerPower
                            
                            let navigationController = self.window?.rootViewController as! UINavigationController
                            
                            
            navigationController.pushViewController(destinationViewController, animated: false)
        }
        else
        {
            
            let fff = UserDefaults.standard.string(forKey: "OTP_STA")
            
            
            if "\(fff!)" == "F"
            {
                let storyboard = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil)
                                                         
                let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerOTP") as! ViewControllerOTP
                                
                                let navigationController = self.window?.rootViewController as! UINavigationController
                                
                                
                navigationController.pushViewController(destinationViewController, animated: false)
            }
            else
            {
                let storyboard = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil)
                                                         
                let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerResults") as! ViewControllerResults
                                
                                let navigationController = self.window?.rootViewController as! UINavigationController
                                
                                
                navigationController.pushViewController(destinationViewController, animated: false)
            }
           
        }
        
        */
        
        
        
        
         IQKeyboardManager.shared.enable = true
        
        return true
    }




}

struct ConstantsURL {
    
    static let baseURL = "https://rentla.net/oc-content/plugins/rest/api.php?key=sPjPJinAJ52Ij1oaA8Ejm9uROkpOFo" // This is for Base URL
    static let imageBaseURL = "https://rentla.net/"   // This is used for All Images
    static let apikey = "8PM8oApfCDk4tohQ"
    static let deviceId = "\(UIDevice.current.identifierForVendor?.uuidString ?? "")"
}
