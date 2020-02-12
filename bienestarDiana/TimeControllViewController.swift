//
//  TimeControllViewController.swift
//  bienestarDiana
//
//  Created by alumnos on 12/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Foundation

class TimeControllViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData = ["Instagram", "Whatsapp", "Gmail", "Facebook", "Reloj", "Chrome"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
    }
}
