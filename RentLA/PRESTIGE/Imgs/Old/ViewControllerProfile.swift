//
//  ViewController.swift
//  PRESTIGE
//
//  Created by NEHAPRANYA on 26/08/20.
//  Copyright © 2020 kmmedical. All rights reserved.
//

import UIKit
import DatePickerDialog
import Alamofire
import ProgressHUD

class ViewControllerProfile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.signinProcessNew()
    }
    
    @IBOutlet weak var txtPhone: UITextField!
       @IBOutlet weak var txtname: UITextField!
       
       @IBOutlet weak var txtEmail: UITextField!
       
       @IBOutlet weak var txtaddress: UITextField!
    
    func signinProcessNew()
         {
             
            ProgressHUD.show()
                              
                                     let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                        
                                   let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                       
                                                        var urlString = ""
                                                        let parameters: [String: String] = [
                                                          "api_key": "\(ConstantsURL.apikey)",
                                                            "action": "getPatientDemographics",
                                                           "patient_unique_id": "\(token!)",
                                                          
                                                            
                                                            
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
        
        let address = "\(JSON?.value(forKeyPath: "data.address") ?? "")"
        let date_of_birth = "\(JSON?.value(forKeyPath: "data.date_of_birth") ?? "")"
        
        let email_id = "\(JSON?.value(forKeyPath: "data.email_id") ?? "")"
        
         let mobile_no = "\(JSON?.value(forKeyPath: "data.mobile_no") ?? "")"
        
       let patient_name = "\(JSON?.value(forKeyPath: "data.patient_name") ?? "")"
        
        
        self.txtDob.text = "\(date_of_birth)"
        self.txtaddress.text = "\(address)"
        self.txtname.text = "\(patient_name)"
        self.txtEmail.text = "\(email_id)"
        self.txtPhone.text = "\(mobile_no)"
       
        
                         
        ProgressHUD.dismiss()
         
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
    
    
    
    @IBAction func clickSettings(_ sender: Any) {
        
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSettings") as? ViewControllerSettings
                                               {
                                                   if let navigator = navigationController
                                                   {
                                                       navigator.pushViewController(viewController, animated: true)
                                                   }
                                               }
    }
    
    
     @IBAction func clickNewTest(_ sender: Any) {
           
           
           if txtEmail.text! == "" ||   txtname.text! == "" ||  txtPhone.text! == ""
           {
               ProgressHUD.showError("Required fields Missing")
           }
           else
           {
               if txtEmail.text!.isValidEmail()
               {
           
               self.signinProcessNew1()
               }
               else
               {
                   ProgressHUD.showError("Please enter Valid Email")
               }
           }
       }
       
       
       func signinProcessNew1()
                      {
                          
                         ProgressHUD.show()
                                           
                                                  let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                                     
                                                                     var urlString = ""
                                                                     let parameters: [String: String] = [
                                                                       "api_key": "\(ConstantsURL.apikey)",
                                                                         "action": "updatPatientDemographics",
                                                                         "email_id": "\(txtEmail.text!)",
                                                                         "name": "\(txtname.text!)",
                                                                       "mobile_no": "\(txtPhone.text!)",
                                                                       "dob": "\(txtDob.text!)",
                                                                       "address": "\(txtaddress.text!)",
                                                                        "patient_unique_id": "\(token!)",
                                                                       
                                                                         
                                                                         
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
                     
                   
                     ProgressHUD.showSuccess(JSON?.value(forKeyPath: "message") as! String)
                     
                    self.clickBack("")
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

