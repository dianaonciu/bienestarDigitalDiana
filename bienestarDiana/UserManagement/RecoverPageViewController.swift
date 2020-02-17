//
//  RecoverPageViewController.swift
//  bienestarDiana
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//


import UIKit
import SkyFloatingLabelTextField
import Foundation
import Alamofire
class RecoverPageViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var userEmail: SkyFloatingLabelTextField!
    
    
    
    @IBAction func recoverButton(_ sender: Any) {
        let userRecoverEmail = userEmail.text;
        
        if(userRecoverEmail!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            return;
            
        } else {
            if let email = userRecoverEmail {
                if(DataHelpers.isValidEmail(email)){
                    sendEmail(email: email)
                }
            }
            else{
                self.present(DataHelpers.displayAlert(userMessage: "Invalid email", alertType: 0), animated: true, completion: nil)
                
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        userEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        super.viewDidLoad()
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case userEmail:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
                default:
                    errorMessage = ""
                }
                
                floatingLabelTextField.errorMessage = errorMessage
                
            }
        }
    }
    
    func sendEmail(email:String)  {
        let url = URL(string:"http://0.0.0.0:8888/petit-api/public/api/user/password/reset")
        AF.request(url!,
                   method: .post,
                   parameters:["email": email],
                   encoder: JSONParameterEncoder.default
            
            ).response { response in
                if response.error == nil {
                do{
                    let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                    
                }catch{
                    print(error)
                }
                }else{
                    print("ERROR \(response.error)" ?? "nope")
                   self.present(DataHelpers.displayAlert(userMessage:"Email sent!", alertType: 1), animated: true, completion: nil)
                }
        }
        
    }
    @IBAction func buttonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
