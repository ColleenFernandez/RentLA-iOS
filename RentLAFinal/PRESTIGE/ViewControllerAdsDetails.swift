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
import ImageSlideshow
import Kingfisher
import MessageUI


class ViewControllerAdsDetails: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,UITabBarDelegate,customProtocol  {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    
    var listsArray : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!

    
    @IBOutlet weak var segview: UISegmentedControl!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var subview: UIView!
    
 var emp_name_array : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let islogin = UserDefaults.standard.string(forKey: "LOGIN")
        
        
        if islogin == "YES"
        {
            self.checkAdsinUserList()
            self.checkUserListNames()
        }
        
        
        
              let nib = UINib(nibName: "CommentCell", bundle: nil)
              tblView.register(nib, forCellReuseIdentifier: "CommentCell")
        
        
        //let JSON = UserDefaults.standard.value(forKey: "ADS_DATA") as! NSDictionary

        let recovedUserJsonData = UserDefaults.standard.object(forKey: "ADS_DATA")
        let JSON = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data) as! NSDictionary

                                          
                                          let s_title = "\(JSON.value(forKeyPath: "s_title") ?? "")"
                                         let s_category_name = "\(JSON.value(forKeyPath: "s_category_name") ?? "")"
                                                     
                                       let s_address = "\(JSON.value(forKeyPath: "s_address") ?? "")"
                                                     
                                       let s_city = "\(JSON.value(forKeyPath: "s_city") ?? "")"
                                       let s_region = "\(JSON.value(forKeyPath: "s_region") ?? "")"
                            let f_price = "\(JSON.value(forKeyPath: "i_price") ?? "")"

                           if f_price != ""
                           {
                            
                             var intPrice =  Int(f_price)
                            self.lbl.text = "$\(intPrice!/1000000)/Month"
                            
        }
        else
                           {
            self.lbl.text = ""
        }
                          
                           
        
        let s_description = "\(JSON.value(forKeyPath: "s_description") ?? "")"
        
        let fk_i_category_id = "\(JSON.value(forKeyPath: "fk_i_category_id") ?? "")"
        
        if fk_i_category_id == "96"
        {
            self.lblCategory.text =  "Rooms"
        }
        if fk_i_category_id == "97"
        {
            self.lblCategory.text =  "Apartments"
        }
        if fk_i_category_id == "98"
        {
            self.lblCategory.text =  "Studios"
        }
        if fk_i_category_id == "99"
        {
            self.lblCategory.text =  "Houses"
        }
                                       
                           
                           self.lblTitle.text = "\(s_title)"
        self.lblDescription.text = "\(s_description)"
        
        
        
        
                           self.lblAddress.text = "\(s_city)"
        
        
        
              
          
          tabBar.selectedItem = tabBar.items![0] as! UITabBarItem
        self.signinProcessNew()
        self.signinProcessAttributes()
        
        
        let token = UserDefaults.standard.string(forKey: "TOP_TITLE")
        self.lblThanks.text = "Listing"
        
              
              
              
             
        
        
        let fk_i_item_id = "\(UserDefaults.standard.string(forKey: "ITEM_ID")!)"
                           
                           
                           
                           
                           
                                                  
                                                                               
                                                                               
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

                                
                                for value in signstatus {
                                    
                                    let dict = value as! NSDictionary

                                                             
                                    
                                    
                                                                  
                                                                  let s_title = "\(dict.value(forKeyPath: "s_path") ?? "")"
                                                                  let pk_i_id = "\(dict.value(forKeyPath: "pk_i_id") ?? "")"

                                                                  
                            let prviewurl = s_title
                            let makeUrl = "\(ConstantsURL.imageBaseURL)\(prviewurl)\(pk_i_id).jpg"
                                                                                     
                                                                                     print("make:\(makeUrl)")
                                    
                                    
                                    self.emp_name_array.add(KingfisherSource(urlString: "\(makeUrl)") as Any)
                                }
                                
                              
                                print(self.emp_name_array)
                                          
                                
                                
                                self.slideShow.backgroundColor = UIColor.clear
                                self.slideShow.slideshowInterval = 2.0
                                self.slideShow.pageControlPosition = .underScrollView
                                self.slideShow.pageControl.currentPageIndicatorTintColor = UIColor.green
                                self.slideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
                                self.slideShow.contentScaleMode = UIView.ContentMode.scaleToFill
                                self.slideShow.scrollView.isScrollEnabled = false
                                
                                // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
                                self.slideShow.activityIndicator = DefaultActivityIndicator()
                                self.slideShow.currentPageChanged = { page in
                                    //print("current page:", page)
                                    
                                    
                                    //self.surpage = page
                                    
                                    
                                }
                                self.slideShow.setImageInputs(self.emp_name_array as! [InputSource])
                               
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
              
        
    }
    
   
    
    func signinProcessAttributes()
                 {
                     
                    ProgressHUD.show()
                                      
                                             let item_ID = UserDefaults.standard.string(forKey: "ITEM_ID")
                                                                
                                           let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                               
                                                                var urlString = ""
                                                                let parameters: [String: String] = [
                                                                  "api_key": "\(ConstantsURL.apikey)",
                                                                  
                                                                  
                                                                    
                                                                    
                                                                    ]
                                                                
                                                                
                    urlString = "\(ConstantsURL.baseURL)&type=read&object=plugin-attributes&action=getItemAttributes&itemId=\(item_ID!)"
                                                                     
                                                                
                                                                
                                                                print(urlString)
                    
                                                               print(parameters)
                                                                
                                                                
                                                                
                                                                
                                                                //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                                
                                                               
                     
                                                                ProgressHUD.show()
                                                               
                                                             
                                                 
                                                                  AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                                    {response in
                                                                    

                                                                        switch response.result {
                                                                        case .success:
                                                                           // print("Res\(response.value!)")
                                                                            
                                                                            let JSON = response.value as! NSDictionary?
                                                                             
                                                                            
                                                                             
                                                                             let status = JSON?.value(forKeyPath: "status") as! String
                                                                             
              if status == "OK"
             {
                
               
                
                let JSON = (JSON as AnyObject).value(forKeyPath: "response") as! Array<Any>

                print("KKKK:\(JSON)")

                 self.att_name_array.removeAllObjects()
                

                self.att_name_array.addObjects(from: JSON)
                
                
                
                for value in self.att_name_array {
                    
                    let JSON = value as! NSDictionary

                                             
                    let test_status_desc = "\(JSON.value(forKeyPath: "pk_i_id") ?? "")"
                    
                    self.signinProcessGetAttributes(value: test_status_desc)
                    
                }
                
                
                if self.att_name_array.count == 0
                {
                    self.tblView.reloadData()
                                           
                                           self.tblView.setY(y: self.subview.frame.size.height)
                                           
                                           
                                           self.lblDescription.textContainerInset = UIEdgeInsets.zero
                                           self.lblDescription.textContainer.lineFragmentPadding = 0
                                           
                                           
                                           self.lblDescription.contentOffset = .zero
                                           
                                           var frame = self.lblDescription.frame
                                           frame.size.height = self.calculateHeight(inString: self.lblDescription.text)
                                           frame.origin.x = 2
                                           self.lblDescription.frame = frame
                                           
                                           //self.lblDescription.adjustUITextViewHeight()
                                           
                                           self.lblDescription.setY(y: self.subview.frame.size.height + self.tableViewHeight + 20)
                                           
                           self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width,
                                                                                height: self.subview.frame.size.height+self.tableViewHeight + self.calculateHeight(inString: "\(self.lblDescription.text!)")+20+300)
                                                  
                                           
                                           
                }
                
                
                //self.tblView.reloadData()
                                 
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
    
    func signinProcessGetAttributes(value : String)
                    {
                        
                       
                                         
                    let item_ID = UserDefaults.standard.string(forKey: "ITEM_ID")
                                                                   
                    let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                                  
                                                                   var urlString = ""
                                                                   let parameters: [String: String] = [
                                                                     "api_key": "\(ConstantsURL.apikey)",
                                                                     
                                                                     
                                                                       
                                                                       
                                                                       ]
                                                                   
                                                                   
                        urlString = "\(ConstantsURL.baseURL)&type=read&object=plugin-attributes&action=getItemAttributeValues&itemId=\(item_ID!)&attributeId=\(value)"
                                                                        
                                                                   
                                                                   
                                                                   print(urlString)
                       
                                                                  print(parameters)
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                                   
                                                                  
                        
                                                                   ProgressHUD.show()
                                                                  
                                                                
                                                    
                                                                     AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                                       {response in
                                                                       

                                                                           switch response.result {
                                                                           case .success:
                                                                              // print("Res\(response.value!)")
                                                                               
                                                                               let JSON = response.value as! NSDictionary?
                                                                                
                                                                               
                                                                                
                                                                                let status = JSON?.value(forKeyPath: "status") as! String
                                                                                
                 if status == "OK"
                {
                   
                  
                   
                   let JSON = (JSON as AnyObject).value(forKeyPath: "response") as! NSDictionary

                   print("SK:\(JSON)")

                    let test_status_desc = "\(JSON.value(forKeyPath: "s_value") ?? "")"
                    let fk_i_attribute_id = "\(JSON.value(forKeyPath: "fk_i_attribute_id") ?? "")"
                   
                    self.dictionary.updateValue(test_status_desc, forKey: fk_i_attribute_id)

                    self.att_det_array.add(test_status_desc)
                   
                    if self.att_det_array.count == self.att_name_array.count
                    {
                    
                print(self.att_det_array)
                        print(self.dictionary)
                  self.tblView.reloadData()
                        
                        self.tblView.setY(y: self.subview.frame.size.height)
                        
                        
                        self.lblDescription.textContainerInset = UIEdgeInsets.zero
                        self.lblDescription.textContainer.lineFragmentPadding = 0
                        
                        
                        self.lblDescription.contentOffset = .zero
                        
                        var frame = self.lblDescription.frame
                        frame.size.height = self.calculateHeight(inString: self.lblDescription.text)
                        frame.origin.x = 2
                        self.lblDescription.frame = frame
                        
                        //self.lblDescription.adjustUITextViewHeight()
                        
                        self.lblDescription.setY(y: self.subview.frame.size.height + self.tableViewHeight + 20)
                        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width,
                                                             height: self.subview.frame.size.height+self.tableViewHeight + self.calculateHeight(inString: "\(self.lblDescription.text!)")+20+300)
                               
                        
                        
                        
                    }
                                    
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
    
    
    func checkUserListNames()
                             {
                                 
                                
                                                  
                                                                            
                             let userid = UserDefaults.standard.string(forKey: "USER_ID_VALUE")
                                                                                                                           
                                                                            var urlString = ""
                                                                            let parameters: [String: String] = [
                                                                              "api_key": "\(ConstantsURL.apikey)",
                                                                              
                                                                              
                                                                                
                                                                                
                                                                                ]
                                                                            
        urlString = "\(ConstantsURL.baseURL)&type=read&object=plugin-favorite_items&action=getListsByUserId&userId=\(userid!)"
                                                                                 
                                                                            
                                                                            
                                                                            print(urlString)
                                
                                                                           print(parameters)
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                                            
                                                                           
                                 
                                                                           
                                                                         
                                                             
                                                                              AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                                                {response in
                                                                                

                                                                                    switch response.result {
                                                                                    case .success:
                                                                                       ("Res\(response.value!)")
                                                                                        
                                                                                        let JSON = response.value as! NSDictionary?
                                                                                         
                                                                                        
                                                                                         
                                                                                         let status = JSON?.value(forKeyPath: "status") as! String
                                                                                         
                          if status == "OK"
                         {
                            
                           
                            
                          let JSON = (JSON as AnyObject).value(forKeyPath: "response") as! Array<Any>

                           print("JSON:\(JSON)")
                          
                          if JSON.count == 0
                          {
                               
                          }
                          else
                          {
                            let dict = JSON[0] as! NSDictionary
                            
                            self.listID = "\(dict.value(forKeyPath: "list_id") ?? "")"
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
                                                         
                            }
       
    
    var listID = ""
    
    
    func checkAdsinUserList()
                       {
                           
                          
                                            
                       let item_ID = UserDefaults.standard.string(forKey: "ITEM_ID")
                                                                      
                       let userid = UserDefaults.standard.string(forKey: "USER_ID_VALUE")
                                                                                                                     
                                                                      var urlString = ""
                                                                      let parameters: [String: String] = [
                                                                        "api_key": "\(ConstantsURL.apikey)",
                                                                        
                                                                        
                                                                          
                                                                          
                                                                          ]
                                                                      
                                                                      
                           urlString = "\(ConstantsURL.baseURL)&type=read&object=plugin-favorite_items&action=getAllByUserIdAndItemId&itemId=\(item_ID!)&userId=\(userid!)"
                                                                           
                                                                      
                                                                      
                                                                      print(urlString)
                          
                                                                     print(parameters)
                                                                      
                                                                      
                                                                      
                                                                      
                                                                      //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                                      
                                                                     
                           
                                                                     
                                                                   
                                                       
                                                                        AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                                          {response in
                                                                          

                                                                              switch response.result {
                                                                              case .success:
                                                                                 
                                                                                  
                let JSON = response.value as! NSDictionary?
                                                                                   
                            print("Res\(JSON)")
                                                                                   
                let status = JSON?.value(forKeyPath: "status") as! String
                                                                                   
                    if status == "OK"
                   {
                      
                     
                      
                    let JSON = (JSON as AnyObject).value(forKeyPath: "response")

                     print("JSON:\(JSON)")
                    
                    if let arrayVersion = JSON as? NSArray{
                        
                        self.imgResend.image = UIImage.init(systemName: "heart")
                    }
                    else
                    {
                        self.imgResend.image = UIImage.init(systemName: "heart.fill")
                        self.btnrese.isEnabled = false;
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
                                                   
                      }
    
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

        self.lblDescription.contentOffset = .zero
    }
    
    func calculateHeight(inString:String) -> CGFloat
       {
           let messageString = inString
           //let attributes = [NSAttributedString.Key.font.rawValue : UIFont.systemFont(ofSize: 15.0)]
           
           let attributes = [NSAttributedString.Key.font:
               UIFont(name: "Helvetica", size: 15.0)!,
                             NSAttributedString.Key.foregroundColor: UIColor.white] as! [NSAttributedString.Key: Any]
           
           let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
           
           let rect : CGRect = attributedString.boundingRect(with: CGSize(width: self.lblDescription.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
           
           let requredSize:CGRect = rect
           return requredSize.height
       }
    
    var tableViewHeight: CGFloat {
        self.tblView.layoutIfNeeded()

        return self.tblView.contentSize.height
    }
    var dictionary =  [String:String]()

    
    var att_name_array : NSMutableArray = NSMutableArray()
    var att_det_array : NSMutableArray = NSMutableArray()

    
    @IBAction func clickNew(_ sender: Any) {
        
        let islogin = UserDefaults.standard.string(forKey: "LOGIN")
        
        
        if islogin == "YES"
        {
            let payment = UserDefaults.standard.string(forKey: "PAYMENT")
                   
                   if payment! == "SUCCESS"
                   {
                   
                   
                   let alert = UIAlertController(title: "Contact", message: "\(mobileNumber)", preferredStyle: .actionSheet)

                             alert.addAction(UIAlertAction(title: "Call", style: .default , handler:{ (UIAlertAction)in
                                 print("User click Approve button")
                                 
                               if let url = URL(string: "tel://\(self.mobileNumber)"),
                               UIApplication.shared.canOpenURL(url) {
                                  if #available(iOS 10, *) {
                                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                                   } else {
                                       UIApplication.shared.openURL(url)
                                   }
                               } else {
                                        // add error message here
                                   
                                   ProgressHUD.showError("Something Went Wrong")
                               }
                                
                                 
                             }))

                             alert.addAction(UIAlertAction(title: "Message", style: .default , handler:{ (UIAlertAction)in
                                 print("User click Edit button")
                                 
                               if (MFMessageComposeViewController.canSendText()) {
                                   let controller = MFMessageComposeViewController()
                                   controller.body = "Message Body"
                                   controller.recipients = [self.mobileNumber]
                                   controller.messageComposeDelegate = self
                                   self.present(controller, animated: true, completion: nil)
                               }
                                 
                                 
                             }))
                 

                             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
                                 print("User click Dismiss button")
                             }))

                             self.present(alert, animated: true, completion: {
                                 print("completion block")
                             })
                   }
                   else
                   {
                       ProgressHUD.showError("Please Subscripe Membership to Continue")
                       if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyProfile") as? ViewControllerMyProfile
                                         {
                                             if let navigator = navigationController
                                             {
                                                 navigator.pushViewController(viewController, animated: true)
                                             }
                                         }
                   }
        }
      else
      {
          ProgressHUD.showError("Please Login to reveal Contact details")
          if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyProfile") as? ViewControllerMyProfile
                            {
                                if let navigator = navigationController
                                {
                                    navigator.pushViewController(viewController, animated: true)
                                }
                            }
      }
        
       
                  
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
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
                                      
                                             let item_ID = UserDefaults.standard.string(forKey: "ITEM_ID")
                                                                
                                           let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                               
                                                                var urlString = ""
                                                                let parameters: [String: String] = [
                                                                  "api_key": "\(ConstantsURL.apikey)",
                                                                  
                                                                  
                                                                    
                                                                    
                                                                    ]
                                                                
                                                                
                    urlString = "\(ConstantsURL.baseURL)&type=read&object=item&action=byId&itemId=\(item_ID!)"
                                                                     
                                                                
                                                                
                                                                print(urlString)
                    
                                                               print(parameters)
                                                                
                                                                
                                                                
                                                                
                                                                //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                                
                                                               
                     
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
                
               
                
                let JSON = (JSON as AnyObject).value(forKeyPath: "response") as! NSDictionary

                print("JK:\(JSON)")

                self.mobileNumber = "\(JSON.value(forKeyPath: "mobile") ?? "")"
                                 
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
    
    var mobileNumber = ""
    
                   
    @IBOutlet weak var lblAddress: UITextView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var lblTitle: UITextView!
    
    @IBOutlet weak var lblCategory: UITextView!
    
    @IBOutlet weak var lblDescription: UITextView!
    
    
        
        func numberOfSections(in tableView: UITableView) -> Int
                {
                    return 1
                }
                func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
                {
                    return 50;
                }
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
                {
                    
                    return self.att_name_array.count
                    
                    
                }
                
                
                   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
                   {
                       
                       let cell:CommentCell = self.tblView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
                       
                       
                       cell.selectionStyle = .none
                    
                    let JSON = self.att_name_array[indexPath.row] as! NSDictionary

                    
                    let s_name = "\(JSON.value(forKeyPath: "s_name") ?? "")"
                    let s_type = "\(JSON.value(forKeyPath: "s_type") ?? "")"
                    let pk_i_id = "\(JSON.value(forKeyPath: "pk_i_id") ?? "")"
                    
                    print(s_type)
                    
                    cell.lblPclient.text = s_name
                    
                    if s_type == "TEXT"
                    {
                        
                        let apple: String? = self.dictionary["\(pk_i_id)"]

                        cell.lblCommends.text = apple
                    }
                    else
                    {
                        let apple: String? = self.dictionary["\(pk_i_id)"]
                        let s_types = apple
                        
                        if s_types == "1"
                        {
                            cell.lblCommends.text = "✔"
                        }
                        else
                        {
                            cell.lblCommends.text = "☐"
                        }
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
                       return cell as CommentCell
                   }
              
          
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerFellowProfile") as? ViewControllerFellowProfile
                                        {
                                           if let navigator = self.navigationController
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
        
        let fk_i_item_id = "\(UserDefaults.standard.string(forKey: "ITEM_ID")!)"
       
        print("FFF:\(fk_i_item_id)")
        
        let islogin = UserDefaults.standard.string(forKey: "LOGIN")
        
        
        if islogin == "YES"
        {
            let user_id = "\(UserDefaults.standard.string(forKey: "USER_ID_VALUE")!)"

            self.makefav()
            
            
        }
        else
        {
            ProgressHUD.showError("Please Login to Continue")
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyProfile") as? ViewControllerMyProfile
                              {
                                  if let navigator = navigationController
                                  {
                                      navigator.pushViewController(viewController, animated: true)
                                  }
                              }
                     
        }
        
        
    }
    
    func makefav()
         {
             
            
            
            
                              
         let item_ID = UserDefaults.standard.string(forKey: "ITEM_ID")
                                                        
            let userid = self.listID
                                                                                                       
                                                        var urlString = ""
                                                        let parameters: [String: String] = [
                                                          "api_key": "\(ConstantsURL.apikey)",
                                                          
                                                          
                                                            
                                                            
                                                            ]
                                                        
                                                        
             urlString = "\(ConstantsURL.baseURL)&type=insert&object=plugin-favorite_items&action=insertFavoriteItem&listId=\(self.listID)&itemId=\(item_ID!)"
                                                             
                                                        
                                                        
                                                        print(urlString)
            
                                                       print(parameters)
                                                        
                                                        
                                                        
                                                        
                                                        //Alamofire.request(urlString, method: .put, parameters: parameters, encoding: ".JSON", headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON
                                                        
                                                       
             
                                                       
                                                     
                                         
                                                          AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).responseJSON
                                                            {response in
                                                            

                                                                switch response.result {
                                                                case .success:
                                                                   ("Res\(response.value!)")
                                                                    
                                                                    let JSON = response.value as! NSDictionary?
                                                                     
                                                                    
                                                                     
                                                                     let status = JSON?.value(forKeyPath: "status") as! String
                                                                     
      if status == "OK"
     {
        
       
        
     
      
      if self.imgResend.image == UIImage.init(systemName: "heart")
      {
          self.imgResend.image = UIImage.init(systemName: "heart.fill")
      }
      else
      {
          self.imgResend.image = UIImage.init(systemName: "heart")
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

extension UIView {
    /**
    Set x Position

    :param: x CGFloat
    by DaRk-_-D0G
    */
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
    Set y Position

    :param: y CGFloat
    by DaRk-_-D0G
    */
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    /**
    Set Width

    :param: width CGFloat
    by DaRk-_-D0G
    */
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    /**
    Set Height

    :param: height CGFloat
    by DaRk-_-D0G
    */
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}
extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
