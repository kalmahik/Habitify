//
//  HumanViewCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class TrackerCell: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = "TrackerCell"

    // MARK: - Public Properties

    weak var delegate: TrackerCellDelegate?

    var isPinned: Bool = false

    // MARK: - UIViews

    private lazy var cellBackgroundView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var quantityManagementView = UIView()

    private lazy var emojiWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .mainWhite30
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var emoji = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    private lazy var titleLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    private lazy var quantityLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    private lazy var actionButton = UIButton.systemButton(
        with: UIImage(),
        target: self,
        action: #selector(didTapActionButton)
    )

    private lazy var pinImage = UIImageView(image: UIImage(named: "pin"))

    // MARK: - Public Methods

    func setupCell(tracker: Tracker, count: Int, isCompleted: Bool, isPinned: Bool) {
        let color = UIColor(hex: tracker.color)
        cellBackgroundView.backgroundColor = color
        emoji.text = tracker.emoji
        pinImage.isHidden = !isPinned
        self.isPinned = isPinned
        actionButton.tintColor = color
        actionButton.layer.opacity = isCompleted ? 0.3 : 1
        actionButton.setImage(UIImage(named: isCompleted ? "done" : "plus"), for: .normal)
        titleLabel.text = tracker.name
        let format = NSLocalizedString("number_of_days", comment: "")
        let message = String.localizedStringWithFormat(format, count)
        quantityLabel.text = message
        setupViews()
        setupConstraints()
    }

    func customPreview() -> UIViewController {
        let vc = UIViewController()
        vc.view = cellBackgroundView
        cellBackgroundView.frame = CGRect(x: 0, y: 0, width: 200, height: 90)
        vc.preferredContentSize = cellBackgroundView.frame.size
        return vc
    }

    // MARK: - Private Methods

    @objc private func didTapActionButton() {
        delegate?.didTapPlusButton(self)
    }
}

extension TrackerCell {
    func configureContextMenu(indexPath: IndexPath) -> UIContextMenuConfiguration {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let pin = UIAction(
                title: NSLocalizedString("contextActionPin", comment: ""),
                image: nil,
                identifier: nil,
                discoverabilityTitle: nil,
                state: .off
            ) { _ in
//                delegate?.pinTracker(with: indexPath)
                self.delegate?.didTapPinAction(self)
            }
            let unpin = UIAction(
                title: NSLocalizedString("contextActionUnpin", comment: ""),
                image: nil,
                identifier: nil,
                discoverabilityTitle: nil,
                state: .off
            ) { _ in
            }
            let edit = UIAction(
                title: NSLocalizedString("contextActionEdit", comment: ""),
                image: nil,
                identifier: nil,
                discoverabilityTitle: nil,
                state: .off
            ) { _ in
                print("delete button clicked")
            }
            let delete = UIAction(
                title: NSLocalizedString("contextActionDelete", comment: ""),
                image: nil,
                identifier: nil,
                discoverabilityTitle: nil,
                attributes: .destructive,
                state: .off
            ) { _ in
                print("delete button clicked")
            }
            return UIMenu(
                title: "",
                image: nil,
                identifier: nil,
                options: UIMenu.Options.displayInline,
                children: [self.isPinned ? unpin : pin, edit, delete])
        }
        return context
    }
}

// MARK: - Configure

extension TrackerCell {
    private func setupViews() {
        contentView.setupView(cellBackgroundView)
        contentView.setupView(quantityManagementView)
        emojiWrapper.setupView(emoji)
        cellBackgroundView.setupView(emojiWrapper)
        cellBackgroundView.setupView(titleLabel)
        cellBackgroundView.setupView(pinImage)
        quantityManagementView.setupView(quantityLabel)
        quantityManagementView.setupView(actionButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 90),

            quantityManagementView.topAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor),
            quantityManagementView.heightAnchor.constraint(equalToConstant: 58),
            quantityManagementView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            quantityManagementView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            emojiWrapper.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 12),
            emojiWrapper.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            emojiWrapper.heightAnchor.constraint(equalToConstant: 24),
            emojiWrapper.widthAnchor.constraint(equalToConstant: 24),

            emoji.centerXAnchor.constraint(equalTo: emojiWrapper.centerXAnchor),
            emoji.centerYAnchor.constraint(equalTo: emojiWrapper.centerYAnchor),

            pinImage.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 12),
            pinImage.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -4),

            titleLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -12),

            quantityLabel.topAnchor.constraint(equalTo: quantityManagementView.topAnchor, constant: 16),
            quantityLabel.leadingAnchor.constraint(equalTo: quantityManagementView.leadingAnchor, constant: 12),

            actionButton.topAnchor.constraint(equalTo: quantityManagementView.topAnchor, constant: 8),
            actionButton.trailingAnchor.constraint(equalTo: quantityManagementView.trailingAnchor, constant: -12),
            actionButton.widthAnchor.constraint(equalToConstant: 34),
            actionButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
