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
import SDWebImage


class ViewControllerGroup: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,customProtocol  {
    
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!

    
    @IBOutlet weak var segview: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
              let nib = UINib(nibName: "SessionsTableViewCellFav", bundle: nil)
              tblView.register(nib, forCellReuseIdentifier: "SessionsTableViewCellFav")
              
        
        let token = UserDefaults.standard.string(forKey: "TOP_TITLE")
        self.lblThanks.text = "\(token!)"
        
          tabBar.selectedItem = tabBar.items![0] as! UITabBarItem
        
        self.emp_array.removeAllObjects()
        self.signinProcessNew(getCount: 0)
        tblView.addInfiniteScrolling(actionHandler: { [self] in
            // prepend data to dataSource, insert cells at top of table view
            // call [tableView.pullToRefreshView stopAnimating] when done

            self.tagCount = self.tagCount+1 ;

            self.signinProcessNew(getCount: self.tagCount)

        })
        
        
        
    }
    
    var tagCount = 0;
    
    
    @IBAction func clickNew(_ sender: Any) {
        
      
        
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
       
    
    
       
    
    
            
    func signinProcessNew(getCount:Int)
              {
                  
                if getCount == 0
                {
                 ProgressHUD.show()
                }
                                          let token = UserDefaults.standard.string(forKey: "BROWSE_URL")
                                                             
                                        let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                            
                                                             var urlString = ""
                                                             let parameters: [String: String] = [
                                                               "api_key": "\(ConstantsURL.apikey)",
                                                               
                                                               
                                                                 
                                                                 
                                                                 ]
                                                             
                                                             
                 urlString = "\(ConstantsURL.baseURL)&type=read&\(token!)&iPage=\(getCount)"
                                                                  
                                                             
                                                             
                                                             print(urlString)
                 
                                                            print(parameters)
                                                             
                                                             
                                                             
                                                             
                                                             
                                                            
                  
                                                            
                                                          
                                              
                                                               AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                                 {response in
                                                                 

                                                                     switch response.result {
                                                                     case .success:
                                                                         print("Res\(response.value!)")
                                                                         
                                                                         let JSON = response.value as! NSDictionary?
                                                                          
                                                                         
                                                                          
                                                                          let status = JSON?.value(forKeyPath: "status") as! String
                                                                          
           if status == "OK"
          {
             
            
             
             let signstatus = (JSON as AnyObject).value(forKeyPath: "response") as! Array<Any>

             
             
             self.emp_array.addObjects(from: signstatus)
             
            
            self.tblView.infiniteScrollingView.stopAnimating()

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
                    return 255;
                }
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
                {
                    
                    return self.emp_array.count
                    
                    
                }
                
                
                   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                   {
                       
                       let cell:SessionsTableViewCellFav = self.tblView.dequeueReusableCell(withIdentifier: "SessionsTableViewCellFav") as! SessionsTableViewCellFav
                       
                       
                       cell.selectionStyle = .none
                    
                    let JSON = self.emp_array[indexPath.row] as! NSDictionary

                                   
                                   let s_title = "\(JSON.value(forKeyPath: "s_title") ?? "")"
                                  let s_category_name = "\(JSON.value(forKeyPath: "s_category_name") ?? "")"
                                              
                                let s_address = "\(JSON.value(forKeyPath: "s_address") ?? "")"
                                              
                                let s_city = "\(JSON.value(forKeyPath: "s_city") ?? "")"
                                let s_region = ""
                     let f_price = "\(JSON.value(forKeyPath: "i_price") ?? "")"

                    var intPrice =  Int(f_price)
                    
                                              
                    cell.lblPName.text = "$\(intPrice!/1000000)/Month"
                                              cell.txtTitle.text = "\(s_title)"
                                              cell.txtAdress.text = "\(s_city) \(s_region)"
                    
                    
                    
                    
                    
                    let fk_i_item_id = "\(JSON.value(forKeyPath: "fk_i_item_id") ?? "")"
                    
                    
                    
                    
                    
                                           
                                                                        
                                                                        
                          let  urlString = "\(ConstantsURL.baseURL)&type=read&&object=item&action=resourcesById&itemId=\(fk_i_item_id)"
                                                                             

                                                                       // ProgressHUD.show()
                                                                       
                                                                     
                                                         
                                                                          AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                                            {response in
                                                                            

                                                                                switch response.result {
                                                                                case .success:
                                                                                    print("Res\(response.value!)")
                                                                                    
                                                                                    let JSON = response.value as! NSDictionary?
                                                                                     
                                                                                    
                                                                                     
                                                                                     let status = JSON?.value(forKeyPath: "status") as! String
                                                                                     
                      if status == "OK"
                     {
                        
                       
                        
                        let signstatus = (JSON as AnyObject).value(forKeyPath: "response") as! Array<Any>

                        if signstatus.count == 0
                        {
                            
                        }
                        else
                        {
                        
                        let dict = signstatus[0] as! NSDictionary
                        
                        let s_title = "\(dict.value(forKeyPath: "s_path") ?? "")"
                        let pk_i_id = "\(dict.value(forKeyPath: "pk_i_id") ?? "")"

                        
                        let prviewurl = s_title
                                           let makeUrl = "\(ConstantsURL.imageBaseURL)\(prviewurl)\(pk_i_id)_preview.jpg"
                                           
                                           print("make:\(makeUrl)")
                        
                                           
                                           cell.imageObj.sd_setImage(with: URL(string: makeUrl), placeholderImage: UIImage(named: "tempplace.png"))

                                           
                                           cell.getValue = fk_i_item_id
                            
                        }
                        
                    }
                    else
                     {
                        
                       
                     
                    }
                                                                                    
                                                                                   
                                                                                    
                                            
                                            break
                                        case .failure(let error):
                                            // SVProgressHUD.showError(withStatus: error.localizedDescription)
                                         ProgressHUD.dismiss()
                                            print(error.localizedDescription)
                                        }
                                                 
                                   }
                                                     
                                                     
                                                     
                                                     
                                                           
                                                
                                                 
                    
                    
                    
                    
                       return cell as SessionsTableViewCellFav
                   }
     
    
          
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let JSON = self.emp_array[indexPath.row] as! NSDictionary

                                          
        let s_title = "\(JSON.value(forKeyPath: "fk_i_item_id") ?? "")"
        
        UserDefaults.standard.set("\(s_title)", forKey: "ITEM_ID")
        
        let myData = NSKeyedArchiver.archivedData(withRootObject: JSON)
        UserDefaults.standard.set(myData, forKey: "ADS_DATA")
        
        
        
        
        
        
         if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAdsDetails") as? ViewControllerAdsDetails
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
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAddFF") as? ViewControllerAddFF
                                   {
                                      if let navigator = self.navigationController
                                       {
                                           navigator.pushViewController(viewController, animated: true)
                                       }
                                   }
           
       }
    
    @objc func delClicked(_ button: UIButton?) {
        
        let row = Int(button!.tag % 1000 )
        let section = Int(button!.tag / 1000 )
         
         
            
        }
    
    
    @IBAction func clickNewTest(_ sender: Any) {
        
        ProgressHUD.showSuccess("Group Created Successfully")
        
        self.clickBack("")
            
        
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

