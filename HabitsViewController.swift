//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Мария Можаева on 10.02.2022.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addHabitButton = UIBarButtonItem(image: UIImage(systemName: "plus"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(showInfo))
        
        self.navigationItem.rightBarButtonItem = addHabitButton

    
    }
    
    
    @objc func showInfo(sender: UIBarButtonItem!) {
        print("add habit button pressed")
//        let infoController  = InfoViewController()
//        infoController.view.backgroundColor = .systemRed
//        present(
//                    infoController,
//                    animated: true,
//                    completion: nil
//                )
    }
}
