//
//  TrackerCreationViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class TrackerCreationViewController: UIViewController {
    
    // MARK: - Private Properties
    
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
        collectionView.backgroundColor = UIColor.white
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    @objc private func didCreateTapped() {
        let categoryIndex = trackerCollectionData.firstIndex{ $0.title == "123"} ?? 0
        trackerCollectionData[categoryIndex].trackers.append(Tracker(newTracker))
        NotificationCenter.default.post(name: TrackersViewController.didChangeNotification, object: self)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension TrackerCreationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell
        cell?.selectCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell
        cell?.selectCell()
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
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionHeader.identifier, for: indexPath)
            guard let headerCell = cell as? CollectionHeader else { return UICollectionViewCell() }
            headerCell.setupCell()
            return headerCell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.identifier, for: indexPath)
            let emoji = emojiList[indexPath.row]
            guard let emojiCell = cell as? EmojiCell else { return UICollectionViewCell() }
            emojiCell.setupCell(emoji: emoji)
            return emojiCell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identifier, for: indexPath)
            let colorString = colorList[indexPath.row]
            let color = UIColor(hex: colorString)
            guard let colorCell = cell as? ColorCell, let color else { return UICollectionViewCell() }
            colorCell.setupCell(color: color)
            return colorCell
        case 3:
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
        case 0: return UICollectionReusableView()
        case 3: return UICollectionReusableView()
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
            case 0: return CGSize(width: collectionView.frame.width, height: 273) // ахтунг! убрать 273!
            case 1: return CGSize(width: 52, height: 52)
            case 2: return CGSize(width: 52, height: 52)
            case 3: return CGSize(width: collectionView.frame.width, height: 60)
            default: return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Set insets for each section here
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // Insets for section 0
        case 1:
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18) // Insets for section 0
        case 2:
            return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18) // Insets for section 0
        case 3:
            return UIEdgeInsets(top: 40, left: 20, bottom: 0, right: 20) // Insets for section 0
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Default insets
        }
    }

    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat { return 0 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { return 0 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        )
        return headerView.systemLayoutSizeFitting(
            CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
}

// MARK: - CollectionFooterDelegate

extension TrackerCreationViewController: CollectionFooterDelegate {
    func didTapCreate() {
        didCreateTapped()
    }
}


extension TrackerCreationViewController {
    
    // MARK: - Configure
    
    func setupViews() {
        view.backgroundColor = .mainWhite
        navigationItem.title = "Новая привычка"
        view.backgroundColor = .white
        view.setupView(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

