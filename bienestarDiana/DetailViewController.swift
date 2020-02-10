//
//  DetailViewController.swift
//  Collection
//
//  Created by alumnos on 22/10/2019.
//  Copyright © 2019 alumnos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    
    @IBOutlet weak var appName: UILabel!
    
    var detailName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detailImage.image = UIImage.init(imageLiteralResourceName: detailName!)
        title = detailName
        appName.text = title
    }
    
    
}
