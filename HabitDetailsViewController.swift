//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Мария Можаева on 17.02.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    let tableViewCell: UITableViewCell = {
        let tableViewCell = UITableViewCell()
        
        return tableViewCell
    }()
    
    fileprivate let cellReuseIdentifier: String = "CellReuseIdentifier"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.rightBarButtonItem = .init(title: "Править", style: .plain, target: self, action: #selector(didPressEditButton))
        
    }
    
    @objc func didPressEditButton (sender: UIBarButtonItem!) {
        
    }
    
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,for: indexPath) as! TableViewCell
        
        let habits = HabitsStore.shared
        
        let date = habits.trackDateString(forIndex: (HabitsStore.shared.dates.count - indexPath.row - 1))
        
        let isTracked = habits.habit((habits.habits[indexPath.row]), isTrackedIn: habits.dates.reversed()[indexPath.row])
    
        cell.update(date: date!, isTracked: isTracked)
        
        return cell
    }
    
}

extension HabitDetailsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Did select cell at \(indexPath)")
//        let nextViewController = EmploeeViewController()
        
//        let data = stuff[indexPath.row]
//        nextViewController.update(title: data.0)
//
//        navigationController?.pushViewController(nextViewController, animated: true)
        
        //Чтобы вывести вью модально, а не в навигационном стеке
        //present(nextViewController, animated: true, completion: nil)
//    }
    
}
