//
//  ViewController.swift
//  tBeta1
//
//  Created by Aaron Miller on 11/20/17.
//  Copyright © 2017 Aaron Miller. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate  {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var buttonSearch: UIButton!
    
    //Do I need a Centeral for both devices
    var managerC:CBCentralManager!
    var CBP:CBPeripheral!
    var managerP:CBPeripheralManager!
    var managerPD:CBPeripheralManagerDelegate!
    
    var size:Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let TX:String = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
        let RX:String = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
        //CBP = 
        managerC = CBCentralManager(delegate: self, queue: nil)
        //peripheral(CBPeripheral: CBP, didDiscoverServices error: Error?)
        //size = Data.init();
        //var uuid = CBUUID.init(stringID: "a432587e-486e-4c16-8f3b-c98da6ad8aa0", intID:size)
        //centralManagerDidUpdateState(managerC)
        //        var tCheckID : [CBUUID] = [CBUUID.init(stringID: "a432587e-486e-4c16-8f3b-c98da6ad8aa0"), CBUUID.init(stringID: "6E400003-B5A3-F393-E0A9-E50E24DCCA9E")]
        
        buttonSearch.layer.cornerRadius = 10
        buttonSearch.clipsToBounds = true
    }

   private func centralManager(_ central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral!,
                        advertisementData: [NSObject : AnyObject]!, RSSI:NSNumber!) {
        print("Description of name: \(peripheral.name as String?)")
        if(peripheral.name=="tCheck"){
            self.CBP = peripheral
            self.CBP.delegate = self
            managerC.stopScan()
            managerC.connect(self.CBP, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate=self
        peripheral.discoverServices(nil)
        //peripheral.discoverServices(tCheckID)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let servicePerihperal = peripheral.services as [CBService]!{
            for service in servicePerihperal{
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characterArray = service.characteristics as [CBCharacteristic]!{
            for cc in characterArray{
                if(cc.uuid.uuidString=="6E400003-B5A3-F393-E0A9-E50E24DCCA9E"){
                    print("6E400003-B5A3-F393-E0A9-E50E24DCCA9E  has been found")
                    peripheral.readValue(for: cc)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if(characteristic.uuid.uuidString=="6E400003-B5A3-F393-E0A9-E50E24DCCA9E"){
            let value = characteristic.value!.withUnsafeBytes { (pointer: UnsafePointer<Int>) -> Int in
                return pointer.pointee
            }
            print("Steps: \(value)")
        }
    }
    
    //Check the device bluetooth status.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case .poweredOff:
            print("powered off")
        case .poweredOn:
            print("powered on")
            centralManager(central, didConnect: self.CBP)
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
        init(stringID: String){
            self.uuidString = stringID
        }
    }
    
//    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?,options: [String : Any]? = nil){}//is it even doing anything
//    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> [CBPeripheral]{}
//    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> [CBPeripheral]{}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
