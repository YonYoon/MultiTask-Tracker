//
//  PomodoroViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 22.07.2024.
//

import UIKit
import AVFoundation

class PomodoroViewController: UIViewController {
    let focusTimePicker = UIDatePicker()
    var focusTimerDuration: TimeInterval = 60 * 25 // 25 min, initial duration
    let timerLabel = UILabel()
    let tasksList = UITableView()
    let startButton = UIButton()
    let pauseButton = UIButton()
    let breakButton = UIButton()
    
    var focusTimer: Timer!
    private var isPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Pomodoro"
        
        configureFocusTimePicker()
        configureTaskList()
        configureStartButton()
        configureTimerLabel()
    }
    
    private func configureFocusTimePicker() {
        focusTimePicker.datePickerMode = .countDownTimer
        focusTimePicker.countDownDuration = focusTimerDuration
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
        startButton.setImage(.init(systemName: "play.fill"), for: .normal)
        startButton.configuration?.imagePadding = 10
        
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureBreakButton() {
        view.addSubview(breakButton)
        breakButton.translatesAutoresizingMaskIntoConstraints = false
        
        breakButton.configuration = .tinted()
        breakButton.setTitle("Break", for: .normal)
        breakButton.setImage(.init(systemName: "forward.end.fill"), for: .normal)
        breakButton.configuration?.imagePadding = 5
        
        breakButton.addTarget(self, action: #selector(startBreak), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            breakButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor),
            breakButton.heightAnchor.constraint(equalToConstant: 50),
            breakButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 80),
            breakButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configurePauseButton() {
        view.addSubview(pauseButton)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        pauseButton.configuration = .tinted()
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setImage(.init(systemName: "pause.fill"), for: .normal)
        pauseButton.configuration?.imagePadding = 10
        
        pauseButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            pauseButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 50),
            pauseButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            pauseButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureTimerLabel() {
        view.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.isHidden = true
        
        timerLabel.font = .monospacedDigitSystemFont(ofSize: 80, weight: .black)
        timerLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            timerLabel.centerYAnchor.constraint(equalTo: focusTimePicker.centerYAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 100),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func startTimer() {
        focusTimerDuration = focusTimePicker.countDownDuration
        timerLabel.text = DateComponentsFormatter().string(from: focusTimerDuration)
        
        // Replace focus duration picker with timer
        focusTimePicker.isHidden = true
        timerLabel.isHidden = false
        
        focusTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        focusTimer.tolerance = 0.2

        // TODO: Replace start button with pause button, cancel button and break button
        startButton.isHidden = true
        
        // TODO: Configure stack view with pause button and break button
        configurePauseButton()
        configureBreakButton()
    }
    
    @objc private func pauseTimer() {
        isPaused.toggle()
        
        if isPaused {
            focusTimer.invalidate()
            
            pauseButton.setTitle("Continue", for: .normal)
            pauseButton.setImage(.init(systemName: "play.fill"), for: .normal)
        } else {
            focusTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
            
            pauseButton.setTitle("Pause", for: .normal)
            pauseButton.setImage(.init(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @objc private func startBreak() {
        focusTimer.invalidate()
    }
    
    private func configureTaskList() {
        // TODO: Implement task list
    }
    
    @objc private func fireTimer() {
        if focusTimerDuration == 0 {
            startBreak()
            playSound()
            // TODO: IN FUTURE Go to break phase
        } else {
            focusTimerDuration -= 1
            timerLabel.text = DateComponentsFormatter().string(from: focusTimerDuration)
        }
    }
    
    private func playSound() {
        guard let path = Bundle.main.path(forResource: "sound", ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print("Audio playback error: \(error)")
        }
    }
}

#Preview {
    let tabBar = UITabBarController()
    let navigationController = UINavigationController(rootViewController: PomodoroViewController())
    navigationController.tabBarItem.image = UIImage(systemName: "timer")
    navigationController.tabBarItem.title = "Pomodoro"
    tabBar.viewControllers = [navigationController]
    return tabBar
}
