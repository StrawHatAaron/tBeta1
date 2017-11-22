//
//  ViewController.swift
//  tBeta1
//
//  Created by Aaron Miller on 11/20/17.
//  Copyright © 2017 Aaron Miller. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var buttonSearch: UIButton!
    
    var managerC:CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSearch.layer.cornerRadius = 10
        buttonSearch.clipsToBounds = true
        managerC = CBCentralManager(delegate: self, queue: nil)
        centralManagerDidUpdateState(managerC)
    }

    //Check the device bluetooth status.
    func centralManagerDidUpdateState(_ central: CBCentralManager!) {
        switch (central.state) {
        case .poweredOff:
            print("powered off")
        case .resetting:
            print("resetting")
        case .poweredOn:
            print("powered on")
            //so if its powered on then we need to scan
        case .unauthorized:
            print("unauth")
        case .unknown:
            print("unkown state this what we have been getting /:")
        case .unsupported:
            print("unsupported")
        default:
            print("weird")
        }
    }

    //allows for a 16-bit 32-bit or 128-bit UUID
    //defined in the Bluetooth 4.0 specification, Volume 3, Part F, Section 3.2.1.
    struct CBUUID{
        let uuidString: String
        var uuidData: Data
        init(stringID: String, intID: Data){
            self.uuidString = stringID
            self.uuidData = intID
        }
    }
    
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?,options: [String : Any]? = nil){}//is it even doing anything

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
