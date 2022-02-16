//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Мария Можаева on 15.02.2022.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        
        static let contentViewCornerRadius: CGFloat = 8.0

        static let circleTrackHeight: CGFloat = 38.0

        static let verticalSpacing: CGFloat = 20.0
        static let leftSpacing: CGFloat = 20.0
        static let rightSpacing: CGFloat = -25.0
    }
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .systemGray2
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    let counterTrackDateLabel: UILabel = {
        let counterTrackDateLabel = UILabel()
        counterTrackDateLabel.numberOfLines = 1
        counterTrackDateLabel.textAlignment = .left
        counterTrackDateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        counterTrackDateLabel.textColor = .systemGray
        counterTrackDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return counterTrackDateLabel
    }()

    let circleTrackView: UIButton = {
        let circleTrackView = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: Constants.circleTrackHeight, height: Constants.circleTrackHeight)))
        circleTrackView.layer.cornerRadius = circleTrackView.frame.size.width/2
        circleTrackView.layer.borderWidth = 2
        circleTrackView.addTarget(self, action: #selector(didTapTrackButton), for: .touchUpInside)
        circleTrackView.translatesAutoresizingMaskIntoConstraints = false
        
        return circleTrackView
    }()
    
    let checkmarkImageView: UIImageView = {
        let checkmarkImageView = UIImageView()
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .white
        checkmarkImageView.isUserInteractionEnabled = false
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return checkmarkImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        
    }

    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .lightGray
        
        contentView.addSubview(circleTrackView)
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(counterTrackDateLabel)
        
        circleTrackView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            circleTrackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circleTrackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.rightSpacing),
            circleTrackView.heightAnchor.constraint(equalToConstant: 40),
            circleTrackView.widthAnchor.constraint(equalToConstant: 40),
            checkmarkImageView.centerXAnchor.constraint(equalTo: circleTrackView.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: circleTrackView.centerYAnchor),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: circleTrackView.leadingAnchor, constant: -Constants.leftSpacing),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            counterTrackDateLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            counterTrackDateLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            counterTrackDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalSpacing)
        ])
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with habit: Habit) {
        circleTrackView.layer.borderColor = habit.color.cgColor
        if habit.isAlreadyTakenToday {
            circleTrackView.backgroundColor = habit.color
        } else {
            circleTrackView.backgroundColor = .white
        }
        
        titleLabel.text = habit.name
        titleLabel.textColor = habit.color
        dateLabel.text = habit.dateString
        counterTrackDateLabel.text = "Счетчик: \(habit.trackDates.count)"
        
    }
    
    @objc func didTapTrackButton(sender: UIButton!) {
        
        let habitsVC = HabitsViewController()

        print("track button taped")
        
        let habit = HabitsStore.shared.habits[sender.tag]
        
        if habit.isAlreadyTakenToday {
            return
        } else {
            circleTrackView.backgroundColor = habit.color
            habitsVC.collectionView.reloadData()
            habitsVC.collectionView.layoutSubviews()
            HabitsStore.shared.track(habit)
        }
        
        
    }

}

extension HabitCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
