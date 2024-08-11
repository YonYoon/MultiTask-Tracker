//
//  ToDoViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Task list хранилище
    var todos: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor (named: "AccentColor")
        navigationController?.navigationBar.isHidden = true
        view.addSubview(tableView)
        constraintTableView()
        configureTableView()
        todos = PersistenceManager.shared.read()
        setupAddButton()
    }
    


    // MARK: - Button "+"
    func setupAddButton() {
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "AddButton"), for: .normal)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        //addButton.tintAdjustmentMode = .normal
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30), // Отступ от нижней границы экрана
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30), // Отступ от правой границы экрана
            addButton.widthAnchor.constraint(equalToConstant: 60), // Ширина кнопки (изменено)
            addButton.heightAnchor.constraint(equalToConstant: 60), // Высота кнопки (изменено)
        ])
    }
    
    @objc func didTapAddButton() {
        openAlert()
    }
    
    // MARK: - Alert
    // Функция оповещения (добавляет новую задачу в список ToDo и обновляет страницу)
    func addTodo(name: String) {
        todos.append(ToDoItem(name: name))
        tableView.reloadData()
        PersistenceManager.shared.write(list: todos) // Сохранение после добавления
    }

    @objc func openAlert() {
        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in if let textName = alert.textFields?.first?.text {
            self.addTodo(name: textName)
        }
    }
    alert.addAction(saveButton)
    let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
    alert.addAction(cancelButton)
        
    present(alert, animated: true)
    }

// MARK: - Table View
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func constraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // Отступ сверху
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20), // Отступ слева
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // Отступ снизу
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20) // Отступ справа
        ])
        }

    // Устанавливает текущий контроллер в качестве источника данных и делегата таблицы, регистрирует тип ячейки и отключает выбор ячеек
    func configureTableView() {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
            tableView.allowsSelection = true
            tableView.separatorStyle = .none // Убираем линии между строками
            //tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // Добавляем отступ сверху
            tableView.layer.cornerRadius = 20 // Округляем углы
            //tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Округляем только верхние углы
            }
    
    // Возвращает количество строк в таблице (равное количеству элементов в todos)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    // Возвращает ячейку для указанной строки в таблице. Заполняет ячейку данными из todos
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "todoCell") // Используем .default стиль
        let todoItem = todos[indexPath.row]
        cell.textLabel?.text = todoItem.name
    
        // Устанавливаем галочку, если задача выполнена
        cell.accessoryType = todoItem.completed ? .checkmark : .none

        return cell
    }

    // Метод для обработки нажатия на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].completed.toggle() // Изменяем статус выполнения задачи
        tableView.reloadRows(at: [indexPath], with: .automatic) // Обновляем таблицу
        PersistenceManager.shared.write(list: todos) // Сохраняем изменения
    }
    
    // Обрабатывает действие удаления строки в таблице. Удаляет задачу из todos и обновляет таблицу
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistenceManager.shared.write(list: todos)
            }
        }
    // Свайп для удаления
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}
