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
    
    var cellId = "Cell"
    
    var items = ["111", "222", "333", "444", "555"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
    
    
    
    private func initialize() {
        
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]

        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd MM yyyy"
        let today = format.string(from: date)
        title = "втрати на \(today) склали:".uppercased()
        
        tableView.setEditing(false, animated: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.layer.cornerRadius = 10
        tableView.isScrollEnabled = false
        tableView.separatorColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    
    // MARK: - Delegate && DataSource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        
        /*cell.textLabel?.text = items[indexPath.row]
        cell.backgroundColor = .systemBrown */
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = chartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

