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
        let folderPath = Bundle.main.path(forResource: "1", ofType: "")
        let fileName = name.lowercased() + ".json"
        let path = folderPath! + location + fileName
        print("PATH: " + path)
        let url = URL(fileURLWithPath: path)
        let desc = name
        
        self.lineChartView.delegate = self
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let dataString = try String(contentsOf: url)
            if let object = json as? [String: Any] {
                var numGraphs = 0
                if dataString.contains("left") && dataString.contains("right") && dataString.contains("x") && dataString.contains("y") && dataString.contains("z") {
                    numGraphs = 6
                } else if dataString.contains("left") && dataString.contains("right") {
                    numGraphs = 2
                } else if dataString.contains("x") && dataString.contains("y") && dataString.contains("z") {
                    numGraphs = 3
                }  else {
                    numGraphs = 1
                }
                setChartData(object: object, description: desc, numGraphs: numGraphs)
            } else {
                print("JSON is invalid")
            }
            
        } catch {
            print(error.localizedDescription)
        }
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
        
        let data = LineChartData(dataSets: sets)
        data.setValueTextColor(UIColor.black)
        lineChartView.data = data
        lineChartView.drawMarkers = false
        lineChartView.chartDescription?.text = description
        lineChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        lineChartView.chartDescription?.text = "Location: (\(entry.x), \(entry.y))"
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
    
}
