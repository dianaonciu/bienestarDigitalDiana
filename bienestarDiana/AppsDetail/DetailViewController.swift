//
//  DetailViewController.swift
//  bienestarDiana
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [DataModel] = []
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    var detailName: String?
    
    var filteredData: [DataModel] = []
    
    var totalTimeApp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        appName.text = detailName
        
        totalTime.text = totalTimeApp
        
        data = DataHelpers.parseCsvData()
        
        filteredData = data.filter({$0.App == detailName})
        print(filteredData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let identifier = "cellDates"
        
        let dates = filteredData[indexPath.row].Date
        
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppsTableViewCell
        

            cell.labelDates.text = dates
        
        
        return cell
        
    }
    
}
