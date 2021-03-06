//
//  RegisterPageViewController.swift
//  bienestarDiana
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Foundation
import SkyFloatingLabelTextField
import Alamofire

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userEmailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userPasswordTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var userConfirmPassword: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usernameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userPasswordTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
    }
    
    // This will notify us when something has changed on the textfield
    @objc func textFieldDidChange(_ textfield: UITextField) {
        
        if let text = textfield.text {
            if let floatingLabelTextField = textfield as? SkyFloatingLabelTextField {
                var errorMessage=""
                switch textfield {
                    
                case usernameTF:
                    if(text.count < 3) {
                        errorMessage = "Invalid username"
                    }
                case userEmailTF:
                    if(!DataHelpers.isValidEmail(text)) {
                        errorMessage = "Invalid email"
                    }
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
    
    //Sign up button event
    @IBAction func signUpButton(_ sender: Any) {
        
        let userEmail = userEmailTF.text
        let userPassword = userPasswordTF.text
        let userName = usernameTF.text
        let repeatedPassword = userConfirmPassword.text
        
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userName!.isEmpty || repeatedPassword!.isEmpty)
        {
            // Alert message
            self.present(DataHelpers.displayAlert(userMessage: "All fields are required", alertType: 0), animated: true, completion: nil)
            
            return;
            
        } else {
            
            //Validation of email and password, CAMBIAR ESTO A UN METODO QUE VALIDE TODO
            if ( DataHelpers.isValidPassword(userPassword!) && DataHelpers.isValidEmail(userEmail!) && DataHelpers.isUsernameValid(userName!)){
                
                //Validation of passwords
                createUser(email: userEmail!,password: userPassword!,userName: userName!)
                
            } else {
                
                self.present(DataHelpers.displayAlert(userMessage: "You need to fix that first", alertType: 0), animated: true, completion: nil)
            }
        }
        
    }
    func createUser(email:String,password:String,userName:String)  {
        let url = URL(string:"http://0.0.0.0:8888/bienestar/public/api/user")
        let user=User( email: email, password: password, userName: userName)
        
        AF.request(url!,
                   method: .post,
                   parameters:user,
                   encoder: JSONParameterEncoder.default
            
            ).response { response in
                print(response);
                if response.error == nil {
                do{
                    let responseData:RegisterResponse = try JSONDecoder().decode(RegisterResponse.self, from: response.data!)
                    /*if(responseData.code==200) {
                        
                        self.present(DataHelpers.displayAlert(userMessage:"Registered!", alertType: 1), animated: true, completion: nil)
                    }else{
                        self.present(DataHelpers.displayAlert(userMessage:responseData.errorMsg ?? "", alertType: 0), animated: true, completion: nil)
                    }*/
                    
                }catch{
                    print(error)
                    
                }
                }else{
                    print("ERROR \(response.error)" ?? "nope")
                    self.segueLogin()
                }
        }
        
    }
    
    func segueLogin()  {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
}
