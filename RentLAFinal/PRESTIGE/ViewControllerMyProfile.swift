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
import StoreKit

class ViewControllerMyProfile: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,customProtocol  {
    
    var quotesContent: QuotesGroup!
    var products: [SKProduct] = []
    
    @IBOutlet weak var tblView: UITableView!
    var emp_array : NSMutableArray = NSMutableArray()
    
    var enteredOtp: String = ""
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var lblCurDate: UILabel!
    
    @IBOutlet weak var imgPayment: UIImageView!
    @IBOutlet weak var btnPayment: UIButton!
    
    @IBOutlet weak var txtEmailNew: UITextField!
    
    @IBOutlet weak var txtPasswordNew: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "SessionsTableViewCellFav", bundle: nil)
        tblView.register(nib, forCellReuseIdentifier: "SessionsTableViewCellFav")
        
        
       let dateFormatter : DateFormatter = DateFormatter()
       //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       dateFormatter.dateFormat = "EEEE dd MMM yyyy"
       let date = Date()
       let dateString = dateFormatter.string(from: date)
        
        
        let islogin = UserDefaults.standard.string(forKey: "LOGIN")
        
        
        if islogin == "YES"
        {
            self.clickLoginView.isHidden = true
            self.clickProfileView.isHidden = false
            self.txtlblll.text = "Welcome Back \(UserDefaults.standard.string(forKey: "U_EMAIL")!)"
            

            PoohWisdomProducts.store.requestProducts { [weak self] success, products in
              guard let self = self else { return }
              guard success else {
               
                print("Failed to load list of products")
                
                return
              }
              self.products = products!
                
                
            }
            if PoohWisdomProducts.store.isProductPurchased(PoohWisdomProducts.poohWisdomSub) {
               
                print("Purchased")
                UserDefaults.standard.set("YES", forKey: "PAID")
                
                self.clickPurchase()

                
            }
            else {
            
                print("Not Purchased")
                UserDefaults.standard.set("", forKey: "PAID")
                
            }
            
            
            self.checkUserPayment()
        }
        else
        {
            self.clickLoginView.isHidden = false
                       self.clickProfileView.isHidden = true
        }
        
        lblCurDate.text = dateString
        
          tabBar.selectedItem = tabBar.items![2] as! UITabBarItem
        
       // self.signinProcessNew()
    }
    @IBAction func clickIAP(_ sender: Any) {
        
        ProgressHUD.show()
        
        #if targetEnvironment(simulator)

        //Simulator
        
        self.clickPurchase()

        #else

        guard !products.isEmpty else {
               print("Cannot purchase subscription because products is empty!")
                   ProgressHUD.dismiss()
                  return
                }

                
                  self.purchaseItemIndex(index: 0)
        #endif
        
       
        
        
        
    }
    
    private func purchaseItemIndex(index: Int) {
      PoohWisdomProducts.store.buyProduct(products[0]) { [weak self] success, productId in
       
       print("pro:\(productId)")
       
          guard self != nil else { return }
        guard success else {
          print("Failed to load list of products")
           ProgressHUD.dismiss()
          return
        }
       
       if success
       {
           print("Purchase success")
        self!.clickPurchase()
           ProgressHUD.dismiss()
           
       }
       
        
      }
    }

    
    @IBAction func clickRestore(_ sender: Any) {
       
        ProgressHUD.show()
         
        // PoohWisdomProducts.store.restorePurchases()
         
         PoohWisdomProducts.store.restorePurchases(products[0]) { [weak self] success, productId in
                
                print("pro:\(productId)")
                
                   guard self != nil else { return }
                 guard success else {
                   print("Failed to load list of products")
                    ProgressHUD.dismiss()
                   return
                 }
                
                if success
                {
                    print("Purchase success")
                     self!.clickPurchase()
                    
                }
                
                 ProgressHUD.dismiss()
         }
         
         ProgressHUD.dismiss()
        
    }
    
    
    @IBAction func clickLogout(_ sender: Any) {
        
        let alert = UIAlertController(title: "rentLA.net", message: "Do you want to logout?", preferredStyle: .alert)
                      let ok = UIAlertAction(title: "Yes", style: .default, handler: { action in
                          
                          UserDefaults.standard.set("", forKey: "LOGIN")
                          UserDefaults.standard.set("", forKey: "OFFICE_USER_ID")
                          
                           UserDefaults.standard.set("", forKey: "LAST_LOGGEDIN")
                          
                       
                        self.clickLoginView.isHidden = false
                                              self.clickProfileView.isHidden = true
               
               })
                      let cancel = UIAlertAction(title: "No", style: .default, handler: { action in
                      })
                      alert.addAction(ok)
                      alert.addAction(cancel)
                      DispatchQueue.main.async(execute: {
                          self.present(alert, animated: true)
                      })
                      
                      
    }
    
    @IBAction func clickChangePassword(_ sender: Any) {
        
        let ac = UIAlertController(title: "Change Password", message: nil, preferredStyle: .alert)
                   ac.addTextField() { newTextField in
                             newTextField.placeholder = "Old Password"
                       newTextField.isSecureTextEntry = true
                         }
               
               ac.addTextField() { newTextField in
                                    newTextField.placeholder = "New Password"
                              newTextField.isSecureTextEntry = true
                                }
               
               ac.addTextField() { newTextField in
                                    newTextField.placeholder = "Confirm New Password"
                              newTextField.isSecureTextEntry = true
                                }

                  let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
                      let answer = ac.textFields![0]
                      // do something interesting with "answer" here
                  }
               let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [unowned ac] _ in
                   
               }

                  ac.addAction(submitAction)
                ac.addAction(cancelAction)

                  present(ac, animated: true)
    }
    
    
    
    @IBOutlet weak var clickLoginView: UIView!
     @IBOutlet weak var clickProfileView: UIView!
    
    @IBAction func clickLoigin(_ sender: Any) {
        
    
                        
                       ProgressHUD.show()
                                         
                                                                   
                                              let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                                  
                                                                   var urlString = ""
                                                                   let parameters: [String: String] = [
                                                                     "api_key": "\(ConstantsURL.apikey)",
                                                                     
                                                                     
                                                                       
                                                                       
                                                                       ]
                                                                   
                                                                   
        urlString = "\(ConstantsURL.baseURL)&type=read&&object=user&action=login&password=\(txtPasswordNew.text!)&email=\(txtEmailNew.text!)"
                                                                        
                                                                   
                                                                   
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
                   
                  
                   
                   let signstatus = JSON?.value(forKeyPath: "response.success") as! Bool
                    
                    
                    let pk_i_id = "\(JSON?.value(forKeyPath: "response.pk_i_id") ?? "")"
                    
                    
                    UserDefaults.standard.set(pk_i_id, forKey: "USER_ID_VALUE")

                    if signstatus
                   {
                    UserDefaults.standard.set("YES", forKey: "LOGIN")
                    UserDefaults.standard.set("\(self.txtEmailNew.text!)", forKey: "U_EMAIL")
                    UserDefaults.standard.set("\(JSON?.value(forKeyPath: "block_id") ?? "")", forKey: "U_BLOCK_ID")
                                           
                                          self.clickLoginView.isHidden = true
                                           self.clickProfileView.isHidden = false

                    self.txtlblll.resignFirstResponder()
                    self.txtEmailNew.resignFirstResponder()
                    self.txtPasswordNew.resignFirstResponder()

                    self.txtlblll.text = "Welcome Back \(self.txtEmailNew.text!)"
                    
                    self.checkAdsinUserList()
                    self.checkUserPayment()
                                      ProgressHUD.dismiss()
                     
                    }
                  else
                   {
                   ProgressHUD.showError(JSON?.value(forKeyPath: "response.message") as! String)
                       
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
    
    func clickPurchase()
     {
                 
        ProgressHUD.show()
                                  
                                                            
             let userid = UserDefaults.standard.string(forKey: "USER_ID_VALUE")
                                                                                                           
                                                            var urlString = ""
                                                            let parameters: [String: String] = [
                                                              "api_key": "\(ConstantsURL.apikey)",

                                                                ]
        
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM-dd"
        
        let result = formatter.string(from: date)
        
        formatter.dateFormat = "yyyy"
        
        
        let resultYear = formatter.string(from: date)
        
        var year = Int(resultYear)!+1
        
        print("YEAR:\(year)")
        
    urlString = "\(ConstantsURL.baseURL)&type=update&object=plugin-osclass_pay&action=updateUserGroup&userId=\(userid!)&groupId=2&expire=\(year)-\(result)%2023:59:59"
                                                                 
                                                            
                                                            
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
            
           
            
            self.checkUserPayment()
            
            ProgressHUD.dismiss()
             
        }
        else
         {
           ProgressHUD.showError("Payment Failed")
           
         
        }
                                                                        
                                                                       
                                                                        
                                
                                break
                            case .failure(let error):
                                // SVProgressHUD.showError(withStatus: error.localizedDescription)
                             ProgressHUD.dismiss()
                                print(error.localizedDescription)
                            }
                                     
                       }
                                         
            }
    
    func checkUserPayment()
         {
             
            
                              
                                                        
         let userid = UserDefaults.standard.string(forKey: "USER_ID_VALUE")
                                                                                                       
                                                        var urlString = ""
                                                        let parameters: [String: String] = [
                                                          "api_key": "\(ConstantsURL.apikey)",
                                                          
                                                          
                                                            
                                                            
                                                            ]
urlString = "\(ConstantsURL.baseURL)&type=insert&object=plugin-osclass_pay&action=getUserGroup&userId=\(userid!)"
                                                             
                                                        
                                                        
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
        
       
        
      let JSON = "\((JSON as AnyObject).value(forKeyPath: "response")!)"

       print("JSON:\(JSON)")
      
      if JSON == "2"
      {
        print("Purchased")
        self.imgPayment.isHidden = false;
        self.btnPayment.isHidden = true;
        self.imgPayment.image = UIImage.init(named: "SuccessScreen.png")
        
        UserDefaults.standard.set("SUCCESS", forKey: "PAYMENT")
      }
      else
      {
        self.imgPayment.image = UIImage.init(named: "Paid_Membership.png")
         UserDefaults.standard.set("FAIL", forKey: "PAYMENT")
        
        self.imgPayment.isHidden = false;
               self.btnPayment.isHidden = false;
          print("not purchase")
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
    
    
    func checkAdsinUserList()
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
                        self.createList()
                       }
                       else
                       {
                           
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
    
    func createList()
         {
             
            
                              
                                                        
         let userid = UserDefaults.standard.string(forKey: "USER_ID_VALUE")
                                                                                                       
                                                        var urlString = ""
                                                        let parameters: [String: String] = [
                                                          "api_key": "\(ConstantsURL.apikey)",
                                                          
                                                          
                                                            
                                                            
                                                            ]
                                                        
urlString = "\(ConstantsURL.baseURL)&type=insert&object=plugin-favorite_items&action=insertList&name=rentLA_app\(userid!)&current=1&userId=\(userid!)&userLogged=1&notification=1"
                                                             
                                                        
                                                        
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
    
    @IBOutlet weak var txtlblll: UITextField!
    
    
    @IBAction func clickForgot(_ sender: Any) {
        
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerForgot") as? ViewControllerForgot
        {
           if let navigator = self.navigationController
            {
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
       
    }
    
    @IBAction func clickSignup(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSignup") as? ViewControllerSignup
                             {
                                if let navigator = self.navigationController
                                 {
                                     navigator.pushViewController(viewController, animated: true)
                                 }
                             }
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
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerHomeDetails") as? ViewControllerHomeDetails
                                              {
                                                  if let navigator = navigationController
                                                  {
                                                      navigator.pushViewController(viewController, animated: true)
                                                  }
                                              }
        
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
          
          
         if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerMyProfile") as? ViewControllerMyProfile
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
                return 400;
            }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
            {
                
                return 5
                
                
            }
            
            
               func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
               {
                   
                   let cell:SessionsTableViewCellFav = self.tblView.dequeueReusableCell(withIdentifier: "SessionsTableViewCellFav") as! SessionsTableViewCellFav
                   
                   
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
                   return cell as SessionsTableViewCellFav
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

