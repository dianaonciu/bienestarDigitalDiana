//
//  AppList.swift
//  Collection
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class AppList: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var data: [DataModel] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        
        data = DataHelpers.parseCsvData()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "AppsCellID"
        
        let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AppsCollectionViewCell
        
        let appsTime = DataHelpers.getAppDates(dataModel: data, app: data[indexPath.row].App)
        
        let totalMinutes = DataHelpers.totalMinutesByApp(appDates: appsTime)
        
        let totalMinutesString = String(totalMinutes)
        
        let name = data[indexPath.row].App
       
        cell.itemLabel.text = name
        
        cell.itemLabelTime.text = " \(totalMinutesString) mins"
        
        switch (name){
        case ("Instagram"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "instagram")
            break;
        case ("Chrome"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "chrome")
            break;
        case ("Whatsapp"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "whatsapp")
            break;
        case ("Facebook"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "facebook")
            break;
        case ("Reloj"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "clock")
            break;
        case ("Gmail"):
            cell.itemImage.image =  UIImage.init(imageLiteralResourceName: "gmail")
            break;
        default:
            "afsa"
        }
        
        
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? AppsCollectionViewCell)
        let indexPath = self.myCollectionView.indexPath(for: item!)
        let name = data[indexPath!.row].App

        let appsTime = DataHelpers.getAppDates(dataModel: data, app: name)
        
        let totalMinutes = DataHelpers.totalMinutesByApp(appDates: appsTime)
        
        let totalMinutesString = String(totalMinutes)
        
        let detailVC = segue.destination as! DetailViewController
        detailVC.detailName = name
        detailVC.totalTimeApp = "Total minutes:  \(totalMinutesString)"
    }
    
   
    
}
