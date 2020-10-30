//
//  ViewController.swift
//  PRESTIGE
//
//  Created by NEHAPRANYA on 26/08/20.
//  Copyright © 2020 kmmedical. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewControllerPower: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickNewTest(_ sender: Any) {
        
        if lblSwitch.isOn
               {
               
               if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerLogin") as? ViewControllerLogin
                                 {
                                     if let navigator = navigationController
                                     {
                                         navigator.pushViewController(viewController, animated: true)
                                     }
                                 }
               }
               else
               {
                   ProgressHUD.showError("Please Make Agree")
               }
    }
    
    @IBOutlet weak var lblSwitch: UISwitch!
    
    
    @IBAction func clickAlreadyHave(_ sender: Any) {
        
        if lblSwitch.isOn
        {
        
        if let viewController = UIStoryboard(name: "\(UserDefaults.standard.string(forKey: "STORY_BOARD")!)", bundle: nil).instantiateViewController(withIdentifier: "ViewControllerOld") as? ViewControllerOld
                          {
                              if let navigator = navigationController
                              {
                                  navigator.pushViewController(viewController, animated: true)
                              }
                          }
        }
        else
        {
            ProgressHUD.showError("Please Agree our Terms")
        }
    }
    
    


}

