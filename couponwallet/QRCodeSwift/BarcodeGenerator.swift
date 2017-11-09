//
//  BarcodeGenerator.swift
//
//
//  Created by nick on 2017/11/09.
//  Copyright © 2017年 zzy. All rights reserved.
//

import RSBarcodes_Swift
import AVFoundation
extension UIImage {
    
    // make a bar code(1D and 2D bar code)
    // much easier than native API from iOS, which supports only two type bar code as code128 and PDF147
    class func makeBarcode(codeType: String, codeContent: String) -> UIImage? {
        return RSUnifiedCodeGenerator.shared.generateCode(
            codeContent,
            machineReadableCodeObjectType: codeType)
    }
}
