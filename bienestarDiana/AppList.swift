//
//  AppList.swift
//  Collection
//
//  Created by alumnos on 10/02/2020.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class AppList: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var datos = ["chrome", "clock", "facebook", "gmail", "chrome", "instagram", "whatsapp"]
    
    var data: [DataModel] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        
        DataHelpers.loadFile()
        print(DataHelpers.parseCsvData())
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "AppsCellID"
        let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AppsCollectionViewCell
        let title = datos[indexPath.row]
        
        cell.itemImage.image =  UIImage.init(imageLiteralResourceName: title)
        cell.itemLabel.text = title
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = (sender as? AppsCollectionViewCell)
        let indexPath = self.myCollectionView.indexPath(for: item!)
        let title = datos[indexPath!.row]
        let detailVC = segue.destination as! DetailViewController
        detailVC.detailName = title
    }
    
   
    
}
