//
//  chartViewController.swift
//  my2projectSnapKitChart
//
//  Created by Home on 20.01.2023.
//

import UIKit
import SnapKit
import RealmSwift
import Charts

class chartViewController: UIViewController {
    
    let segmentControl = UISegmentedControl(items: ["year", "month", "week"])
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemRed
        return chartView
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        
        initialize()
    }
    
    
    
    private func initialize() {
        
        segmentControl.frame = CGRect(x: 0, y: 50, width: 300, height: 50)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlChanged(_ :)), for: .valueChanged)
        
        lineChartView.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        
        view.addSubview(segmentControl)
        view.addSubview(lineChartView)
        
        
    }
    
    @objc func segmentControlChanged(_ sender: UISegmentedControl!) {
        print(sender.selectedSegmentIndex)
    }

}
