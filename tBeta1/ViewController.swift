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
    
        //Core BLE
        //peripherals
        var peripheralDelegateName: String
        var peripheralDelegate: CBPeripheralDelegate
        var peripheral:CBPeripheral
        //managers
        var managerCentralDelegate:CBCentralManagerDelegate
        var managerCentral:CBCentralManager
        managerCentral = CBCentralManager()
        //CBUUID array
        var uuidStr = "16107de1-46b4-4a21-856b-fe1c737da2fe"
        var uuidData = Data.init(count: 8)
        var uuid = CBUUID.init(stringID: uuidStr, intID: uuidData)
        
        
        centralManagerDidUpdateState(managerCentral)
       //LEFT OFF HERE. Can't scan yet anyways so it's a good place to stop
       // scanForPeripherals(withServices serviceUUIDs: [uuid]?)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            print("Bluetooth is unkown state")//ended in an unknown state. Check Simulator settings
        }
        else if central.state == .unsupported{
            print("Bluetooth is unsupported")
        }
        else if central.state == .poweredOff{
            print("Bluetooth is not Connected.Please Enable it")
        }
    }
    
    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?,options: [String : Any]? = nil){}//is it even doing anything
}

    
