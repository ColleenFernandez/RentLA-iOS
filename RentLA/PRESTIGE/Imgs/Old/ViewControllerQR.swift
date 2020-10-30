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
import QRScanner
import MTBBarcodeScanner

class ViewControllerQR: UIViewController {
    
    @IBOutlet var previewView: UIView!
    var scanner: MTBBarcodeScanner?
    
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // scanner = MTBBarcodeScanner(metadataObjectTypes: ["AVMetadataObjectTypeQRCode"], previewView: self.previewView)

         scanner = MTBBarcodeScanner(metadataObjectTypes: [AVMetadataObject.ObjectType.qr.rawValue], previewView: previewView)

        
        let delayTime = DispatchTime.now() + 3.0
        print("one")
        /*
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
           
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAllSet") as? ViewControllerAllSet
                  {
                    if let navigator = self.navigationController
                      {
                          navigator.pushViewController(viewController, animated: true)
                      }
                  }
                      
            
        })
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var tag = ""
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                print("Found code: \(stringValue)")
                                
                                if tag == ""
                                {
                                    tag = stringValue;
                                self.signinProcessNew(value: stringValue)

                                }
                                self.scanner!.stopScanning()
                                               
                                
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                
                self.signinProcessNew(value: "1")
                
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
        
    }
    
    
    func signinProcessNew(value:String)
                         {
                             
                            

                            
                            ProgressHUD.show()
                                              
                                                     let token = UserDefaults.standard.string(forKey: "PATIENT_ID")
                                                                        
                                                   let deviceid = UserDefaults.standard.string(forKey: "DEVICE_ID")
                                                                                                                       
                                                                        var urlString = ""
                                                                        let parameters: [String: String] = [
                                                                          "api_key": "\(ConstantsURL.apikey)",
                                                                            "action": "createTestRequest",
                                                                            "lab_id": "\(value)",
                                                                          "patient_unique_id": "\(token!)",
                                                                           "device_id": "\(deviceid!)",
                                                                          
                                                                            
                                                                            
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
                        
                      if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAllSet") as? ViewControllerAllSet
                                                                     {
                                                                       if let navigator = self.navigationController
                                                                         {
                                                                             navigator.pushViewController(viewController, animated: true)
                                                                         }
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        
        super.viewWillDisappear(animated)
    }
    
    @IBAction func clickNewTest(_ sender: Any) {
        
      let qr = QRScannerViewController()
      qr.squareView.lineColor = UIColor.red
      let item = UIBarButtonItem(title: "Photo album", style: UIBarButtonItem.Style.plain, target: qr, action: #selector(QRScannerViewController.openAlbum))
      qr.navigationItem.rightBarButtonItem = item
      qr.delegate = self
     
          present(qr, animated: true, completion: nil)
     
      
        
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

extension ViewControllerQR:QRScannerDelegate{
    func qrScannerDidFail(scanner: QRScannerViewController, error: QRScannerError) {
        let alert = UIAlertController(title: "Fail!", message: String(describing: error), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel, handler: nil))
        scanner.present(alert, animated: true, completion: nil)
    }
    
    func qrScannerDidSuccess(scanner: QRScannerViewController, result: String) {
        print("success",result)
        
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerAllSet") as? ViewControllerAllSet
                        {
                          if let navigator = self.navigationController
                            {
                                navigator.pushViewController(viewController, animated: true)
                            }
                        }
                            
        
        
    }
}
