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

class ViewControllerResults: UIViewController {
    
    
    
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signinProcessNew()
    }
    
    
    
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtResults: UILabel!
    
    @IBOutlet weak var txtDes: UITextView!
    
    func signinProcessNew()
         {
             
            ProgressHUD.show()
                              
                                     let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                        
                                   let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                       
                                                        var urlString = ""
                                                        let parameters: [String: String] = [
                                                          "api_key": "\(ConstantsURL.apikey)",
                                                            "action": "getLastTestRequest",
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
        
        let test_status_desc = "\(JSON?.value(forKeyPath: "data.test_status_desc") ?? "")"
        let test_result_desc = "\(JSON?.value(forKeyPath: "data.test_result_desc") ?? "")"
        
        let test_date = "\(JSON?.value(forKeyPath: "data.test_date") ?? "")"
        
         let test_name = "\(JSON?.value(forKeyPath: "data.test_name") ?? "")"
        
        self.testStstus = "\(JSON?.value(forKeyPath: "data.test_status") ?? "")"
        
        
        self.txtDate.text = "Test From \(test_date)"
        self.txtDes.text = "\(test_name)\n\(test_result_desc)"
        self.txtResults.text = "\(test_status_desc)👍"
        
                         
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
        
       if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerQR") as? ViewControllerQR
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
        
         if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerProfile") as? ViewControllerProfile
              {
                  if let navigator = navigationController
                  {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
        
    }
    
    @IBAction func clickShare(_ sender: Any) {
        
        // text to share
        let text = "Test from Wed Aug 12 2020"

        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func clickOld(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOldResults") as? ViewControllerOldResults
                    {
                        if let navigator = navigationController
                        {
                            navigator.pushViewController(viewController, animated: true)
                        }
                    }
    }
    
    
    @IBAction func clickTrack(_ sender: Any) {
        
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func clickViewLab(_ sender: Any) {
        
        if testStstus == "0"
        {
            ProgressHUD.showError("Test Results still In pending,Once test results ready we will notify")
        }
        else
        {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSlip") as? ViewControllerSlip
        {
            if let navigator = self.navigationController
            {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        }
        
    }
    
    @IBAction func clickActions(_ sender: Any) {
        
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
    }
    
}

