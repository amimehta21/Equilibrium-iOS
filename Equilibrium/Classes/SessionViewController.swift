//
//  SessionViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/12/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit
import Charts

class SessionViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    var months = [String]()
    var session: Session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        var dataEntries = [ChartDataEntry]()
        for i in 0...(dataPoints.count - 1) {
            let entry = ChartDataEntry(x: values[i], y: Double(i));
            dataEntries.append(entry)
        }
        let set = ChartDataSet(values: dataEntries, label: "Units sold")
        let chartData = ChartData(dataSet: set)
        chartView.data = chartData
    }

}
