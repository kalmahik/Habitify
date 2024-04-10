//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class NewHabitViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 100)
        var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: EmojiCell.identifier)
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identifier)
        collectionView.register(CollectionHeader.self, forCellWithReuseIdentifier: CollectionHeader.identifier)
        collectionView.register(CollectionFooterView.self, forCellWithReuseIdentifier: CollectionFooterView.identifier)
        
        collectionView.register(
            SectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeader.identifier
        )
        
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
    
    @objc private func addTapped() {
    }
    
    func getCellWidth() -> CGFloat {
        let collectionViewWidth = collectionView.frame.width
        let numberOfColumns = 6
        let itemWidth = collectionViewWidth / CGFloat(numberOfColumns)
        return itemWidth
    }
}

// MARK: - UICollectionViewDelegate

extension NewHabitViewController: UICollectionViewDelegate {
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

extension NewHabitViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return emojiList.count
        case 2: return colorList.count
        default: return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionHeader.identifier, for: indexPath)
            guard let headerCell = cell as? CollectionHeader else { return UICollectionViewCell() }
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
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if (indexPath.section == 0) {
            return UICollectionReusableView()
        }
        let sectionTitle = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeader.identifier,
            for: indexPath
        ) as! SectionHeader
        sectionTitle.setupSection(title: "Здесь находится Supplementary view")
        return sectionTitle
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = indexPath.section
        switch section {
            case 0: return CGSize(width: collectionView.frame.width, height: 250)
            case 1: return CGSize(width: 52, height: 52)
            case 2: return CGSize(width: 52, height: 52)
            default: return CGSize(width: 0, height: 0)
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

extension NewHabitViewController {
    
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

