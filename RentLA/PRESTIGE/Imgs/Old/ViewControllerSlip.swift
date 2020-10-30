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

class ViewControllerSlip: UIViewController {
    
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtLoc: UILabel!
    @IBOutlet weak var txtNo: UILabel!
    @IBOutlet weak var txtReady: UILabel!
    
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.signinProcessNew()
    }
    
    func signinProcessNew()
            {
                
               ProgressHUD.show()
                                 
                                        let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                           
                                      let deviceid = UserDefaults.standard.string(forKey: "TEST_ID")
                                                                                                          
                                                           var urlString = ""
                                                           let parameters: [String: String] = [
                                                             "api_key": "\(ConstantsURL.apikey)",
                                                               "action": "getSingleTestRequest",
                                                              "patient_unique_id": "\(token!)",
                                                            "test_request_id": "\(deviceid!)",
                                                             
                                                               
                                                               
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
           
           let test_date = "\(JSON?.value(forKeyPath: "data.test_date") ?? "")"
           let test_identification_no = "\(JSON?.value(forKeyPath: "data.test_identification_no") ?? "")"
           
           let test_name = "\(JSON?.value(forKeyPath: "data.test_name") ?? "")"
           
           
            let test_ready_date = "\(JSON?.value(forKeyPath: "data.test_ready_date") ?? "")"
            
            let test_result_desc = "\(JSON?.value(forKeyPath: "data.test_result_desc") ?? "")"
            
            
         
            
           
           self.txtDate.text = "\(test_date)"
           self.txtName.text = "\(test_name)"
           self.txtLoc.text = "\(test_result_desc)"
            self.txtNo.text = "\(test_identification_no)"
            self.txtReady.text = "\(test_ready_date)"
           
                            
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
    
    
    var testStstus = "0"
       
    
    @IBAction func clickNewTest(_ sender: Any) {
        
       if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerResults") as? ViewControllerResults
       {
           if let navigator = navigationController
           {
               navigator.pushViewController(viewController, animated: true)
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

