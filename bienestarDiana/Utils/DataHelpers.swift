//
//  DataHelpers.swift
//  bienestarDiana
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Foundation
import UIKit
//Displays an alert with a message depending on the string passed through parameters
class DataHelpers{
    
    
    
    static var path = URL(fileURLWithPath: "/Users/alumnos/Desktop/usage.csv")
   
    static func loadFile() {
        
        do {
            
            let texto = try String(contentsOf: path, encoding: .utf8)
            
            print(JSONObjectFromTSV(tsvInputString: texto, columnNames: ["Date","App","Event","Latitude","Longitude"]))
            
            
        } catch {
            
            print("Error al leer desde fichero")
            
        }
        
        
        
    }
    
    
    
    static func parseCsvData ()-> [DataModel] {
        var texto:String = " "
        do {
            
             texto = try String(contentsOf: path, encoding: .utf8)
            
            print(JSONObjectFromTSV(tsvInputString: texto, columnNames: ["Date","App","Event","Latitude","Longitude"]))
            
            
        } catch {
            
            print("Error al leer desde fichero")
            
        }
        var result: [DataModel] = []
        var rows = texto.components(separatedBy: "\n")
        rows.remove(at:0)
        for row in rows{
            let column = row.components(separatedBy: ",")
            let usage=DataModel(Date: column[0], App: column[1], Event: column[2], Latitude: Double(column[3])!, Longitude: Double(column[4])!)
            result.append(usage)
        }
        
        return result
    }
    
    static func JSONObjectFromTSV(tsvInputString:String, columnNames optionalColumnNames:[String]? = nil) -> Array<NSDictionary>
        
    {
        
        let lines = tsvInputString.components(separatedBy: "\n")
        
        guard lines.isEmpty == false else { return [] }
        
        let columnNames = optionalColumnNames ?? lines[0].components(separatedBy: ",")
        
        var lineIndex = (optionalColumnNames != nil) ? 0 : 1
        
        let columnCount = columnNames.count
        
        var result = Array<NSDictionary>()
        
        
        
        for line in lines[lineIndex ..< lines.count] {
            
            let fieldValues = line.components(separatedBy: ",")
            
            if fieldValues.count != columnCount {
                
                
            }
                
            else
                
            {
                
                result.append(NSDictionary(objects: fieldValues, forKeys: columnNames as [NSCopying]))
                
            }
            
            lineIndex = lineIndex + 1
            
        }
        
        return result
        
    }
    
    static func getAppDates(dataModel:[DataModel] , app: String)-> Array<String>  {
        
        var appDates = [String]()
        
        for i in dataModel{
            
            if(i.App == app){
                
                appDates.append(i.Date)
     
            }
            
        }
        
         return appDates
        
    }
    
    static func totalMinutesByApp(appDates:[String]) -> Double {
        
       var arraySeconds = [Double]()
        
       let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: " en_US_POSIX")
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        for j in appDates{
            
           let date = dateFormatter.date(from: j)
            
           let epoch = date?.timeIntervalSince1970
        
            arraySeconds.append(epoch!)
            
         }
        
        var arrayOpen = [Double]()
        
        var arrayClose = [Double]()
      
        for i in 0..<arraySeconds.count{
            
            if i % 2 == 0 {
                
                arrayOpen.append(arraySeconds[i])
                
            }else{
                
                arrayClose.append(arraySeconds[i])
                
            }
            
        }
    
        var arrayResta = [Double]()
        
        var resta1 : Double
        
        for j in 0..<arrayClose.count{
            
            resta1 = arrayClose[j] - arrayOpen[j]
            
            arrayResta.append(resta1)
            
        }
        
        
        var totalSeconds : Double = arrayResta.reduce(0, +)
        
        var totalMinutes = (totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        
        let totalMinutesRounded = Double(round(100*totalMinutes)/100)
        
   
        print("Total de minutos  \(totalMinutesRounded)")
        
        return totalMinutesRounded
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    static func displayAlert(userMessage:String, alertType: Int)->UIAlertController{
        let alertTitle: String
        
        if (alertType == 0) {
            alertTitle = "There was an error!"
        } else {
            alertTitle = "Nice!"
        }
        
        let alert = UIAlertController(title: alertTitle, message: userMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alert
        //       self.present(alert, animated: true, completion: nil)
        
    }
    
    //
    static func isUsernameValid(_ username: String) -> Bool {
        return true
    }
    
    //
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    //
    static func isValidRepeatedPassword(_ repeatedPassword: String , _ userPassword : String) -> Bool {
        return userPassword == repeatedPassword
    }
    
   
}
