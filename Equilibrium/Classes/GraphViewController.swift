//
//  GraphViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/12/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var location = String() // i.e. /102/orientation/sagittal/absolute/
    var name = String() // i.e. Foot
    
    var sets = [LineChartDataSet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = name
        self.navigationController?.setToolbarHidden(false, animated: true)
        let fileName = name.lowercased() + ".json"
        let path = location + fileName

        if let jsonObject = FileUtils.getJSON(atPath: path), let jsonString = FileUtils.getStringFromFile(atPath: path) {
            var numGraphs = 0
            if jsonString.contains("left") && jsonString.contains("right") && jsonString.contains("x") && jsonString.contains("y") && jsonString.contains("z") {
                numGraphs = 6
            } else if jsonString.contains("left") && jsonString.contains("right") {
                numGraphs = 2
            } else if jsonString.contains("x") && jsonString.contains("y") && jsonString.contains("z") {
                numGraphs = 3
            }  else {
                numGraphs = 1
            }
            
            setChartData(object: jsonObject, description: name, numGraphs: numGraphs)
        }
    }
    
    @IBAction func cancelToGraphView(segue: UIStoryboardSegue) {}
    
    @IBAction func saveToGraphView(segue: UIStoryboardSegue) {
        if let graphListView = segue.source as? GraphListViewController {
            sets = graphListView.sets
            setLineChartDataSource()
        }
    }
    
    @IBAction func resetScale(_ sender: Any) {
        print("reset")
        lineChartView.fitScreen()
    }
    
    @IBAction func filterGraph(_ sender: Any) {
        
    }
        
    func setChartData(object: [String: Any], description: String, numGraphs: Int) {
        var colors = [UIColor]()
        if numGraphs == 6 {
            sets = getChartDataSetSix(object: object)
            colors = [UIColor.red, UIColor.orange, UIColor.gray, UIColor.green, UIColor.blue, UIColor.black]
        } else if numGraphs == 3 {
            sets = getChartDataSetThree(object: object)
            colors = [UIColor.red, UIColor.green, UIColor.blue]
        } else if numGraphs == 2 {
            sets = getChartDataSetTwo(object: object)
            colors = [UIColor.red, UIColor.green]
        } else {
            sets = getChartDataSetOne(object: object, label: description)
            colors = [UIColor.red]
        }
        
        for (index, set) in sets.enumerated() {
            let color = colors[index]
            set.axisDependency = .left // Line will correlate with left axis values
            set.setColor(color.withAlphaComponent(0.5))
            set.setCircleColor(color)
            set.lineWidth = 2.0
            set.fillAlpha = 65 / 255.0
            set.fillColor = color
            set.highlightColor = color
            set.drawCirclesEnabled = false
            set.drawValuesEnabled = false
        }
        setLineChartDataSource()
        lineChartView.drawMarkers = false
        lineChartView.chartDescription?.text = description
        lineChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    func setLineChartDataSource() {
        let data = LineChartData(dataSets: sets)
        data.setValueTextColor(UIColor.black)
        lineChartView.data = data
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Slected")
    }
    func getChartDataSetSix(object: [String: Any]) -> [LineChartDataSet] {
        var sets = [LineChartDataSet]()
        let types = [SetTypeSix(direction: "x", side: "right", description: "Right X"),
                     SetTypeSix(direction: "y", side: "right", description: "Right Y"),
                     SetTypeSix(direction: "z", side: "right", description: "Right Z"),
                     SetTypeSix(direction: "x", side: "left", description: "Left X"),
                     SetTypeSix(direction: "y", side: "left", description: "Left Y"),
                     SetTypeSix(direction: "z", side: "left", description: "Left Z")]
        for type in types {
            let valuesArray = parseSix(object: object, side: type.side, dir: type.direction)
            sets.append(getSetFromValues(values: valuesArray, label: type.description))
        }
        return sets
    }
    
    func getChartDataSetThree(object: [String: Any]) -> [LineChartDataSet] {
        var sets = [LineChartDataSet]()
        let types = [SetTypeTwoThree(direction: "x", description: "X"),
                     SetTypeTwoThree(direction: "y", description: "Y"),
                     SetTypeTwoThree(direction: "z", description: "Z")]
        for type in types {
            let valuesArray = parseTwoOrThree(object: object, dir: type.direction)
            sets.append(getSetFromValues(values: valuesArray, label: type.description))
        }
        return sets
    }
    
    func getChartDataSetTwo(object: [String: Any]) -> [LineChartDataSet] {
        var sets = [LineChartDataSet]()
        let types = [SetTypeTwoThree(direction: "right", description: "Right"),
                     SetTypeTwoThree(direction: "left", description: "Left")]
        for type in types {
            let valuesArray = parseTwoOrThree(object: object, dir: type.direction)
            sets.append(getSetFromValues(values: valuesArray, label: type.description))
        }
        return sets
    }
    
    func getChartDataSetOne(object: [String: Any], label: String) -> [LineChartDataSet] {
        let valuesArray = parseOne(object: object)
        let set = getSetFromValues(values: valuesArray, label: label)
        return [set]
    }
    
    // side: right, left
    // dir: x,y,z
    public func parseSix(object: [String: Any], side: String, dir: String) -> [Double] {
        var values: [Double] = []
        if let right = object[side] as? [String: Any] {
            if let points = right[dir] as? [String: Any] {
                let sortedPoints = points.sorted(by: { Int($0.0)! < Int($1.0)! })
                for (_, value) in sortedPoints {
                    values.append(value as! Double)
                }
            }
        }
        return values
    }
    
    public func parseTwoOrThree(object: [String: Any], dir: String) -> [Double] {
        var values: [Double] = []
        if let points = object[dir] as? [String: Any] {
            let sortedPoints = points.sorted(by: { Int($0.0)! < Int($1.0)! })
            for (_, value) in sortedPoints {
                values.append(value as! Double)
            }
        }
        return values
    }
    
    public func parseOne(object: [String: Any]) -> [Double] {
        var values: [Double] = []
        let sortedPoints = object.sorted(by: { Double($0.0)! < Double($1.0)! })
        for (_, value) in sortedPoints {
            values.append(Double("\(value)")!)
        }
        return values
    }
    
    func getSetFromValues(values: [Double], label: String) -> LineChartDataSet {
        var chartDataEntry = [ChartDataEntry]()
        for i in 0 ..< values.count {
            chartDataEntry.append(ChartDataEntry(x: Double(i), y: values[i]))
        }
        let set = LineChartDataSet(values: chartDataEntry, label: label)
        return set
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as? UINavigationController
        let tableVC = navVC?.viewControllers.first as! GraphListViewController
        // must pass the currently selected items.
        // create a struct w/ item name & boolean value selected?
        tableVC.sets = sets
        
    }
    
}
