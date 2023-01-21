//
//  mainViewController.swift
//  my2projectSnapKitChart
//
//  Created by Home on 18.01.2023.
//

import UIKit
import SnapKit
import RealmSwift

class mainViewController: UITableViewController {
    var cellId = "Cell"
    
    var items = ["111", "222"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        

    }
    
    
    
    private func initialize() {
        
        view.backgroundColor = .lightGray
        
        tableView.setEditing(false, animated: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.sectionHeaderHeight = 40
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Delegate && DataSource methods
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }

        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd MM yyyy"
        let today = format.string(from: date)
    
        let headerText = "втрати на \(today) склали:".uppercased()
       
        header.textLabel?.numberOfLines = 0
        header.textLabel?.text = headerText
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center


    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header text"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = chartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

