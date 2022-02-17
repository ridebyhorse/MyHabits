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
    
    private var tableView: UITableView = {
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
        navigationItem.rightBarButtonItem = .init(title: "Править", style: .plain, target: self, action: #selector(didPressEditButton))
        title = HabitsStore.shared.habits[chosenHabit].name
        tableView.reloadData()
        
    }
    
    @objc func didPressEditButton (sender: UIBarButtonItem!) {
        print("edit habit button pressed")
        
        let editHabitController  = UINavigationController(rootViewController: HabitViewController())
        
        editHabitController.topViewController?.navigationItem.title = "Править"
        editHabitController.navigationBar.tintColor = UIColor(named: "purpleColor")
        
        editHabitController.modalPresentationStyle = .fullScreen
        
        chosenHabit = tableViewCell.tag
        
        present(
            editHabitController,
            animated: true,
            completion: nil
        )
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
        
        let isTracked = habits.habit((habits.habits[chosenHabit]), isTrackedIn: habits.dates.reversed()[indexPath.row])
        
    
        cell.update(date: date!, isTracked: isTracked)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}



extension HabitDetailsViewController: UITableViewDelegate {
    
}
