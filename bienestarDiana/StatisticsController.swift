//
//  StatisticsController.swift
//  bienestarDiana
//
//  Created by alumnos on 17/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Foundation
import UIKit
import CSPieChart

public class StatisticsController : UIViewController {
    
    @IBOutlet weak var pieChart: CSPieChart!
    @IBAction func reloadPieChart(_ sender: Any) {
        pieChart.reloadPieChart()
    }
    
    var data: [DataModel] = []
    
    
    var colorList: [UIColor] = [
        .red,
        .orange,
        .yellow,
        .green,
        .blue,
        .magenta
    ]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        data = DataHelpers.parseCsvData()
        var appsTime = [String]()
        var totalMinutes: Double = 0
        
        dataList = [
            CSPieChartData(key: data[0].App, value: DataHelpers.totalMinutesByApp(appDates: DataHelpers.getAppDates(dataModel: data, app: data[0].App))),
            CSPieChartData(key: data[4].App, value: DataHelpers.totalMinutesByApp(appDates: DataHelpers.getAppDates(dataModel: data, app: data[4].App))),
            CSPieChartData(key: data[6].App, value: DataHelpers.totalMinutesByApp(appDates: DataHelpers.getAppDates(dataModel: data, app: data[6].App))),
            CSPieChartData(key: data[8].App, value: DataHelpers.totalMinutesByApp(appDates: DataHelpers.getAppDates(dataModel: data, app: data[8].App))),
            CSPieChartData(key: data[12].App, value: DataHelpers.totalMinutesByApp(appDates: DataHelpers.getAppDates(dataModel: data, app: data[12].App))),
            CSPieChartData(key: data[26].App, value: DataHelpers.totalMinutesByApp(appDates: DataHelpers.getAppDates(dataModel: data, app: data[26].App)))
        ]
        pieChart?.dataSource = self as! CSPieChartDataSource
        pieChart?.delegate = self as! CSPieChartDelegate
        
        pieChart?.pieChartRadiusRate = 0.5
        pieChart?.pieChartLineLength = 12
        pieChart?.seletingAnimationType = .touch
        
        pieChart?.show(animated: true)
        
       
    }
    var dataList = [CSPieChartData]()
    private var touchDistance: CGFloat = 0
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view) else {
            return
        }
        
        touchDistance = location.x
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view) else {
            return
        }
        
        touchDistance -= location.x
        
        if touchDistance > 100 {
            print("Right")
        } else if touchDistance < -100 {
            print("Left")
        }
        
        touchDistance = 0
    }
}

extension StatisticsController: CSPieChartDataSource {
    
    public func numberOfComponentData() -> Int {
        return dataList.count
    }
    
    public func pieChart(_ pieChart: CSPieChart, dataForComponentAt index: Int) -> CSPieChartData {
        return dataList[index]
    }
    
    public func numberOfComponentColors() -> Int {
        return colorList.count
    }
    
    public func pieChart(_ pieChart: CSPieChart, colorForComponentAt index: Int) -> UIColor {
        return colorList[index]
    }
    
    public func numberOfLineColors() -> Int {
        return colorList.count
    }
    
    public func pieChart(_ pieChart: CSPieChart, lineColorForComponentAt index: Int) -> UIColor {
        return colorList[index]
    }
    
    public func numberOfComponentSubViews() -> Int {
        return dataList.count
    }
    
    public func pieChart(_ pieChart: CSPieChart, viewForComponentAt index: Int) -> UIView {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.image = UIImage(named: "test.png")
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }
}

extension StatisticsController: CSPieChartDelegate {
    
    public func pieChart(_ pieChart: CSPieChart, didSelectComponentAt index: Int) {
        let data = dataList[index]
        print(data.key)
    }
}
