//
//  ReminderListViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class ReminderListViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Reminder.ID>!
    
    var reminders = Reminder.sampleData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        configureCollectionView()
        configureDataSource()
        updateSnapshot()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ReminderCell")
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) in
            let reminder = self.reminder(withId: id)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
            contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
                forTextStyle: .caption1)
            cell.contentConfiguration = contentConfiguration
            
            var doneButtonConfiguration = self.doneButtonConfiguration(for: reminder)
            doneButtonConfiguration.tintColor = .accent
            cell.accessibilityCustomActions = [self.doneButtonAccessibilityAction(for: reminder)]
            cell.accessibilityValue = reminder.isComplete ? self.reminderCompletedValue : self.reminderNotCompletedValue
            cell.accessories = [.customView(configuration: doneButtonConfiguration), .disclosureIndicator()]
            
            let backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
            cell.backgroundConfiguration = backgroundConfiguration
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>(collectionView: collectionView) { collectionView, indexPath, reminder in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: reminder)
        }
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
    }
}

extension ReminderListViewController: UICollectionViewDelegate {
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    
    
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map { $0.id })
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        return action
    }
}

#Preview {
    let navigationController = UINavigationController(rootViewController: ReminderListViewController())
    return navigationController
}
