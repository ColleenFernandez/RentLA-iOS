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

class ViewControllerMyAds: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,customProtocol  {
    
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var lblCurDate: UILabel!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "ListingCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "ListingCell")
        
        
       let dateFormatter : DateFormatter = DateFormatter()
       //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       dateFormatter.dateFormat = "EEEE dd MMM yyyy"
       let date = Date()
       let dateString = dateFormatter.string(from: date)
        
        
        lblCurDate.text = dateString
        
          tabBar.selectedItem = tabBar.items![2] as! UITabBarItem
        
       // self.signinProcessNew()
    }
    
    
    @IBAction func clickSearch(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSettingsNew") as? ViewControllerSettingsNew
                                       {
                                           if let navigator = navigationController
                                           {
                                               navigator.pushViewController(viewController, animated: true)
                                           }
                                       }
                                  
        
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
    }
    
    
   func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        print("Come")
        
        if item == (tabBar.items)![0] {
            
         if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOldResults") as? ViewControllerOldResults
                              {
                                  if let navigator = navigationController
                                  {
                                      navigator.pushViewController(viewController, animated: false)
                                  }
                              }
                         
                         
                     
            
            
        }
        else if item == (tabBar.items)![1] {
            
            
      if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerFavourites") as? ViewControllerFavourites
                    {
                        if let navigator = navigationController
                        {
                            navigator.pushViewController(viewController, animated: false)
                        }
                    }
           
            
            
        }
     else if item == (tabBar.items)![2] {
         
         
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyAds") as? ViewControllerMyAds
              {
                  if let navigator = navigationController
                  {
                      navigator.pushViewController(viewController, animated: false)
                  }
              }
         
         
     }
     else if item == (tabBar.items)![3] {
                
                
               if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyProfile") as? ViewControllerMyProfile
                     {
                         if let navigator = navigationController
                         {
                             navigator.pushViewController(viewController, animated: false)
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
                                                                "action": "getListTestRequest",
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
            
            /*
            let test_status_desc = "\(JSON?.value(forKeyPath: "data.test_status_desc") ?? "")"
            let test_result_desc = "\(JSON?.value(forKeyPath: "data.test_result_desc") ?? "")"
            
            let test_date = "\(JSON?.value(forKeyPath: "data.test_date") ?? "")"
            
             let test_name = "\(JSON?.value(forKeyPath: "data.test_name") ?? "")"
            
            
            self.txtDate.text = "Test From \(test_date)"
            self.txtDes.text = "\(test_name)\n\(test_result_desc)"
            self.txtResults.text = "\(test_status_desc)👍"
            */
            
            let signstatus = (JSON as AnyObject).value(forKeyPath: "data") as! Array<Any>

            self.emp_array.removeAllObjects()
            self.emp_array.addObjects(from: signstatus)

            self.tblView.reloadData()

                             
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
    
    func numberOfSections(in tableView: UITableView) -> Int
            {
                return 1
            }
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
            {
                return 526;
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                
                return 5
                
                
            }
            
            
               func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
               {
                   
                   let cell:ListingCell = self.tblView.dequeueReusableCell(withIdentifier: "ListingCell") as! ListingCell
                   
                   
                   cell.selectionStyle = .none
                   /*
                let JSON = self.emp_array[indexPath.row] as! NSDictionary

                
                let test_status_desc = "\(JSON.value(forKeyPath: "test_status_desc") ?? "")"
                           let test_result_desc = "\(JSON.value(forKeyPath: "test_result_desc") ?? "")"
                           
                           let test_date = "\(JSON.value(forKeyPath: "test_date") ?? "")"
                           
                            let test_name = "\(JSON.value(forKeyPath: "test_name") ?? "")"
                           
                           
                           cell.txtDate.text = "Test From \(test_date)"
                           cell.txtDes.text = "\(test_name)\n\(test_result_desc)"
                           cell.txtResults.text = "\(test_status_desc)"
                 
                cell.btnCommend.addTarget(self, action: #selector(self.cmdClicked(_:)), for: .touchUpInside)
                          cell.btnCommend.tag = (indexPath.section * 1000) + indexPath.row
                 */
                
                
                cell.btnProfile.addTarget(self, action: #selector(self.ceditClicked(_:)), for: .touchUpInside)
                                         cell.btnCommend.tag = (indexPath.section * 1000) + indexPath.row
                
                cell.btnTag.addTarget(self, action: #selector(self.delClicked(_:)), for: .touchUpInside)
                                         cell.btnCommend.tag = (indexPath.section * 1000) + indexPath.row
                
                cell.btnCommend.addTarget(self, action: #selector(self.cmdClicked(_:)), for: .touchUpInside)
                                         cell.btnCommend.tag = (indexPath.section * 1000) + indexPath.row
                
                
                   return cell as ListingCell
               }
          
    
    @objc func cmdClicked(_ button: UIButton?) {
       
      
       
           
           if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAdsDetails") as? ViewControllerAdsDetails
           {
               if let navigator = navigationController
               {
                   navigator.pushViewController(viewController, animated: true)
               }
           }
           
       }
    
    @objc func ceditClicked(_ button: UIButton?) {
         
        
         
             
             if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAddFF") as? ViewControllerAddFF
             {
                 if let navigator = navigationController
                 {
                     navigator.pushViewController(viewController, animated: true)
                 }
             }
             
         }
    
     @objc func delClicked(_ button: UIButton?) {
        
        let alert = UIAlertController(title: "rentLA.net", message: "Do you want to Delete?", preferredStyle: .alert)
                             let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
                                 
                             
                             
                      
                      })
                             let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
                             })
                             alert.addAction(ok)
                             alert.addAction(cancel)
                             DispatchQueue.main.async(execute: {
                                 self.present(alert, animated: true)
                             })
        
    }
    
    
    @IBAction func clickNewTest(_ sender: Any) {
        
       if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAddFF") as? ViewControllerAddFF
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
    }
    
    
    @IBAction func clickTrack(_ sender: Any) {
        
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func clickViewLab(_ sender: Any) {
        
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
        
    }
    
    @IBAction func clickActions(_ sender: Any) {
        
        guard let url = URL(string: "https://google.com") else { return }
        UIApplication.shared.open(url)
    }
    
    
    @IBAction func clickBack(_ sender: Any) {
           
          // navigationController?.popViewController(animated: true)
           
           
          if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerReceivedMessages") as? ViewControllerReceivedMessages
           {
               if let navigator = navigationController
               {
                   navigator.pushViewController(viewController, animated: true)
               }
           }
       }
    func didTapSomeButton(_ getController: String?) {
    print("Tabbed:\(getController ?? "")")
    
    
    
    
        let tabbed = "\(getController ?? "")"
        if tabbed == "1"
        {
            
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOldResults") as? ViewControllerOldResults
                 {
                     if let navigator = navigationController
                     {
                         navigator.pushViewController(viewController, animated: true)
                     }
                 }
        
        }
        if tabbed == "2"
        {
            
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyContacts") as? ViewControllerMyContacts
                 {
                     if let navigator = navigationController
                     {
                         navigator.pushViewController(viewController, animated: true)
                     }
                 }
        
        }
        if tabbed == "3"
        {
            
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyuPost") as? ViewControllerMyuPost
                 {
                     if let navigator = navigationController
                     {
                         navigator.pushViewController(viewController, animated: true)
                     }
                 }
        
        }
        if tabbed == "4"
               {
                   
                   if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerFekkowship") as? ViewControllerFekkowship
                        {
                            if let navigator = navigationController
                            {
                                navigator.pushViewController(viewController, animated: true)
                            }
                        }
               
               }
        
        
        if tabbed == "9"
                      {
                          
                          if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerNewProfile") as? ViewControllerNewProfile
                               {
                                   if let navigator = navigationController
                                   {
                                       navigator.pushViewController(viewController, animated: true)
                                   }
                               }
                      
                      }
        if tabbed == "6"
                             {
                                 
                                 if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerChapel") as? ViewControllerChapel
                                      {
                                          if let navigator = navigationController
                                          {
                                              navigator.pushViewController(viewController, animated: true)
                                          }
                                      }
                             
                             }
    if tabbed == "5"
                                {
                                    
                                    if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerCalendar") as? ViewControllerCalendar
                                         {
                                             if let navigator = navigationController
                                             {
                                                 navigator.pushViewController(viewController, animated: true)
                                             }
                                         }
                                
                                }
        if tabbed == "10"
                          {
                              
                              if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSettingsNew") as? ViewControllerSettingsNew
                                   {
                                       if let navigator = navigationController
                                       {
                                           navigator.pushViewController(viewController, animated: true)
                                       }
                                   }
                          
                          }
        
              if tabbed == "7"
                                 {
                                     
                                     if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerPulpit") as? ViewControllerPulpit
                                          {
                                              if let navigator = navigationController
                                              {
                                                  navigator.pushViewController(viewController, animated: true)
                                              }
                                          }
                                 
                                 }
        
        if tabbed == "8"
                                       {
       
       if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerClass") as? ViewControllerClass
            {
                if let navigator = navigationController
                {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
   
   }
        
        
    }
    
}

