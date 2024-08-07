//
//  PomodoroViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 22.07.2024.
//

    import UIKit

    class PomodoroViewController: UIViewController {
        
        var isTimerRunning = false
        var isTimerPaused = false
        var selectedTime = 1500 {
            didSet {
                checkButtonVisibility()
                updateSelectedTimeLabel()
            }
        }
        
        let whiteView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 30
            return view
        }()
        
        let purpleView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemPurple
            view.layer.cornerRadius = 20
            view.bringSubviewToFront(view)
            return view
        }()
        
        let timeLabel: UILabel = {
            let label = UILabel()
            label.text = "25 min"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            return label
        }()
        
        let startButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .init(_colorLiteralRed: 240/255, green: 95/255, blue: 106/255, alpha: 1.0)
            button.tintColor = .white
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            button.setTitle("Start Focus", for: .normal)
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
            return button
        }()
        
        let increaseButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle(">", for: .normal)
            button.tintColor = .white
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.addTarget(self, action: #selector(increaseTime), for: .touchUpInside)
            return button
        }()
        
        let decreaseButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("<", for: .normal)
            button.tintColor = .white
            button.titleLabel?.font = .systemFont(ofSize: 20)
            button.addTarget(self, action: #selector(decreaseTime), for: .touchUpInside)
            return button
        }()
        
        let statisticsButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .init(_colorLiteralRed: 34/255, green: 182/255, blue: 159/255, alpha: 1.0)
            button.tintColor = .white
            button.titleLabel?.font = .boldSystemFont(ofSize: 20)
            button.setTitle("Your Statistics", for: .normal)
            button.layer.cornerRadius = 20
            return button
        }()
        
        let focusTimeLabel: UILabel = {
            let label = UILabel()
            label.text = "Focus Time"
            label.textColor = .white
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .left
            return label
        }()
        
        let pomodoroImageView: UIImageView = {
            if let image = UIImage(named: "pomodoroImage") {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            } else {
                return UIImageView() // Возвращаем пустой UIImageView, если изображение не найдено
            }
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .init(_colorLiteralRed: 240/255, green: 95/255, blue: 106/255, alpha: 1.0)
        setupLayout()
        
        whiteView.bringSubviewToFront(purpleView)
    }
    
    func setupLayout() {
        
        view.addSubview(whiteView)
        view.addSubview(purpleView)
        view.addSubview(pomodoroImageView)
        view.addSubview(focusTimeLabel)
        view.addSubview(timeLabel)
        view.addSubview(startButton)
        view.addSubview(increaseButton)
        view.addSubview(decreaseButton)
        view.addSubview(statisticsButton)
        
        
        // Отключаем автоматическое создание ограничений
        timeLabel.translatesAutoresizingMaskIntoConstraints         = false
        startButton.translatesAutoresizingMaskIntoConstraints       = false
        increaseButton.translatesAutoresizingMaskIntoConstraints    = false
        decreaseButton.translatesAutoresizingMaskIntoConstraints    = false
        whiteView.translatesAutoresizingMaskIntoConstraints         = false
        purpleView.translatesAutoresizingMaskIntoConstraints        = false
        focusTimeLabel.translatesAutoresizingMaskIntoConstraints    = false
        statisticsButton.translatesAutoresizingMaskIntoConstraints  = false
        pomodoroImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // MARK: VIEWS' CONSTRAINTS
            
            whiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purpleView.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 30),
            purpleView.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 20),
            purpleView.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -20),
            purpleView.heightAnchor.constraint(equalToConstant: 90),
            
            pomodoroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pomodoroImageView.widthAnchor.constraint(equalToConstant: 200),
            pomodoroImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Устанавливаем констрейнты для центрирования pomodoroImageView между view1 и view2
            pomodoroImageView.topAnchor.constraint(equalTo: statisticsButton.bottomAnchor, constant: 0),
            pomodoroImageView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: 0),
            pomodoroImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            focusTimeLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 20),
            focusTimeLabel.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor),
            focusTimeLabel.widthAnchor.constraint(equalToConstant: 160),
            focusTimeLabel.heightAnchor.constraint(equalToConstant: 50),
            
            timeLabel.trailingAnchor.constraint(equalTo: increaseButton.leadingAnchor, constant: -1),
            timeLabel.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor),
            
            // MARK: BUTTONS' CONSTRAINTS
            
            increaseButton.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -20),
            increaseButton.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor),
            
            decreaseButton.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -1),
            decreaseButton.centerYAnchor.constraint(equalTo: purpleView.centerYAnchor),
            
            statisticsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticsButton.topAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: 30),
            statisticsButton.widthAnchor.constraint(equalToConstant: 200),
            statisticsButton.heightAnchor.constraint(equalToConstant: 50),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: -30),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 90)
            ])
    }
    
        @objc func goToNextPage() {
            let timerViewController = TimerViewController()
            timerViewController.selectedTime = selectedTime
            navigationController?.pushViewController(timerViewController, animated: true)
        }
    
    @objc func increaseTime() {
        if selectedTime < 3600 {
            selectedTime += 300
            updateSelectedTimeLabel()
        }
    }
    
    @objc func decreaseTime() {
        if selectedTime > 600 {
            selectedTime -= 300
            updateSelectedTimeLabel()
        }
    }
    
    func checkButtonVisibility() {
        decreaseButton.isHidden = isTimerRunning || selectedTime <= 600
        increaseButton.isHidden = isTimerRunning || selectedTime >= 3600
    }
    
    func updateSelectedTimeLabel() {
        let minutes = selectedTime / 60 // Вычисляем количество минут
        timeLabel.text = "\(minutes) min"
    }
}
