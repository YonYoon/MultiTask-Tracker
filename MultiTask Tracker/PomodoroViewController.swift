//
//  PomodoroViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 22.07.2024.
//

import UIKit

class PomodoroViewController: UIViewController {
    let focusTimePicker = UIDatePicker()
    let tasksList = UITableView()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Pomodoro"
        
        configureFocusTimePicker()
        configureTaskList()
        configureStartButton()
    }
    
    private func configureFocusTimePicker() {
        focusTimePicker.datePickerMode = .countDownTimer
        focusTimePicker.countDownDuration = 1500 // 25 min
        focusTimePicker.minuteInterval = 5
        
        view.addSubview(focusTimePicker)
        focusTimePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            focusTimePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            focusTimePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            focusTimePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            focusTimePicker.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureStartButton() {
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.configuration = .tinted()
        startButton.setTitle("Start", for: .normal)
        
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func startTimer() {
        // TODO: Implement starting timer
    }
    
    private func configureTaskList() {
        // TODO: Implement task list
    }
    
    @objc private func fireTimer() {
        // TODO: Implement countdown
    }
    
//    @objc func goToNextPage() {
//        let timerViewController = TimerViewController()
//        timerViewController.selectedTime = selectedTime
//        navigationController?.pushViewController(timerViewController, animated: true)
//    }
    
//    @objc func increaseTime() {
//        if selectedTime < 3600 {
//            selectedTime += 300
//            updateSelectedTimeLabel()
//        }
//    }
//    
//    @objc func decreaseTime() {
//        if selectedTime > 600 {
//            selectedTime -= 300
//            updateSelectedTimeLabel()
//        }
//    }
    
//    func checkButtonVisibility() {
//        decreaseButton.isHidden = isTimerRunning || selectedTime <= 600
//        increaseButton.isHidden = isTimerRunning || selectedTime >= 3600
//    }
//    
//    func updateSelectedTimeLabel() {
//        let minutes = selectedTime / 60 // Вычисляем количество минут
//        timeLabel.text = "\(minutes) min"
//    }
}

#Preview {
    let tabBar = UITabBarController()
    let navigationController = UINavigationController(rootViewController: PomodoroViewController())
    navigationController.tabBarItem.image = UIImage(systemName: "timer")
    navigationController.tabBarItem.title = "Pomodoro"
    tabBar.viewControllers = [navigationController]
    return tabBar
}
