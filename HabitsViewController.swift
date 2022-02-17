//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Мария Можаева on 10.02.2022.
//

import UIKit

let habitCollectionView: UICollectionView = {
    let viewLayout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: viewLayout
    )
    collectionView.backgroundColor = .systemGray5
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return collectionView
}()

class HabitsViewController: UIViewController {
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let lineSpacing = 12.0
        static let progressItemHeight: CGFloat = 60.0
        static let habitItemHeight: CGFloat = 130.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Сегодня"
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        
        let addHabitButton = UIBarButtonItem(image: UIImage(systemName: "plus"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(showInfo))
        addHabitButton.tintColor = UIColor(named: "purpleColor")
        
        self.navigationItem.rightBarButtonItem = addHabitButton
        
        
        setupViews()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        habitCollectionView.reloadData()
        
        
    }
    
    
    func setupViews() {
        view.addSubview(habitCollectionView)
        habitCollectionView.dataSource = self
        habitCollectionView.delegate = self
        habitCollectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: HabitCollectionViewCell.identifier
        )
        habitCollectionView.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier
        )
        
        NSLayoutConstraint.activate([
            habitCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            habitCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            habitCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    @objc func showInfo(sender: UIBarButtonItem!) {
        
        print("add habit button pressed")
        
        let addNewHabitController  = UINavigationController(rootViewController: HabitViewController())
        
        addNewHabitController.topViewController?.navigationItem.title = "Создать"
        addNewHabitController.navigationBar.tintColor = UIColor(named: "purpleColor")
        
        addNewHabitController.modalPresentationStyle = .fullScreen
        
        present(
            addNewHabitController,
                    animated: true,
                    completion: nil
        )
        
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
        
        let habitCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HabitCollectionViewCell.identifier,
            for: indexPath) as! HabitCollectionViewCell
        
        habitCell.circleTrackView.tag = indexPath.row


        if HabitsStore.shared.habits.count > 0 {
            
            let habit = HabitsStore.shared.habits[indexPath.row]
            
            habitCell.setup(with: habit)
            
            progressCell.setup(with: habit)
            
            if indexPath == [0, 0] {
                return progressCell
            } else {
                return habitCell
            }
        
        } else {
            
            if indexPath == [0, 0] {
                progressCell.progressScale.progress = 0.0
                progressCell.percentLabel.text = "0%"
                return progressCell
            } else {
                return habitCell
            }
            
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let finalWidth = width - (spacing * 2)
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        
        if indexPath == [0, 0] {
            return CGSize(width: width, height: LayoutConstant.progressItemHeight)
        } else {
            return CGSize(width: width, height: LayoutConstant.habitItemHeight)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(
                top: 22,
                left: LayoutConstant.spacing,
                bottom: 18,
                right: LayoutConstant.spacing
            )
        } else {
            return UIEdgeInsets(
                top: 0,
                left: LayoutConstant.spacing,
                bottom: LayoutConstant.spacing,
                right: LayoutConstant.spacing
            )
        }
    
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        LayoutConstant.lineSpacing
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.contentView.backgroundColor = .white
        
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Did select habit at \(indexPath.row)")
        
        let habits = HabitsStore.shared
        
        let title = habits.habits[indexPath.row].name
        
        chosenHabit = indexPath.row
        
        let detailHabitController  = HabitDetailsViewController()
        detailHabitController.tableViewCell.tag = indexPath.row
        
        navigationController?.pushViewController(detailHabitController, animated: true)
        detailHabitController.navigationItem.title = title
        detailHabitController.navigationController?.navigationBar.tintColor = UIColor(named: "purpleColor")
        
    }
    
    
}
