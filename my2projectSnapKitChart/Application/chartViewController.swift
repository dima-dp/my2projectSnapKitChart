//
//  chartViewController.swift
//  my2projectSnapKitChart
//
//  Created by Home on 20.01.2023.
//

import UIKit
import SnapKit
import Charts

class chartViewController: UIViewController {
    
    var selectedTableRow = Int()
    var records = [Record]()
    var values = [ChartDataEntry]()
    let segmentControl = UISegmentedControl(items: ["Рік", "30 днів", "7 днів"])
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelRotationAngle = -90
        chartView.animate(xAxisDuration: 0.9)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        // when view loads it shows data for last 7 days by default
        values = getStatsForOffsset(offset: 7,forKey: StaticInformation.shared.termsUA[selectedTableRow])

        initialize()
        
        lineChartView.animate(xAxisDuration: 0.9)
        setData(with: values)
    }
    
    
    // MARK: - Private functions
    private func getStatsForOffsset(offset: Int, forKey: String) -> [ChartDataEntry] {
        var values = [ChartDataEntry]()
        var myRecords: [Int] = []
        var datesSet: [String] = []
        var i = 1.0
        for index in (records.count - offset)..<records.count {
            let stats = records[index].stats![StaticInformation.shared.termsEN[selectedTableRow]]
            myRecords.append(stats!)
            datesSet.append(records[index].date!.description)
            values.append(ChartDataEntry(x: i, y: Double(stats!)))
             i += 1
        }
        self.lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: datesSet)
        return values
    }
    
    private func setData(with values: [ChartDataEntry]) {
        let set1LabelText = "Втрати по позиції \"" + StaticInformation.shared.termsUA[selectedTableRow] + "\""
        let set1 = LineChartDataSet(entries: values, label: set1LabelText)

        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.systemYellow)
        set1.fill = Fill(color: .systemYellow)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    private func initialize() {
        title = "Графік за минулі 7 днів".uppercased()  // is showing by default
        
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
            $0.top.equalToSuperview().inset(100)
            $0.bottom.equalTo(segmentControl).inset(50 + 20)
        }
    }
    
    @objc func segmentControlChanged(_ sender: UISegmentedControl!) {
      
        switch sender.selectedSegmentIndex {
        case 0:
            title = "Графік за минулий рік".uppercased()   //RAndom generated because it must come form backend but I don't have one
            values = []
            for index in 1...12 {   // 12 months
                values.append(ChartDataEntry(x: Double(index), y: Double.random(in: 1000...10000)))
            }
  
        case 1:
            title = "Графік за минулі 30 днів".uppercased()
            values = getStatsForOffsset(offset: 30,forKey: StaticInformation.shared.termsUA[selectedTableRow])
        case 2:
            title = "Графік за минулі 7 днів".uppercased()
            values = getStatsForOffsset(offset: 7,forKey: StaticInformation.shared.termsUA[selectedTableRow])
        default:
            title = "Графік за минулий період".uppercased()
            values = []
        }
        lineChartView.animate(xAxisDuration: 0.9)
        setData(with: values)
    }
    
}
