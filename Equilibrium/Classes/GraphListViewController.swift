//
//  GraphListViewController.swift
//  Equilibrium
//
//  Created by Shomil Jain on 6/18/17.
//  Copyright © 2017 Vayu Technology. All rights reserved.
//

import UIKit
import Eureka
import Charts

class GraphListViewController: FormViewController {

    var sets = [LineChartDataSet]()
    final var SELECTED = "selectableValue"
    final var SECTION_TAG = "sectionTag"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let section = SelectableSection<ListCheckRow<String>>(header: "Select one or more graphs.", footer: "", selectionType: .multipleSelection)
        section.tag = SECTION_TAG
        form +++ section
        
        for set in sets {
            if let option = set.label {
                form.last! <<< ListCheckRow<String>(option){ listRow in
                    listRow.title = option
                    listRow.selectableValue = option
                    if set.isVisible {
                        listRow.value = SELECTED
                    } else {
                        listRow.value = nil
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "saveToGraph" {
                if let section = self.form.sectionBy(tag: SECTION_TAG) as? SelectableSection<ListCheckRow<String>> {
                    hideAll()
                    let selectedRows = section.selectedRows()
                    for set in sets {
                        for row in selectedRows {
                            if row.title == set.label {
                                set.visible = true // if it's in selectedRows it shoudl be visible
                            }
                        }
                    }
                }
            }
        }
    }
    
    func hideAll() {
        for set in sets {
            set.visible = false
        }
    }
    
}
