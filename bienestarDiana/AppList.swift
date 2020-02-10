//
//  ViewController.swift
//  Collection
//
//  Created by alumnos on 21/10/2019.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class AppList: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var datos = ["whatsapp", "facebook"]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
    }
    
    
}
