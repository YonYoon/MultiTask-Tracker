//
//  ProfileTableViewCell.swift
//  MultiTask Tracker
//
//  Created by cloud on 07.08.2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // MARK: - UI Elements

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()

    private let cellSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = false
        return switchControl
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.addSubview(cellSwitch)

        // Constraints for label
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 56),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        // Constraints for iconImageView
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])

        // Constraints for cellSwitch (only for section 1)
        cellSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cellSwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),            cellSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Public Methods

    func configure(with title: String, icon: UIImage?, isSwitchSection: Bool) {
        label.text = title
        iconImageView.image = icon
        cellSwitch.isHidden = !isSwitchSection

    }
}


