//
//  UserProfileViewController.swift
//  bienestarDiana
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import UIKit
import Foundation
import SkyFloatingLabelTextField
import Alamofire
import UserNotifications

class UserProfileViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate  {
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]){
            (auth,error) in
            if auth {
                print("Notifications allowed")
            } else {
                print("Notifications denied")
            }
        }
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        UNUserNotificationCenter.current().delegate = self
    }
    
    // This will notify when something changes on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case userPasswordTF:
                    if(!DataHelpers.isValidPassword(text)) {
                        errorMessage = "Must contain 8 characters and 1 number"
                    }
                case userConfirmPassword:
                    if(!DataHelpers.isValidRepeatedPassword(text, userPasswordTF.text ?? "" )) {
                        errorMessage = "Passwords don't match"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    //Save button event
    @IBAction func saveButton(_ sender: Any) {
        
        let userPassword = userPasswordTF.text
        let repeatedPassword = userConfirmPassword.text
        
            //Validation of email and password, CAMBIAR ESTO A UN METODO QUE VALIDE TODO
            if ( DataHelpers.isValidPassword(userPassword!) ){
                newPassword(password: userPassword!)
                
            } else {
                
                self.present(DataHelpers.displayAlert(userMessage: "Not a valid password", alertType: 0), animated: true, completion: nil)
            }
        }
    func newPassword(password:String)  {
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/user/changePass")
        let user=User(password: password)
        
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
            ).response { response in
                if response.error == nil {
                    do{
                        let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                        /*if(responseData.code==1004) {
                         
                         
                         isWorking = true
                         completion(isWorking)
                         
                         }else{
                         self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                         isWorking = true
                         completion(isWorking)
                         }*/
                        
                    }catch{
                        print(error)
                        
                    }
                }else{
                    self.present(DataHelpers.displayAlert(userMessage:"Password changed!", alertType: 1), animated: true, completion: nil)
                    print("ENVIADA \(response.error)" ?? "nope")
                }
        }
        
    }
    
    @IBAction func notificationButton(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.subtitle = "This is a notification"
        content.body = "This is the body"
        content.sound = UNNotificationSound.default
        content.badge = 3
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request,withCompletionHandler: nil)
    }
}



