//
//  CouponcodeDisplayCell.swift
//  couponwallet
//
//  Created by nick on 16/11/17.
//  Copyright © 2017 foxnick. All rights reserved.
//

import Foundation
import UIKit


class CouponcodeDisplayCell: UITableViewCell {
    
    @IBOutlet weak var expiresDate: UILabel!
    @IBOutlet weak var barcodeContent: UILabel!
    @IBOutlet weak var storeLogo: UIImageView!
    @IBOutlet weak var barcodeImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
