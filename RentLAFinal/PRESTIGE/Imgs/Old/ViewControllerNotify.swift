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

class ViewControllerNotify: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,customProtocol  {
    
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!

    
    @IBOutlet weak var segview: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "NotifyCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "NotifyCell")
        
        
          tabBar.selectedItem = tabBar.items![3] as! UITabBarItem
        
       // self.signinProcessNew()
    }
    @IBAction func changeSeg(_ sender: Any) {
        
        self.tblView.reloadData()
    }
    
   func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           
           print("Come")
           
           if item == (tabBar.items)![0] {
               
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyNetworks") as? ViewControllerMyNetworks
                                 {
                                     if let navigator = navigationController
                                     {
                                         navigator.pushViewController(viewController, animated: false)
                                     }
                                 }
                            
                            
                        
               
               
           }
           else if item == (tabBar.items)![1] {
               
               
              if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyuPost") as? ViewControllerMyuPost
                    {
                        if let navigator = navigationController
                        {
                            navigator.pushViewController(viewController, animated: false)
                        }
                    }
               
               
           }
        else if item == (tabBar.items)![2] {
            
            
           if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerFekkowship") as? ViewControllerFekkowship
                 {
                     if let navigator = navigationController
                     {
                         navigator.pushViewController(viewController, animated: false)
                     }
                 }
            
            
        }
        else if item == (tabBar.items)![3] {
                   
                   
                  if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerNotify") as? ViewControllerNotify
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
                return 100;
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                
                return 20
                
                
            }
            
            
               func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
               {
                   
                   let cell:NotifyCell = self.tblView.dequeueReusableCell(withIdentifier: "NotifyCell") as! NotifyCell
                   
                   
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
                   return cell as NotifyCell
               }
          
    
    @objc func cmdClicked(_ button: UIButton?) {
       
       let row = Int(button!.tag % 1000 )
       let section = Int(button!.tag / 1000 )
        
         let JSON = self.emp_array[row] as! NSDictionary
        let test_status_desc = "\(JSON.value(forKeyPath: "test_request_id") ?? "")"

        UserDefaults.standard.set("\(test_status_desc)", forKey: "TEST_ID")

       
       print("You selected Row #\(row)! Section #\(section)!")
           
           if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSlip") as? ViewControllerSlip
           {
               if let navigator = navigationController
               {
                   navigator.pushViewController(viewController, animated: true)
               }
           }
           
       }
    
    
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
           
          // navigationController?.popViewController(animated: true)
           
           
           var basketTopFrame: CGRect = self.view.frame
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.frame = basketTopFrame
                    // basketBottom.frame = basketBottomFrame;
                }) { finished in
                }
                
                var sideView = SideView()
                sideView.delegate = self
                sideView.frame = view.bounds
                view.addSubview(sideView)
           
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
               
               if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerFekkowship") as? ViewControllerFekkowship
                    {
                        if let navigator = navigationController
                        {
                            navigator.pushViewController(viewController, animated: true)
                        }
                    }
           
           }
           if tabbed == "4"
                  {
                      
                      if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerNotify") as? ViewControllerNotify
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
    
}

