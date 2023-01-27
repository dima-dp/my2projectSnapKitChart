//
//  mainViewController.swift
//  my2projectSnapKitChart
//
//  Created by Home on 18.01.2023.
//

import UIKit
import SnapKit
import Alamofire

class mainViewController: UITableViewController {

    var cellId = "Cell"
    var increase = [String: Int]()
    var stats = [String: Int]()
    let vc = chartViewController()
    
    var termsUA = StaticInformation.shared.termsUA
    var termsEN = StaticInformation.shared.termsEN
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getStatsData()
        initialize()
        getDataForChartBackground()
    }
    
    
    // MARK: - Private functions
    
    func configureRefreshControl () {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:
                                            #selector(handleRefreshControl),
                                            for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        getStatsData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func initialize() {
        
        view.backgroundColor = .lightGray
        
        navigationController?.navigationBar.tintColor = .systemYellow
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let today = dataHelper.shared.todayDate()
        self.title = "втрати на \(today) склали:".uppercased()
        
        tableView.setEditing(false, animated: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = true
        tableView.separatorColor = .white
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    //MARK: - Alamofire
    private func getStatsData() {
        
        AF.request("https://russianwarship.rip/api/v1/statistics/latest").responseJSON {
            (responseJSON) in
            
            switch responseJSON.result {
            case .success(let value):
                guard let jsonContainer = value as? [String: Any],
                      let statsContainer = jsonContainer["data"] as? [String: Any],
                      let stats = statsContainer["stats"] as? [String: Int],
                      let increase = statsContainer["increase"] as? [String: Int]
                else { return }
                self.stats = stats
                self.increase = increase
            case .failure(let error):
                print(error)
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK: - URLSession
    private func getDataForChartBackground() {
        
        let dateWarBegin = "24 02 2022"

        let format = DateFormatter()
        format.dateFormat = "dd MM yyyy"
        guard let date1 = format.date(from: dateWarBegin) else { return }
        let dateNow = Date()
        guard let dateDiff = Calendar.current.dateComponents([.day], from: date1, to: dateNow).day else { return }
        let offset = dateDiff - 40
        let limit = 40
        let urlString = "https://russianwarship.rip/api/v1/statistics?offset=\(offset)&limit=\(limit)"
        //print(urlString)
 
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            //let jsonString = String(data: data, encoding: .utf8)
            let statisticInformaion =  try? JSONDecoder().decode(Statistics.self, from: data)
              
            self.vc.records = statisticInformaion?.data?.records ?? []
            
            //треба розпарсити ДЖСОН та записати його в Реалм. Аналіз чи там вже є такі дані?
          //  print(jsonString ?? "")
        }.resume()
        
    }
    
    
    // MARK: - Delegate && DataSource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return termsUA.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        
        let termEN = termsEN[indexPath.row]
        cell.RIPName.text = termsUA[indexPath.row]
        cell.imageName.image = UIImage(named: termEN)
        cell.totalLosts.text = String(stats[termEN]?.description ?? "0")
        if let increment = increase[termEN] {
            if increment > 0 {
                cell.changeLosts.text = "+" + String(increase[termEN]?.description ?? "0")
            } else {
                cell.changeLosts.text = String(increase[termEN]?.description ?? "0")
            }
        } else {
            cell.changeLosts.text = "no data"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        vc.selectedTableRow = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

