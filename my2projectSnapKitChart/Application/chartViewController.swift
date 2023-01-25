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
    
    var selectedTableRow = Int()
    let segmentControl = UISegmentedControl(items: ["Рік", "Місяць", "Тиждень"])
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.animate(yAxisDuration: 0.5)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        initialize()
        
        setData()
        
        print(StaticInformation.shared.termsUA[selectedTableRow])
    }
    

// MARK: - Private functions
    private func setData() {
        let set1 = LineChartDataSet(entries: values, label: "MyLabel")
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.fill = Fill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    let values: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 0.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 3.0),
        ChartDataEntry(x: 3.0, y: 1.0),
        ChartDataEntry(x: 4.0, y: 5.0),
        ChartDataEntry(x: 5.0, y: 10.0),
        ChartDataEntry(x: 6.0, y: 12.0)
    ]
    
    private func initialize() {
        title = "Графік за минулий тиждень".uppercased()
        
        segmentControl.selectedSegmentIndex = 2
        segmentControl.backgroundColor = .systemYellow
        segmentControl.selectedSegmentTintColor = .systemGray3
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
        
        lineChartView.chartAnimator.animate(yAxisDuration: 0.5, easing: nil)
        setData()
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            title = "Графік за минулий рік".uppercased()
        case 1:
            title = "Графік за минулий місяць".uppercased()
        case 2:
            title = "Графік за минулий тиждень".uppercased()
        default:
            title = "Графік за минулий  період".uppercased()
        }
    }

}
