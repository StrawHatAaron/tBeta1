//
//  ViewController.swift
//  tBeta1
//
//  Created by Aaron Miller on 11/20/17.
//  Copyright © 2017 Aaron Miller. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
@IBOutlet weak var background: UIImageView!//nothing done with the background pic
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Core BLE
        var manager:CBCentralManager
        manager = CBCentralManager()
        centralManagerDidUpdateState(manager)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    struct UUID{
        let uuidString: String
        
        init(){
            self.uuidString = "f459f6de-560d-49cb-813a-79fd46ee5b3f"
        }
    }
//
//    struct CBCentralManager{
//        let CBCentralManagerDelegat: delegate
//        init() {
//            manager.delegate = self
//        }
//    }
    
    //Check the device bluetooth status.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth is connected")
        }
        else if central.state == .resetting{
            print("Bluetooth is resetting")
        }
        else if central.state == .unauthorized{
            print("Bluetooth is unauthorized")
        }
        else if central.state == .unknown{
            print("Bluetooth is unkown state")
        }
        else if central.state == .unsupported{
            print("Bluetooth is unsupported")
        }
        else if central.state == .poweredOff{
            print("Bluetooth is not Connected.Please Enable it")
        }
    }
}

    
