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
import ProgressHUD

class ViewControllerLogin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtname: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtaddress: UITextField!
    
    
    @IBAction func clickNewTest(_ sender: Any) {
        
        
        if txtEmail.text! == "" ||   txtname.text! == "" ||  txtPhone.text! == ""
        {
            ProgressHUD.showError("Required fields Missing")
        }
        else
        {
            if txtEmail.text!.isValidEmail()
            {
        
            self.signinProcessNew()
            }
            else
            {
                ProgressHUD.showError("Please enter Valid Email")
            }
        }
    }
    
    
    func signinProcessNew()
                   {
                       
                      ProgressHUD.show()
                                        
                                               let token = UserDefaults.standard.string(forKey: "LANG")
                                                                  
                                                                  var urlString = ""
                                                                  let parameters: [String: String] = [
                                                                    "api_key": "\(ConstantsURL.apikey)",
                                                                      "action": "registerPatient",
                                                                      "email_id": "\(txtEmail.text!)",
                                                                      "name": "\(txtname.text!)",
                                                                    "mobile_no": "\(txtPhone.text!)",
                                                                    "dob": "\(txtDob.text!)",
                                                                    "address": "\(txtaddress.text!)",
                                                                    
                                                                      
                                                                      
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
                 //UserDefaults.standard.set("F", forKey: "OTP_STATUS")
                
                 UserDefaults.standard.set("F", forKey: "OTP_STA")
                
                  
                UserDefaults.standard.set("\(self.txtEmail.text!)", forKey: "MOBILE_NO")
                  
                  ProgressHUD.showSuccess(JSON?.value(forKeyPath: "message") as! String)
                  
                  if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOTP") as? ViewControllerOTP
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

