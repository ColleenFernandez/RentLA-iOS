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


class ViewControllerEventDetails: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,customProtocol,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!

    
    @IBOutlet weak var segview: UISegmentedControl!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func clickManualUpload(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "PulpitCell", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "PulpitCell")
        
        
          tabBar.selectedItem = tabBar.items![0] as! UITabBarItem
        
        
        let nib1 = UINib(nibName: "NormalCell", bundle: nil)
                     collectionView.register(nib1, forCellWithReuseIdentifier: "cell")
                     
        
       // self.signinProcessNew()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
         
               
               return CGSize(width: 200, height: 200)
               
         
           
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
       {
           
           return 12
           
       }
       
       
       @IBOutlet weak var lblBadge: UILabel!
       @IBOutlet weak var imgBadge: UIImageView!
       
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
       {
           
           
           
           
          
           let cell : NormalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for : indexPath) as! NormalCell
               
               
            return cell
         
           
           
          
           
           
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
       {
           if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerShareMessages") as? ViewControllerShareMessages
                                    {
                                       if let navigator = self.navigationController
                                        {
                                            navigator.pushViewController(viewController, animated: true)
                                        }
                                    }
       }
    
    
    @IBAction func clickNew(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerNewContact") as? ViewControllerNewContact
                            {
                               if let navigator = self.navigationController
                                {
                                    navigator.pushViewController(viewController, animated: true)
                                }
                            }
        
        /*
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

                  alert.addAction(UIAlertAction(title: "Select From Address Book", style: .default , handler:{ (UIAlertAction)in
                      print("User click Approve button")
                      
                     
                      
                  }))

                  alert.addAction(UIAlertAction(title: "Create New", style: .default , handler:{ (UIAlertAction)in
                      print("User click Edit button")
                      
                    
                      
                      
                  }))

                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
                      print("User click Dismiss button")
                  }))

                  self.present(alert, animated: true, completion: {
                      print("completion block")
                  })
                  */
        
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
                return 60;
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                
                return 0
                
                
            }
            
            
               func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
               {
                   
                   let cell:PulpitCell = self.tblView.dequeueReusableCell(withIdentifier: "PulpitCell") as! PulpitCell
                   
                   
                   cell.selectionStyle = .none
                
                cell.imgLike.image = UIImage.init(named: "topic.png")
                cell.lblPclient.text = "The cross Before Me"
                  
                
                if indexPath.row == 4 || indexPath.row == 8  || indexPath.row == 15
                {
                    //cell.imgLike.image = UIImage.init(named: "message.png")
                    cell.lblPclient.text = "The cross Before Me"
                }
                else if indexPath.row == 1 || indexPath.row == 5  || indexPath.row == 10
                {
                     //cell.imgLike.image = UIImage.init(named: "call.png")
                    
                    cell.lblPclient.text = "Believe"
                }
                else if indexPath.row == 2 || indexPath.row == 6  || indexPath.row == 11
                {
                     //cell.imgLike.image = UIImage.init(named: "call1.png")
                    cell.lblPclient.text = "Miracle Mircy"
                }
                else if indexPath.row == 3 || indexPath.row == 7  || indexPath.row == 12
                {
                        // cell.imgLike.image = UIImage.init(named: "call2.png")
                    cell.lblPclient.text = "Forgiveness"
               }
                
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
                   return cell as PulpitCell
               }
          
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 4 || indexPath.row == 8  || indexPath.row == 15
         {
             //cell.imgLike.image = UIImage.init(named: "message.png")
             UserDefaults.standard.set("The Cross Before Me", forKey: "GET_TITLE")
         }
         else if indexPath.row == 1 || indexPath.row == 5  || indexPath.row == 10
         {
              //cell.imgLike.image = UIImage.init(named: "call.png")
              UserDefaults.standard.set("Believe", forKey: "GET_TITLE")
         }
         else if indexPath.row == 2 || indexPath.row == 6  || indexPath.row == 11
         {
             UserDefaults.standard.set("Miracle Mircy", forKey: "GET_TITLE")
              //cell.imgLike.image = UIImage.init(named: "call1.png")
         }
         else if indexPath.row == 3 || indexPath.row == 7  || indexPath.row == 12
         {
             UserDefaults.standard.set("Forgiveness", forKey: "GET_TITLE")
                 // cell.imgLike.image = UIImage.init(named: "call2.png")
        }
        
        
      if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOthers") as? ViewControllerOthers
              {
                  if let navigator = navigationController
                  {
                      navigator.pushViewController(viewController, animated: true)
                  }
              }
      
      
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
          
          
    navigationController?.popViewController(animated: true)
          
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

