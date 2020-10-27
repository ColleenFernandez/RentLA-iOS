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
import SRSwiftyPopView



class ViewControllerOldResults: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,customProtocol,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    @IBOutlet weak var collctionView: UICollectionView!
    
    
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    var emp_array_s : NSMutableArray = NSMutableArray()
    
     var emp_sel : NSMutableArray = NSMutableArray()
    
    var emp_name_array : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var lblCurDate: UILabel!
    
    let allWallpaper = ["1","2","3","4","5","6"]



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        let nib = UINib(nibName: "SessionsTableViewCellFav", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "SessionsTableViewCellFav")
        
        
        
              let nib1 = UINib(nibName: "NormalCell", bundle: nil)
                           collctionView.register(nib1, forCellWithReuseIdentifier: "cell")
              
        
       let dateFormatter : DateFormatter = DateFormatter()
       //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       dateFormatter.dateFormat = "EEEE dd MMM yyyy"
       let date = Date()
       let dateString = dateFormatter.string(from: date)
        
        
        self.lblCity.text = "Greater Los Angeles"
        self.cityid = "451891"
        self.catId = "96"
        
        lblCurDate.text = dateString
        
          tabBar.selectedItem = tabBar.items![0] as! UITabBarItem
        
        self.signinProcessNew()
         self.signinProcessNews()
    }
    
    var catId = ""
    
    @IBAction func clickSearch(_ sender: Any) {
        
        if self.cityid == ""
        {
             ProgressHUD.showError("Select City")
        }
        else
        {
            
            
            UserDefaults.standard.set("object=search&action=items&sCategory=\(self.catId)&sRegion=&sCity=\(self.cityid)&sPriceMin=&sCompany=", forKey: "BROWSE_URL")

        UserDefaults.standard.set("Listings", forKey: "TOP_TITLE")
            
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerGroup") as? ViewControllerGroup
                                       {
                                           if let navigator = navigationController
                                           {
                                               navigator.pushViewController(viewController, animated: true)
                                           }
                                       }
        }
                                  
        
    }
    
              
    func signinProcessNews()
                {
                    
                   ProgressHUD.show()
                                     
                                            let token = UserDefaults.standard.string(forKey: "BROWSE_URL")
                                                               
                                          let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                              
                                                               var urlString = ""
                                                               let parameters: [String: String] = [
                                                                 "api_key": "\(ConstantsURL.apikey)",
                                                                 
                                                                 
                                                                   
                                                                   
                                                                   ]
                                                               
                                                               
        urlString = "\(ConstantsURL.baseURL)&type=read&object=search&action=latestItems&limit=1"
                                                                    
                                                               
                                                               
                                                               print(urlString)
                   
                                                              print(parameters)
                                                               
                                                               
                                                               
                                                               
                                                               
                                                              
                    
                                                               ProgressHUD.show()
                                                              
                                                            
                                                
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

               self.emp_array_s.removeAllObjects()
               
               self.emp_array_s.addObjects(from: signstatus)
               
              
             

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
   
    
    var selectionIndex = 0;
    
    
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
            
            
           if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyProfile") as? ViewControllerMyProfile
                                  {
                                      if let navigator = navigationController
                                      {
                                          navigator.pushViewController(viewController, animated: false)
                                      }
                                  }
            
            
        }
        else if item == (tabBar.items)![3] {
                   
                   
                 
                   
                   
               }
      
         
       }
       
    @IBAction func clickPop(_ sender: Any) {
        
        
        SRPopview.show(withValues: self.emp_name_array as! Array<String>) { (result) in
            switch result{
            case .notPicked():
                print("Didnt pick any")
            case .picked(let str, let index):
                print("Picked at \(index) \n Picked item : \(str)")
                
                
                let JSON = self.emp_array[index] as! NSDictionary

                              
                let test_status_desc = "\(JSON.value(forKeyPath: "pk_i_id") ?? "")"
                
                self.lblCity.text = str
                self.cityid = test_status_desc
            }
        }
        
       
        
        
        
    }
    
    var cityid = ""
    
    
    
    @IBOutlet weak var lblCity: UILabel!
    
            
    func signinProcessNew()
             {
                 
              //  ProgressHUD.show()
                                  
                                         let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                            
                                       let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                           
                                                            var urlString = ""
                                                            let parameters: [String: String] = [
                                                              "api_key": "\(ConstantsURL.apikey)",
                                                              
                                                              
                                                                
                                                                
                                                                ]
                                                            
                                                            
                urlString = "\(ConstantsURL.baseURL)&type=read&object=city&action=listAll"
                                                                 
                                                            
                                                            
                                                            print(urlString)
                
                                                           print(parameters)
                                                            
                                                            
                                                            
                                                            
                                                            //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                            
                                                           
                 
                                                       //     ProgressHUD.show()
                                                           
                                                         
                                             
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

            self.emp_array.removeAllObjects()
            self.emp_name_array.removeAllObjects()
            
            self.emp_array.addObjects(from: signstatus)
            
            for value in self.emp_array {
                
                let JSON = value as! NSDictionary

                                         
                let test_status_desc = "\(JSON.value(forKeyPath: "s_name") ?? "")"
                
                self.emp_name_array.add(test_status_desc)
            }
            
            
            print("self:\(self.emp_name_array)")
          

            self.tblView.reloadData()

                             
           // ProgressHUD.dismiss()
             
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
                return 200;
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                
                return emp_array_s.count
                
                
            }
    
    
  

                        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                        {
                            
                            let cell:SessionsTableViewCellFav = self.tblView.dequeueReusableCell(withIdentifier: "SessionsTableViewCellFav") as! SessionsTableViewCellFav
                            
                            
                            cell.selectionStyle = .none
                         
                    // cell.backgroundColor = #colorLiteral(red: 0, green: 0.4604327083, blue: 0.3862986565, alpha: 1)
                            
                         let JSON = self.emp_array_s[indexPath.row] as! NSDictionary

                                        
                                        let s_title = "\(JSON.value(forKeyPath: "s_title") ?? "")"
                                       let s_category_name = "\(JSON.value(forKeyPath: "s_category_name") ?? "")"
                                                   
                                     let s_address = "\(JSON.value(forKeyPath: "s_address") ?? "")"
                                                   
                                     let s_city = "\(JSON.value(forKeyPath: "s_city") ?? "")"
                                     let s_region = ""
                          let f_price = "\(JSON.value(forKeyPath: "i_price") ?? "")"

                         var intPrice =  Int(f_price)
                         
                            
                            print("pp:\(f_price)")
                                                   
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

                             let dict = signstatus[0] as! NSDictionary
                             
                             let s_title = "\(dict.value(forKeyPath: "s_path") ?? "")"
                             let pk_i_id = "\(dict.value(forKeyPath: "pk_i_id") ?? "")"

                             
                             let prviewurl = s_title
                                                let makeUrl = "\(ConstantsURL.imageBaseURL)\(prviewurl)\(pk_i_id)_preview.jpg"
                                                
                                                print("make:\(makeUrl)")
                             
                                                
                                                cell.imageObj.sd_setImage(with: URL(string: makeUrl), placeholderImage: UIImage(named: "tempplace.png"))

                                                
                                                cell.getValue = fk_i_item_id
                             
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
             
             let JSON = self.emp_array_s[indexPath.row] as! NSDictionary

                                                           
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
         
         
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              
            
                  
                  return CGSize(width: 200, height: 200)
                  
            
              
          }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
          {
              
              return 4
              
          }
          
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        
        
        
       
        let cell : NormalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for : indexPath) as! NormalCell
            
        if indexPath.row == 0 {
                               cell.lblPname.text = "Rooms"
                               cell.imgLike.image = UIImage.init(named: "rooms.png")
                           }
                           else  if indexPath.row == 1 {
                                                  cell.lblPname.text = "Studios"
                                                                     cell.imgLike.image = UIImage.init(named: "studios.png")
                                              }
                           else  if indexPath.row == 2 {
                                                                    cell.lblPname.text = "Apartments"
                                                                                       cell.imgLike.image = UIImage.init(named: "apartments.png")
                                                                }
                           else  if indexPath.row == 3 {
                                                                    cell.lblPname.text = "Houses"
                                                                                       cell.imgLike.image = UIImage.init(named: "house.png")
                                                                }
                           
                           
        cell.imgLike.setImageColor(color: UIColor.white)
        cell.lblPname.textColor = .white
                          
                           cell.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                           if selectionIndex == indexPath.row
                           {
                               cell.borderColor1 = #colorLiteral(red: 0, green: 0.4604327083, blue: 0.3862986565, alpha: 1)
                            cell.borderWidth1 = 5;
                           }
                           else
                           {
                            cell.borderWidth1 = 0;
                               cell.borderColor1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                            

                           }
                          
            
         return cell
      
        
        
       
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.row == 0{
       selectionIndex = 0;
            self.catId = "96";
                                UserDefaults.standard.set("object=items&action=byCategoryId&categoryId=96", forKey: "BROWSE_URL")
                                UserDefaults.standard.set("Room", forKey: "TOP_TITLE")

                                      }
                                      else  if indexPath.row == 1 {
            selectionIndex = 1;
             self.catId = "98";
                    UserDefaults.standard.set("object=items&action=byCategoryId&categoryId=98", forKey: "BROWSE_URL")
                         UserDefaults.standard.set("Studio", forKey: "TOP_TITLE")
                                                         }
                                      else  if indexPath.row == 2 {
            selectionIndex = 2;
             self.catId = "97";
                    UserDefaults.standard.set("object=items&action=byCategoryId&categoryId=97", forKey: "BROWSE_URL")
            UserDefaults.standard.set("Apartment", forKey: "TOP_TITLE")
                                                                           }
                                      else  if indexPath.row == 3 {
            selectionIndex = 3;
             self.catId = "99";
                    UserDefaults.standard.set("object=items&action=byCategoryId&categoryId=99", forKey: "BROWSE_URL")
            UserDefaults.standard.set("House", forKey: "TOP_TITLE")
                                                                           }
               
        
              
        self.collctionView.reloadData()
        
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

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
