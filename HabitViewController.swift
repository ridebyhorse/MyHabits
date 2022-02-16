//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Мария Можаева on 11.02.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "НАЗВАНИЕ"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.placeholder = "Пробежка, выпить стакан воды и т.п..."
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return titleTextField
    }()
    
    let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.text = "ЦВЕТ"
        colorLabel.textColor = .black
        colorLabel.textAlignment = .left
        colorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        return colorLabel
    }()
    
    let colorView: UIButton = {
        let colorView = UIButton()
        colorView.backgroundColor = UIColor(named: "orangeColor")
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.frame.size = .init(width: 30, height: 30)
        colorView.layer.cornerRadius = colorView.frame.size.width / 2
        colorView.clipsToBounds = true
        
        colorView.addTarget(self, action: #selector(didPressColorView), for: .touchUpInside)
        
        return colorView
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "ВРЕМЯ"
        timeLabel.textColor = .black
        timeLabel.textAlignment = .left
        timeLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timeLabel
    }()
    
    let timePickerLabel: UILabel = {
        let timePickerLabel = UILabel()
        timePickerLabel.text = "Каждый день в "
        timePickerLabel.textColor = .black
        timePickerLabel.textAlignment = .left
        timePickerLabel.font = .systemFont(ofSize: 17, weight: .regular)
        timePickerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timePickerLabel
    }()
    
    let selectedTimeLabel: UILabel = {
        let selectedTimeLabel = UILabel()
        selectedTimeLabel.textColor = UIColor(named: "purpleColor")
        selectedTimeLabel.textAlignment = .left
        selectedTimeLabel.font = .systemFont(ofSize: 17, weight: .regular)
        selectedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return selectedTimeLabel
    }()
    
    let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        timePicker.addTarget(self, action: #selector(didSelectTime), for: .valueChanged)
        
        return timePicker
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = .init(title: "Отменить", style: .plain, target: self, action: #selector(didPressCancelButton))
        navigationItem.rightBarButtonItem = .init(title: "Сохранить", style: .plain, target: self, action: #selector(didPressSaveButton))
        
        
        setupViews()
        
    }
    
    
   
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorView)
        view.addSubview(timeLabel)
        view.addSubview(timePickerLabel)
        view.addSubview(selectedTimeLabel)
        view.addSubview(timePicker)
        
       
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            colorLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            colorLabel.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            colorLabel.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            colorView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 16),
            colorView.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 30),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            timeLabel.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 16),
            timeLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: colorLabel.trailingAnchor),
            timePickerLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16),
            timePickerLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            selectedTimeLabel.topAnchor.constraint(equalTo: timePickerLabel.topAnchor),
            selectedTimeLabel.leadingAnchor.constraint(equalTo: timePickerLabel.trailingAnchor),
            timePicker.topAnchor.constraint(equalTo: timePickerLabel.bottomAnchor, constant: 16),
            timePicker.leadingAnchor.constraint(equalTo: timePickerLabel.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor)
        
        ])
        
        selectedTimeLabel.text = timePicker.date.formatted(date: .omitted, time: .shortened)
    }
    
    @objc func didSelectTime(sender: UIDatePicker!) {
        
        print("select Time: \(sender.date.formatted(date: .omitted, time: .shortened))")
      
        selectedTimeLabel.text = sender.date.formatted(date: .omitted, time: .shortened)
    }
    
    @objc func didPressColorView(sender: UIButton!) {
        print("did press ColorView")
        let colorPicker = UIColorPickerViewController()
        
        colorPicker.selectedColor = colorView.backgroundColor!
        colorPicker.delegate = self
        colorPicker.title = "Цвет привычки"
        colorPicker.supportsAlpha = false
      
        present(
            colorPicker,
            animated: true,
            completion: nil
        )
        
        colorView.backgroundColor = colorPicker.selectedColor
        
        
    }
    
    @objc func didPressCancelButton(sender: UIButton!) {
        
        print("cancel button pressed")
        
        self.dismiss(animated: true)
    }
    
    @objc func didPressSaveButton(sender: UIButton!) {
        
        print("save button pressed")
        
        let newHabit = Habit(name: titleTextField.text!,
                             date: timePicker.date,
                             color: colorView.backgroundColor!)
        
        print("\(timePicker.date)")
        
        let store = HabitsStore.shared
        
        store.habits.append(newHabit)
        
        self.dismiss(animated: true)
        
        
    }

}

extension HabitViewController : UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ colorPicker: UIColorPickerViewController) {
        
        self.colorView.backgroundColor = colorPicker.selectedColor
    
    }
}
