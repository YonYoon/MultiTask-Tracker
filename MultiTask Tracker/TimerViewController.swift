//
//  TimerViewController.swift
//  MultiTask Tracker
//
//  Created by Sam K on 27.07.2024.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {

    var timer: Timer?
    var isTimerRunning = false
    var isTimerPaused = false
    var isBreakTime = false
    var timeRemaining = 1500 // 25 минут в секундах
    var selectedTime = 1500 // Это значение будет передано с первого экрана
    var player: AVAudioPlayer?

    let defaultBackgroundColor: UIColor = .init(_colorLiteralRed: 240/255, green: 95/255, blue: 106/255, alpha: 1.0)
    let breakBackgroundColor: UIColor = .accent
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "25 min"
        label.textColor = .white
        label.font = .systemFont(ofSize: 80, weight: .thin)
        label.textAlignment = .center
        return label
    }()

    let pauseButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = .systemRed
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .thin)
        button.setTitle("Tap to Pause", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = defaultBackgroundColor
        timeRemaining = selectedTime // устанавливаем начальное время
        setupLayout()
        setupButtonActions()
        updateTimerLabel()
        startTimer()
    }
    
    func setupLayout() {
        view.addSubview(timeLabel)
        view.addSubview(pauseButton)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            pauseButton.widthAnchor.constraint(equalToConstant: 250),
            pauseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    func setupButtonActions() {
        pauseButton.addTarget(self, action: #selector(pauseOrResumeTimer), for: .touchUpInside)
    }
    
    @objc func pauseOrResumeTimer() {
        if isTimerRunning {
            if isTimerPaused {
                resumeTimer()
            } else {
                stopTimer()
            }
        } else {
            startTimer()
        }
    }

    func startTimer() {
        if isTimerRunning { return }
        isTimerRunning = true
        isTimerPaused = false
        pauseButton.setTitle("Tap to Pause", for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateTimerLabel()
        } else {
            timer?.invalidate()
            timer = nil
            isTimerRunning = false

            if isBreakTime {
                // Перерыв завершен, возвращаемся к рабочему времени
                timeRemaining = selectedTime
                isBreakTime = false
                view.backgroundColor = defaultBackgroundColor
                pauseButton.setTitle("Tap to Pause", for: .normal)
                playSound()
                startTimer() // Запускает таймер заново
            } else {
                // Рабочая сессия завершена, начинаем перерыв
                playSound()
                startBreak()
            }
        }
    }
    
    func updateTimerLabel() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }

    @objc func stopTimer() {
        timer?.invalidate()
        isTimerRunning = false
        isTimerPaused = true
        pauseButton.setTitle("Tap to Resume", for: .normal)
        playSound()
        // Здесь можно добавить любые дополнительные действия при остановке таймера
    }
    
    func resumeTimer() {
        if !isTimerRunning && isTimerPaused {
            isTimerRunning = true
            isTimerPaused = false
            pauseButton.setTitle("Tap to Pause", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    func startBreak() {
        timeRemaining = 300
        isBreakTime = true
        view.backgroundColor = breakBackgroundColor
        pauseButton.setTitle("Tap to Start Work", for: .normal)
        startTimer()
    }
    //проверка
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "sound", ofType: "mp3") else {
            print("Sound file not found")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Audio playback error: \(error.localizedDescription)")
        }
    }
}
