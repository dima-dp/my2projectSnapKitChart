//
//  mainViewController.swift
//  my2projectSnapKitChart
//
//  Created by Home on 18.01.2023.
//

import UIKit
import SnapKit
import RealmSwift
import Alamofire

class mainViewController: UITableViewController {
    
    let activityIndicator = UIActivityIndicatorView()
    
    var cellId = "Cell"
    var increase = [String: Int]()
    var stats = [String: Int]()
    
    var termsUA = StaticInformation.shared.termsUA
    var termsEN = StaticInformation.shared.termsEN
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        getStatsData()
        initialize()

    }

// MARK: - Private functions
    
    private func initialize() {
        
        view.backgroundColor = .lightGray
        
        activityIndicator.color = .red
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(70)
        }
    
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]

        self.title = dataHelper.shared.tableViewTitle()
        tableView.setEditing(false, animated: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = true
        tableView.separatorColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func getStatsData() {
        
        AF.request("https://russianwarship.rip/api/v1/statistics/latest").responseJSON {
            (responseJSON) in
            
            self.activityIndicator.startAnimating()
            switch responseJSON.result {
            case .success(let value):
                guard let jsonContainer = value as? [String: Any],
                      let statsContainer = jsonContainer["data"] as? [String: Any],
                      let stats = statsContainer["stats"] as? [String: Int],
                      let increase = statsContainer["increase"] as? [String: Int]
                else { return }
                self.stats = stats
                self.increase = increase
              /*  print("----------------------")
                print(self.stats)
                print("----------------------")
                print(self.increase) */
            case .failure(let error):
                print(error)
            }
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    // MARK: - Delegate && DataSource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
        let vc = chartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

