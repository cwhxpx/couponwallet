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
    
    //添加条形码下方文字
    class func addBarcodeText(barcodeImg:UIImage, codeContent:String) ->UIImage? {
        let size = CGSize(width: barcodeImg.size.width, height: barcodeImg.size.height+30)
        
        UIGraphicsBeginImageContextWithOptions (size, false , 0.0 );
        
        barcodeImg.draw(at: CGPoint.zero)
        
        // 获得一个位图图形上下文
        let context = UIGraphicsGetCurrentContext ();
        
        context!.drawPath(using: .stroke);
        //绘制文字
        let barText:String = codeContent
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineBreakMode = .byWordWrapping
        textStyle.alignment = .center
        
        barText.draw(
            in: CGRect(x:0, y:barcodeImg.size.height-2, width:size.width, height:30),
            withAttributes: [NSFontAttributeName:UIFont.systemFont(ofSize:6.0),
                             NSBackgroundColorAttributeName:UIColor.clear,
                             NSParagraphStyleAttributeName:textStyle]
        )
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
