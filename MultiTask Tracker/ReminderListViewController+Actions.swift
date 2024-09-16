//
//  ReminderListViewController+Actions.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 16.09.2024.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
