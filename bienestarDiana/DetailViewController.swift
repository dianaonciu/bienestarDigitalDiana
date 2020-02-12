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
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var totalTime: UILabel!
    
    var detailName: String?
    var totalTimeApp: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //detailImage.image = UIImage.init(imageLiteralResourceName: detailName!)

        appName.text = detailName
        
        totalTime.text = totalTimeApp
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        data = DataHelpers.parseCsvData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "cellDates"
        
        let dates = data[indexPath.row].Date
        
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AppsTableViewCell
        
        cell.labelDates.text = dates
        
        return cell
        
    }
    
}
