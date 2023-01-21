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
    
    let segmentControl = UISegmentedControl(items: ["Рік", "Місяць", "Тиждень"])
    
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
        
        //segmentControl.frame = CGRect(x: 0, y: 50, width: 100, height: 75)
        segmentControl.selectedSegmentIndex = 2
        segmentControl.backgroundColor = .systemGray5
        segmentControl.addTarget(self, action: #selector(segmentControlChanged(_ :)), for: .valueChanged)
        
        
        
        view.addSubview(segmentControl)
        view.addSubview(lineChartView)
        
        segmentControl.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        lineChartView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(70)
            $0.bottom.equalTo(segmentControl).inset(50 + 20)
        }
        
        
    }
    
    @objc func segmentControlChanged(_ sender: UISegmentedControl!) {
        print(sender.selectedSegmentIndex)
    }

}
