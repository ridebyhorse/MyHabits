//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Мария Можаева on 10.02.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let textTitleLabel: UILabel = {
        let textTitle = UILabel()
        textTitle.text = "Привычка за 21 день"
        textTitle.textColor = .black
        textTitle.textAlignment = .left
        textTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return textTitle
    }()
    
    let infoText: UITextView = {
        let text = UITextView()
 
        text.textColor = .black
        text.font = .systemFont(ofSize: 17, weight: .regular)
        text.textAlignment = .left
        text.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
"""
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isEditable = false
        text.sizeToFit()
        text.isScrollEnabled = false

        
        return text
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Информация"
        setupViews()

    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(textTitleLabel)
        scrollView.addSubview(infoText)
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
  
        
        NSLayoutConstraint.activate([
            textTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
            textTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            infoText.topAnchor.constraint(equalTo: textTitleLabel.bottomAnchor),
            infoText.leadingAnchor.constraint(equalTo: textTitleLabel.leadingAnchor, constant: -5),
            infoText.trailingAnchor.constraint(equalTo: textTitleLabel.trailingAnchor),
            infoText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            infoText.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -27)
        ])
        
    }
    

}
