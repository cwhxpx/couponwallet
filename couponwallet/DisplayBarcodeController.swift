//
//  DisplayBarcodeController.swift
//
//  Created by nick on 2017/11/09.
//  Copyright © 2017年. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public var result: String!
    public var type: String!
    private var couponcode: UIImage!
    
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var pickExpiredate: UIDatePicker!
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var pickStore: UIPickerView!
    @IBOutlet weak var storeName: UILabel!
    
    var stores: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //generating a bar code
        couponcode = UIImage.makeBarcode(codeType: type, codeContent: result)
        QRImage.image = UIImage.addBarcodeText(barcodeImg: couponcode, codeContent: result)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let keys = appDelegate?.storeLogos.keys {
            stores = Array(keys)
        }
        
        self.pickStore.delegate = self
        self.pickStore.dataSource = self
        
        pickExpiredate.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let date = pickExpiredate.date
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MMM dd,   yyyy"
        let datestr = dformatter.string(from: date)
        expireDate.text = datestr
        
        let pickedStore = stores[pickStore.selectedRow(inComponent: 0)]
        storeName.text = pickedStore
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.save()
    }
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "BarCodes", in: managedContext)!
        
        let barcode =
            NSManagedObject(entity: entity, insertInto: managedContext)
        
        barcode.setValue(self.result, forKeyPath: "barcode_content")
        barcode.setValue(UIImagePNGRepresentation(self.couponcode), forKeyPath: "barcode")
        let pickedStore = stores[pickStore.selectedRow(inComponent: 0)]
        
        barcode.setValue(pickedStore, forKeyPath: "store_name")
        
        barcode.setValue(pickExpiredate.date, forKey: "expiree_date")
        
        
        do {
            try managedContext.save()
//            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //functions from protocol pickview delegate and datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.storeName.text = self.stores[row]
        }
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        let date = sender.date
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MMM dd, yyyy"
        let datestr = dformatter.string(from: date)
        expireDate.text = datestr
    }
}
