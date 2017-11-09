//
//  DisplayBarcodeController.swift
//
//  Created by nick on 2017/11/09.
//  Copyright © 2017年. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    public var result: String!
    public var type: String!
    
    @IBOutlet weak var QRImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //generating a bar code
        if let barcodeImg = UIImage.makeBarcode(codeType: type, codeContent: result) {
            QRImage.image = UIImage.addBarcodeText(barcodeImg: barcodeImg, codeContent: result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
