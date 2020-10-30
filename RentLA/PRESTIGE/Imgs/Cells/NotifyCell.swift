//
//  SessionsTableViewCell.swift
//  PadlockBrowser
//
//  Created by SYZYGY on 28/12/16.
//  Copyright © 2016 Prem Kumar. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD


class NotifyCell: UITableViewCell {
    
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var txtResults: UILabel!
    
    @IBOutlet weak var txtDes: UITextView!
    
    
    @IBOutlet weak var lblPName: UILabel!
    
    @IBOutlet weak var lblPAddress: UILabel!
    
    @IBOutlet weak var lblPclient: UILabel!
    
    @IBOutlet weak var lblPEmail: UILabel!
    
    @IBOutlet weak var lblPphone: UILabel!
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var studentsLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    
    @IBOutlet weak var lblWorkTime: UILabel!
    @IBOutlet weak var lblSignout: UILabel!
    @IBOutlet weak var lblSignin: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    
    
    
    @IBOutlet weak var imageObj: UIImageView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var desLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var btnCmd: UIButton!
    
    @IBOutlet weak var lblCommends: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var btnTag: UIButton!
    
    @IBOutlet weak var iblLikes: UILabel!
    
    @IBOutlet weak var btnCommend: UIButton!
    
    @IBOutlet weak var btnHeart: UIButton!
    
    
    @IBOutlet weak var btnProfile: UIButton!
    
    
    @IBOutlet weak var btnMenu: UIButton!
    
    
    @IBOutlet weak var imgLike: UIImageView!
    
    
    @IBOutlet weak var imgTag: UIImageView!
    
    
    @IBOutlet weak var imgPlay: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
