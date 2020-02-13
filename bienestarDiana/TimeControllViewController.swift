//
//  TimeControllViewController.swift
//  bienestarDiana
//
//  Created by alumnos on 12/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Foundation
import HGCircularSlider

class TimeControllViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var circularSlider: CircularSlider!
    

    
    var pickerData = ["Instagram", "Whatsapp", "Gmail", "Facebook", "Reloj", "Chrome"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
          setupSliders()
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
    
    
    @IBOutlet weak var minutesCircularSlider: CircularSlider!
    @IBOutlet weak var hoursCircularSlider: CircularSlider!
    

    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var AMPMLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSliders() {
        hoursCircularSlider.minimumValue = 0
        hoursCircularSlider.maximumValue = 12
        hoursCircularSlider.endPointValue = 6
        hoursCircularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        hoursCircularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        
        // minutes
        minutesCircularSlider.minimumValue = 0
        minutesCircularSlider.maximumValue = 60
        minutesCircularSlider.endPointValue = 35
        minutesCircularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        minutesCircularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        

    }
    
    @objc func updateHours() {
        var selectedHour = Int(hoursCircularSlider.endPointValue)
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        hoursLabel.text = String(format: "%02d", selectedHour)

    }
    
    @objc func adjustHours() {
        let selectedHour = round(hoursCircularSlider.endPointValue)
        hoursCircularSlider.endPointValue = selectedHour
        
 
    }
    
    @objc func updateMinutes() {
        var selectedMinute = Int(minutesCircularSlider.endPointValue)
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel.text = String(format: "%02d", selectedMinute)

    }
    
    @objc func adjustMinutes() {
        let selectedMinute = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedMinute
        updateMinutes()
    }
    
    @IBAction func switchBetweenAMAndPM(_ sender: UISegmentedControl) {
        AMPMLabel.text = sender.selectedSegmentIndex == 0 ? "AM" : "PM"
    }
}
