//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Мария Можаева on 15.02.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        
        static let contentViewCornerRadius: CGFloat = 8.0

        static let spacing: CGFloat = 12.0
        static let bottomSpacing: CGFloat = -15.0
    }
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Все получится!"
        titleLabel.textColor = .systemGray
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    let percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.textColor = .systemGray
        percentLabel.numberOfLines = 1
        percentLabel.textAlignment = .right
        percentLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return percentLabel
    }()
    
    let progressScale: UIProgressView = {
        let progressScale = UIProgressView()
        progressScale.trackTintColor = .systemGray2
        progressScale.progressTintColor = UIColor(named: "purpleColor")
        progressScale.layer.cornerRadius = 3
        progressScale.translatesAutoresizingMaskIntoConstraints = false
        
        return progressScale
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        
    }

    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .lightGray
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(percentLabel)
        contentView.addSubview(progressScale)
        
        progressScale.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            percentLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            progressScale.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            progressScale.trailingAnchor.constraint(equalTo: percentLabel.trailingAnchor),
            progressScale.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomSpacing),
            progressScale.heightAnchor.constraint(equalToConstant: 7)
        ])
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with habit: Habit) {
        percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        progressScale.progress = HabitsStore.shared.todayProgress

    }
    
    
    
}

extension ProgressCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
}
    
 

