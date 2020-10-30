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
import FlagPhoneNumber

class ViewControllerAddFF: UIViewController {
    
    
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: 1250 + 10)
        
    //phoneNumberTextField.set(phoneNumber: "Mobile Number")
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
      
      @IBOutlet weak var subview: UIView!
    @IBOutlet weak var txtCeleb: UITextField!
    
    
    @IBAction func clickRType(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Birthday", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            
         
            self.txtCeleb.text = "Birthday"
           
            
        }))

        alert.addAction(UIAlertAction(title: "Anniversary", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            
        
                      self.txtCeleb.text = "Annivaesary"
            
            
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
        
        
    }
    
    @IBAction func clickNewTest(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOldResults") as? ViewControllerOldResults
                                 {
                                    if let navigator = self.navigationController
                                     {
                                         navigator.pushViewController(viewController, animated: true)
                                     }
                                 }
        
        
//        if txtEmail.text! == ""
//        {
//            ProgressHUD.showError("Email Required")
//        }
//        else
//        {
//            ProgressHUD.showSuccess("Email sent successfully")
//            self.clickBack("")
//
//               // self.signinProcessNew()
//            
//        }
        
       
    }
    
    
    func signinProcessNew()
         {
             
            ProgressHUD.show()
                              
                                     //let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                        
                                   let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                       
                                                        var urlString = ""
                                                        let parameters: [String: String] = [
                                                          "api_key": "\(ConstantsURL.apikey)",
                                                            "action": "validateLogin",
                                                            "pin_code": "\(txtPassword.text!)",
                                                            "email_id": "\(txtEmail.text!)",
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
        
        let userId = "\(JSON?.value(forKeyPath: "patient_unique_id") ?? "")"
                         
                         UserDefaults.standard.set("\(userId)", forKey: "PATIENT_ID")
        
        UserDefaults.standard.set("S", forKey: "OTP_STA")
        
     if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerQR") as? ViewControllerQR
     {
        if let navigator = self.navigationController
         {
             navigator.pushViewController(viewController, animated: true)
         }
     }
         
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
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
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

