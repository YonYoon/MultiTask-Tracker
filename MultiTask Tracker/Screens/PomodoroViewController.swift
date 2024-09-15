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
    let switchStateButton = UIButton()
    
    var focusTimer: Timer!
    private var isPaused = false
    
    private var isFocusState: Bool = true {
        didSet {
            focusTimePicker.isHidden = false
            timerLabel.isHidden = true
            
            startButton.isHidden = false
            pauseButton.isHidden = true
            switchStateButton.isHidden = true
            
            if isFocusState {
                focusTimerDuration = 60 * 25
                focusTimePicker.minuteInterval = 5
                switchStateButton.setTitle("Break", for: .normal)
                
                navigationItem.title = "Focus"
            } else {
                focusTimerDuration = 60 * 5
                focusTimePicker.minuteInterval = 1
                switchStateButton.setTitle("Focus", for: .normal)
                
                navigationItem.title = "Break"
            }
            focusTimePicker.countDownDuration = focusTimerDuration
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Focus"
        
        configureFocusTimePicker()
        configureTaskList()
        configureStartButton()
        configurePauseButton()
        configureBreakButton()
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
    
    // TODO: !!! Implement task list
    private func configureTaskList() {
        
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
    
    private func configurePauseButton() {
        view.addSubview(pauseButton)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.isHidden = true
        
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
    
    private func configureBreakButton() {
        view.addSubview(switchStateButton)
        switchStateButton.translatesAutoresizingMaskIntoConstraints = false
        switchStateButton.isHidden = true
        
        switchStateButton.configuration = .tinted()
        switchStateButton.setTitle("Break", for: .normal)
        switchStateButton.setImage(.init(systemName: "forward.end.fill"), for: .normal)
        switchStateButton.configuration?.imagePadding = 5
        
        switchStateButton.addTarget(self, action: #selector(switchState), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            switchStateButton.bottomAnchor.constraint(equalTo: startButton.bottomAnchor),
            switchStateButton.heightAnchor.constraint(equalToConstant: 50),
            switchStateButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 80),
            switchStateButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // TODO: ! Wrap pause and break button in StackView
    @objc private func startTimer() {
        focusTimerDuration = focusTimePicker.countDownDuration
        timerLabel.text = DateComponentsFormatter().string(from: focusTimerDuration)
        
        // Replace focus duration picker with timer
        focusTimePicker.isHidden = true
        timerLabel.isHidden = false
        
        focusTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        focusTimer.tolerance = 0.2

        startButton.isHidden = true
        pauseButton.isHidden = false
        switchStateButton.isHidden = false
        
        // Configure stack view with pause button and break button
    }
    
    @objc private func fireTimer() {
        if focusTimerDuration == 0 {
            switchState()
            playSound()
        } else {
            focusTimerDuration -= 1
            timerLabel.text = DateComponentsFormatter().string(from: focusTimerDuration)
        }
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
    
    @objc private func switchState() {
        focusTimer.invalidate()
        isFocusState.toggle()
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
