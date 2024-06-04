//
//  TrackerCreationViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

enum CollectionSection: Int {
    case header = 0, emoji, color, footer
}

final class TrackerCreationViewController: UIViewController {

    // MARK: - Constants

    static let reloadCollection = Notification.Name(rawValue: "reloadCollection")

    // MARK: - Private Properties

    private let trackerManager = TrackerManager.shared
    private var observer: NSObjectProtocol?
    private lazy var collectionWidth = collectionView.frame.width

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CollectionHeader.self, forCellWithReuseIdentifier: CollectionHeader.identifier)
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.identifier)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
        collectionView.register(CollectionFooter.self, forCellWithReuseIdentifier: CollectionFooter.identifier)
        collectionView.register(
            SectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeader.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.mainWhite
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        addObserver()
    }

    // MARK: - Private Methods

    @objc private func didCreateTapped() {
        trackerManager.createTracker()
        self.presentingViewController?.dismiss(animated: true)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }

    private func addObserver() {
        observer = NotificationCenter.default.addObserver(
            forName: TrackerCreationViewController.reloadCollection,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.collectionView.reloadSections(
                IndexSet(arrayLiteral: CollectionSection.header.rawValue, CollectionSection.footer.rawValue)
            )
        }
    }
}

// MARK: - UICollectionViewDelegate

extension TrackerCreationViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case CollectionSection.emoji.rawValue:
            let emoji = emojiList[indexPath.row]
            trackerManager.changeEmoji(emoji: emoji)
        case CollectionSection.color.rawValue:
            let colorString = colorList[indexPath.row]
            trackerManager.changeColor(color: colorString)
        default:
            return
        }
    }

    // может лучще запретить деселект?
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case CollectionSection.emoji.rawValue:
            trackerManager.changeEmoji(emoji: nil)
        case CollectionSection.color.rawValue:
            trackerManager.changeColor(color: nil)
        default:
            return
        }
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.indexPathsForSelectedItems?
            .filter({ $0.section == indexPath.section })
            .forEach({ collectionView.deselectItem(at: $0, animated: false) })
        return true
    }
}

// MARK: - UICollectionViewDataSource

extension TrackerCreationViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int { collectionData.count }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData[section].data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case CollectionSection.header.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionHeader.identifier, for: indexPath)
            guard let headerCell = cell as? CollectionHeader else { return UICollectionViewCell() }
            let category = trackerManager.getCategory(by: indexPath)
            // TODO: переписать это говнище
            if let trackerId = trackerManager.tracker.id {
                let trackerCount = trackerManager.getTrackerCount(trackerId: trackerId)
                let format = NSLocalizedString("numberOffDays", comment: "")
                let strikeTitle = String.localizedStringWithFormat(format, trackerCount)
                headerCell.setupCell(strikeTitle, category.title)
            } else {
                headerCell.setupCell(nil, nil)
            }
            return headerCell
        case CollectionSection.emoji.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.identifier, for: indexPath)
            let emoji = emojiList[indexPath.row]
            guard let emojiCell = cell as? EmojiCell else { return UICollectionViewCell() }
            emojiCell.setupCell(emoji: emoji)
            let isSelected = emoji == trackerManager.tracker.emoji
            if isSelected { self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: []) }
            return emojiCell
        case CollectionSection.color.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath)
            let colorString = colorList[indexPath.row]
            let color = UIColor(hex: colorString)
            guard let colorCell = cell as? ColorCell, let color else { return UICollectionViewCell() }
            colorCell.setupCell(color: color)
            let isSelected = colorString == trackerManager.tracker.color
            if isSelected { self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: []) }
            return colorCell
        case CollectionSection.footer.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionFooter.identifier, for: indexPath)
            guard let footerCell = cell as? CollectionFooter else { return UICollectionViewCell() }
            footerCell.delegate = self
            footerCell.setupCell()
            return footerCell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch indexPath.section {
        case CollectionSection.header.rawValue:
            return UICollectionReusableView(frame: .zero)
        case CollectionSection.footer.rawValue:
            return UICollectionReusableView(frame: .zero)
        default:
            let sectionTitle = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeader.identifier,
                for: indexPath
            ) as! SectionHeader
            sectionTitle.setupSection(title: collectionData[indexPath.section].title)
            return sectionTitle
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackerCreationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = indexPath.section
        switch section {
        case CollectionSection.header.rawValue:
            return CGSize(width: collectionWidth, height: calculateHeaderHeight())
        case CollectionSection.emoji.rawValue:
            return CGSize(width: 52, height: 52)
        case CollectionSection.color.rawValue:
            return CGSize(width: 52, height: 52)
        case CollectionSection.footer.rawValue:
            return CGSize(width: collectionWidth, height: 60)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        switch section {
        case CollectionSection.header.rawValue:
            return Insets.horizontalInset
        case CollectionSection.emoji.rawValue:
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        case CollectionSection.color.rawValue:
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        case CollectionSection.footer.rawValue:
            return UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20)
        default:
            return Insets.emptyInset
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { 0 }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { 0 }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        switch section {
        case CollectionSection.header.rawValue:
            return .zero
        case CollectionSection.emoji.rawValue:
            return CGSize(width: collectionWidth, height: 74)
        case CollectionSection.color.rawValue:
            return CGSize(width: collectionWidth, height: 74)
        case CollectionSection.footer.rawValue:
            return .zero
        default:
            return .zero
        }
    }

    func calculateHeaderHeight() -> CGFloat {
        var height: CGFloat = 75 + 48 // input and 2 paddings
        if trackerManager.isRegular {
            height += 150 // 2 buttons
        } else {
            height += 75 // 1 button
        }
        if trackerManager.isEditing {
            height += 38 // strike title
        }
        return height
    }
}

// MARK: - CollectionFooterDelegate

extension TrackerCreationViewController: CollectionFooterDelegate {
    func didTapCreate() {
        didCreateTapped()
    }
}

// MARK: - Configure

extension TrackerCreationViewController {

    func setupViews() {
        view.backgroundColor = .mainWhite
        navigationItem.title =
        NSLocalizedString(
            trackerManager.isEditing ? "trackerEditionTitle" :
                trackerManager.isRegular ? "trackerRegularType" : "trackerSingleType",
            comment: ""
        )
        view.setupView(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
