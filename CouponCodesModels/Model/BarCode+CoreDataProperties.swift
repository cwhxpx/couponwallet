//
//  BarCodes+CoreDataProperties.swift
//  couponwallet
//
//  Created by nick on 15/11/17.
//  Copyright © 2017 foxnick. All rights reserved.
//
//

import Foundation
import CoreData


extension BarCode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BarCodes> {
        return NSFetchRequest<BarCodes>(entityName: "BarCodes")
    }

    @NSManaged public var store_name: String?
    @NSManaged public var barcode_content: String?
    @NSManaged public var expiree_date: NSDate?
    @NSManaged public var receipt_picture: NSData?

}
