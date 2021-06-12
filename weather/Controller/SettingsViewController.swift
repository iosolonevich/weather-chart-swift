//
//  SettingsViewController.swift
//  weather
//
//  Created by alex on 12.06.2021.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .singleLine
        
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    func configureUI() {
        
        
        configureTableView()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationItem.title = "Settings"
//        navigationItem.largeTitleDisplayMode = .never
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
//        view.backgroundColor = .red
        let title = UILabel()
        title.text = SettingsSection(rawValue: section)?.description
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .gray
        view.addSubview(title, anchors: [ .centerY(view.centerYAnchor), .leading(view.leadingAnchor, 16) ])
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Appearance: return AppearanceOptions.allCases.count
        case .Other: return OtherOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingsCell else { return UITableViewCell() }
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .Appearance:
            let appearance = AppearanceOptions(rawValue: indexPath.row)
//            cell.textLabel?.text = appearance?.description
            cell.sectionType = appearance
        case .Other:
            let other = OtherOptions(rawValue: indexPath.row)
            cell.sectionType = other
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
//        switch section {
//        case .Appearance:
//            //print let appearance = AppearanceOptions(rawValue: indexPath.row)
//        case .Other:
//            //print let other = OtherOptions(rawValue: indexPath.row)
//        }
        
    }
}
