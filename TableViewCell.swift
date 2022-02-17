//
//  TableViewCell.swift
//  MyHabits
//
//  Created by Мария Можаева on 17.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var checkmarkImageView: UIImageView = {
        let checkmarkImageView = UIImageView()
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = UIColor(named: "purpleColor")
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return checkmarkImageView
    }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            checkmarkImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20)

        ])
        
        
    }
    
    public func update(date: String, isTracked: Bool) {
        titleLabel.text = date
        checkmarkImageView.isHidden = !isTracked
    }
    
  
    

}
