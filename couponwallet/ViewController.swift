//
//  ViewController.swift
//  couponwallet
//
//  Created by nick on 7/11/17.
//  Copyright © 2017 foxnick. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
//    @IBOutlet weak var pickStoreName: UIPickerView!
//    var stores:[String] = [String]()
    var barcodes: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func beginScanBarcode(_ sender: UIBarButtonItem) {
        AVCaptureSessionManager.checkAuthorizationStatusForCamera(grant: {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scanViewController")
            self.navigationController?.pushViewController(controller, animated: true)
        }){
            let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                UIApplication.shared.openURL(url!)
            })
            let con = UIAlertController(title: "权限未开启", message: "您未开启相机权限，点击确定跳转至系统设置开启", preferredStyle: UIAlertControllerStyle.alert)
            con.addAction(action)
            self.present(con, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.pickStoreName.delegate = self
//        self.pickStoreName.dataSource = self
//        stores = ["Coles", "Woolworths", "ALDI", "IGA"]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BarCodes")
        do {
            barcodes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return stores.count
//    }
    
    // The data to return for the row and component (column) that's being passed in
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return stores[row]
//    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var pickerLabel: UILabel? = (view as? UILabel)
//        if pickerLabel == nil {
//            pickerLabel = UILabel()
//            pickerLabel?.font = UIFont.systemFont(ofSize: 40)
//            pickerLabel?.textAlignment = .center
//        }
//        pickerLabel?.text = stores[row]
////        pickerLabel?.textColor = UIColor.blue
//        
//        return pickerLabel!
//    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let dbLog = barcodes.count
        print(dbLog)
        return barcodes.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let barcode = barcodes[indexPath.row]
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "couponcodedisplaycell", for: indexPath) as! CouponcodeDisplayCell
        let expireDate = barcode.value(forKey: "expiree_date") as? Date
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MMM dd, yyyy"
        let datestr = dformatter.string(from: expireDate!)
        cell.expiresDate.text = datestr
        cell.storeLogo.image = (appDelegate?.storeLogos[barcode.value(forKey: "store_name") as! String])!
        cell.barcodeImg.image = UIImage(data: barcode.value(forKey: "barcode") as! Data)
        cell.barcodeContent.text = barcode.value(forKey: "barcode_content") as? String
        
        
        let dbLog = barcode.value(forKeyPath: "barcode_content") as? String
        print(dbLog)
//        cell.textLabel?.text = barcode.value(forKeyPath: "barcode_content") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}
