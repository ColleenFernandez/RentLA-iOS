//
//  ViewController.swift
//  PRESTIGE
//
//  Created by NEHAPRANYA on 26/08/20.
//  Copyright © 2020 kmmedical. All rights reserved.
//

import UIKit
import DatePickerDialog
import ProgressHUD
import Alamofire


class ViewControllerOTP: UIViewController {
    
    @IBOutlet weak var lblOtp: UILabel!
    
    @IBOutlet weak var otpView: VPMOTPView!
    
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let mobile = UserDefaults.standard.string(forKey: "MOBILE_NO")
        
        
        self.lblOtp.text = "We just sent the text message to \(mobile!) with a code for you to enter here"
        
        otpView.becomeFirstResponder()
        
        otpView.otpFieldsCount = 5
               otpView.otpFieldDisplayType = .underlinedBottom
               otpView.otpFieldDefaultBorderColor = UIColor.lightGray
               otpView.otpFieldEnteredBorderColor = UIColor.black
               otpView.otpFieldErrorBorderColor = UIColor.clear
               otpView.otpFieldBorderWidth = 2
               otpView.delegate = self
               otpView.shouldAllowIntermediateEditing = false
               
               // Create the UI
               otpView.initializeUI()
    }
    
    @IBAction func clickNewTest(_ sender: Any) {
        
        if enteredOtp == ""
        {
            ProgressHUD.showError("Enter Valid OTP")
        }
        else
        {
            
            UserDefaults.standard.set("S", forKey: "OTP_STA")
                                          
                                          if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerQR") as? ViewControllerQR
                                                                                {
                                                                                   if let navigator = self.navigationController
                                                                                    {
                                                                                        navigator.pushViewController(viewController, animated: true)
                                                                                    }
                                                                                }
            
           
        }
    }
    
    func signinProcessNew()
                      {
                          
                         ProgressHUD.show()
                                           
                                                  let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                                     
                                                let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                                    
                                                                     var urlString = ""
                                                                     let parameters: [String: String] = [
                                                                       "api_key": "\(ConstantsURL.apikey)",
                                                                         "action": "validatePatientPin",
                                                                         "pin_code": "\(enteredOtp)",
                                                                       "patient_unique_id": "\(token!)",
                                                                        "device_id": "\(deviceid!)",
                                                                       
                                                                         
                                                                         
                                                                         ]
                                                                     
                                                                     
                                                                 urlString = "\(ConstantsURL.baseURL)"
                                                                          
                                                                     
                                                                     
                                                                     print(urlString)
                         
                                                                    print(parameters)
                                                                     
                                                                     
                                                                     
                                                                     
                                                                     //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                                     
                                                                    
                          
                                                                     ProgressHUD.show()
                                                                    
                                                                  
                                                      
                                                                       AF.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON
                                                                         {response in
                                                                         

                                                                             switch response.result {
                                                                             case .success:
                                                                                 print("Res\(response.value!)")
                                                                                 
                                                                                 let JSON = response.value as! NSDictionary?
                                                                                  
                                                                                 
                                                                                  
                                                                                  let status = JSON?.value(forKeyPath: "status") as! Bool
                                                                                  
                   if status
                  {
                     
                   self.lblThanks.isHidden = false
                   self.imgNext.isHidden = false
                   
                   self.btnrese.isHidden = true
                   self.imgResend.isHidden = true
                      
                    ProgressHUD.showSuccess()
                 }
                 else
                  {
                      ProgressHUD.showError(JSON?.value(forKeyPath: "message") as! String)
                    
                    
                   
                 }
                                                                                 
                                                                                
                                                                                 
                                         
                                         break
                                     case .failure(let error):
                                         // SVProgressHUD.showError(withStatus: error.localizedDescription)
                                      ProgressHUD.dismiss()
                                         print(error.localizedDescription)
                                     }
                                              
                                }
                                                  
                                                  
                                                  
                                                  
                                                        
                                             
                                              }
    
    
    @IBOutlet weak var lblThanks: UILabel!
    
    @IBOutlet weak var imgNext: UIImageView!
    
    @IBOutlet weak var imgResend: UIImageView!
    
    @IBAction func btnResend(_ sender: Any) {
        
        ProgressHUD.showSuccess("OTP Send Again")
    }
    
    @IBOutlet weak var btnrese: UIButton!
    
    
    
    @IBAction func clickAlreadyHave(_ sender: Any) {
    }
    
    @IBAction func clickDOB(_ sender: Any) {
        
        DatePickerDialog().show("Select Date of Birth", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", maximumDate: Date(), datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM/dd/yyyy"
                        self.txtDob.text = formatter.string(from: dt)
                    }
        }
    }
    
    @IBOutlet weak var txtDob: UITextField!
    
    
    @IBAction func clickBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    


}


extension ViewControllerOTP: VPMOTPViewDelegate {
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        
        return enteredOtp == "12345"
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        enteredOtp = otpString
        print("OTPString: \(otpString)")
        
         self.signinProcessNew()
        
        
    }
}
