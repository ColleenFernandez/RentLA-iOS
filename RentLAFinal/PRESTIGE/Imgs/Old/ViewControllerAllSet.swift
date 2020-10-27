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
import SwiftyGif
import Alamofire


class ViewControllerAllSet: UIViewController {
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    var enteredOtp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        do {
         let gif = try UIImage(gifName: "gif1.gif")
          self.imgView.setGifImage(gif, loopCount: -1) // Will loop foreve
        } catch {
            print(error)
        }
        
       
        let delayTime = DispatchTime.now() + 3.0
        print("one")
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
           /*
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerSlip") as? ViewControllerSlip
            {
                if let navigator = self.navigationController
                {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
            */
        })
        
    }
    
    
    
    @IBAction func clickNewTest(_ sender: Any) {
        
       
            if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerResults") as? ViewControllerResults
            {
                if let navigator = self.navigationController
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

