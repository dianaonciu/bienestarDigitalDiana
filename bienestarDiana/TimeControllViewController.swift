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
import Alamofire

class TimeControllViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
    @IBOutlet weak var pickerView: UIPickerView!
   
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
    
    @IBOutlet weak var minutesCircularSlider2: CircularSlider!
    @IBOutlet weak var hoursCircularSlider2: CircularSlider!
    
    @IBOutlet weak var minutesCircularSlider3: CircularSlider!
    @IBOutlet weak var hoursCircularSlider3: CircularSlider!
    
    var control: [Control] = []
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var hoursLabel2: UILabel!
    @IBOutlet weak var minutesLabel2: UILabel!
    
    @IBOutlet weak var hoursLabel3: UILabel!
    @IBOutlet weak var minutesLabel3: UILabel!
    
    
    @IBOutlet weak var AMPMLabel: UILabel!
    
    
    @IBOutlet weak var AMPMLabel2: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSliders() {
        hoursCircularSlider.minimumValue = 0
        hoursCircularSlider.maximumValue = 24
        hoursCircularSlider.endPointValue = 0
        hoursCircularSlider.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        hoursCircularSlider.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        
        hoursCircularSlider2.minimumValue = 0
        hoursCircularSlider2.maximumValue = 12
        hoursCircularSlider2.endPointValue = 6
        hoursCircularSlider2.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        hoursCircularSlider2.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        
        hoursCircularSlider3.minimumValue = 0
        hoursCircularSlider3.maximumValue = 12
        hoursCircularSlider3.endPointValue = 6
        hoursCircularSlider3.addTarget(self, action: #selector(updateHours), for: .valueChanged)
        hoursCircularSlider3.addTarget(self, action: #selector(adjustHours), for: .editingDidEnd)
        
        // minutes
        minutesCircularSlider.minimumValue = 0
        minutesCircularSlider.maximumValue = 60
        minutesCircularSlider.endPointValue = 0
        minutesCircularSlider.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        minutesCircularSlider.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        
        minutesCircularSlider2.minimumValue = 0
        minutesCircularSlider2.maximumValue = 60
        minutesCircularSlider2.endPointValue = 0
        minutesCircularSlider2.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        minutesCircularSlider2.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        
        minutesCircularSlider3.minimumValue = 0
        minutesCircularSlider3.maximumValue = 60
        minutesCircularSlider3.endPointValue = 0
        minutesCircularSlider3.addTarget(self, action: #selector(updateMinutes), for: .valueChanged)
        minutesCircularSlider3.addTarget(self, action: #selector(adjustMinutes), for: .editingDidEnd)
        
      
        

    }
    
    @objc func updateHours() {
        var selectedHour = Int(hoursCircularSlider.endPointValue)
        selectedHour = (selectedHour == 0 ? 12 : selectedHour)
        hoursLabel.text = String(format: "%02d", selectedHour)
        
        var selectedHour2 = Int(hoursCircularSlider2.endPointValue)
        selectedHour2 = (selectedHour2 == 0 ? 12 : selectedHour2)
        hoursLabel2.text = String(format: "%02d", selectedHour2)
        
        
        var selectedHour3 = Int(hoursCircularSlider3.endPointValue)
        selectedHour3 = (selectedHour3 == 0 ? 12 : selectedHour3)
        hoursLabel3.text = String(format: "%02d", selectedHour3)

    }
    
    @objc func adjustHours() {
        let selectedHour = round(hoursCircularSlider.endPointValue)
        hoursCircularSlider.endPointValue = selectedHour
        
        let selectedHour2 = round(hoursCircularSlider2.endPointValue)
        hoursCircularSlider2.endPointValue = selectedHour2
        
        let selectedHour3 = round(hoursCircularSlider3.endPointValue)
        hoursCircularSlider3.endPointValue = selectedHour3
        
        updateHours()
    }
    
    @objc func updateMinutes() {
        var selectedMinute = Int(minutesCircularSlider.endPointValue)
        selectedMinute = (selectedMinute == 60 ? 0 : selectedMinute)
        minutesLabel.text = String(format: "%02d", selectedMinute)
        
        var selectedMinute2 = Int(minutesCircularSlider2.endPointValue)
        selectedMinute2 = (selectedMinute2 == 60 ? 0 : selectedMinute2)
        minutesLabel2.text = String(format: "%02d", selectedMinute2)
        
        var selectedMinute3 = Int(minutesCircularSlider3.endPointValue)
        selectedMinute3 = (selectedMinute3 == 60 ? 0 : selectedMinute3)
        minutesLabel3.text = String(format: "%02d", selectedMinute3)

    }
    
    @objc func adjustMinutes() {
        let selectedMinute = round(minutesCircularSlider.endPointValue)
        minutesCircularSlider.endPointValue = selectedMinute
     
        
        let selectedMinute2 = round(minutesCircularSlider2.endPointValue)
        minutesCircularSlider2.endPointValue = selectedMinute2
   
        
        let selectedMinute3 = round(minutesCircularSlider3.endPointValue)
        minutesCircularSlider3.endPointValue = selectedMinute3
        updateMinutes()
    }
    
    @IBAction func switchBetweenAMAndPM(_ sender: UISegmentedControl) {
        AMPMLabel.text = sender.selectedSegmentIndex == 0 ? "AM" : "PM"
    }
    @IBAction func switchBetweenAMAndPM2(_ sender: UISegmentedControl) {
        AMPMLabel2.text = sender.selectedSegmentIndex == 0 ? "AM" : "PM"
    }
    
    
    
    @IBAction func saveData(_ sender: Any) {
        
        //let maxTime = hoursLabel.text
        
        
    }
    
    
    
    func createControl(app:String,maxTime:String,startHour:String, endHour: String)  {
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/control")
        let control=Control( app: app, maxTime: maxTime, startHour: startHour, endHour: endHour)
        
        AF.request(url!,
                   method: .post,
                   parameters:control,
                   encoder: JSONParameterEncoder.default
            
            ).response { response in
                do{
                    let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                    if(responseData.code==200) {
                        self.present(DataHelpers.displayAlert(userMessage:"Registered!", alertType: 1), animated: true, completion: nil)
                    }else{
                        self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                    }
                    
                }catch{
                    print(error)
                    
                }
        }
        
    }
    
}
