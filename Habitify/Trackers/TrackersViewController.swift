//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController {

    // MARK: - Private Properties

    static let reloadCollection = Notification.Name(rawValue: "reloadCollection")
    private var observer: NSObjectProtocol?
    private let trackerManager = TrackerManager.shared
    private lazy var searchBar = UISearchBar(frame: .zero)

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(TrackerCell.self, forCellWithReuseIdentifier: TrackerCell.identifier)

        collectionView.register(
            TrackerSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerSectionHeader.identifier
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
        setupNavBar()
        setupDatePicker()
        setupViews()
        setupConstraints()
        addObserver()
    }

    // MARK: - Private Functions

    @objc private func addTapped() {
        present(TrackerTypeModalViewController().wrapWithNavigationController(), animated: true)
    }

    private func addObserver() {
        observer = NotificationCenter.default
            .addObserver(
                forName: TrackersViewController.reloadCollection,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.collectionView.reloadData() // пока оставим так, а уже потом будем релоадить нужные ячейки
            }
    }
}

// MARK: - UICollectionViewDelegate

extension TrackersViewController: UICollectionViewDelegate {
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell
    //        cell?.selectCell()
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //        let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell
    //        cell?.selectCell()
    //    }
}

// MARK: - UICollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (trackerManager.trackers.isEmpty) {
            collectionView.setEmptyMessage("💫", "Что будем отслеживать?")
        } else {
            collectionView.restore()
        }
        return trackerManager.trackers.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trackerManager.trackers[section].trackers.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.identifier, for: indexPath)
        let tracker = trackerManager.trackers[indexPath.section].trackers[indexPath.row]
        guard let trackerCell = cell as? TrackerCell else { return UICollectionViewCell() }
        let trackerCount = trackerManager.trackerRecord[tracker.id]?.count ?? 0
        trackerCell.setupCell(tracker: tracker, count: trackerCount)
        trackerCell.delegate = self
        return trackerCell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let sectionTitle = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TrackerSectionHeader.identifier,
            for: indexPath
        ) as! TrackerSectionHeader
        sectionTitle.setupSection(title: trackerManager.trackers[indexPath.section].title)
        return sectionTitle
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let collectionWidth = collectionView.frame.width
        let cellWidth = (collectionWidth - 16 - 16 - 8) / 2
        return CGSize(width: cellWidth, height: 148)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Insets.horizontalInset
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

extension TrackersViewController: TrackerCellDelegate {
    func didTapPlusButton(_ cell: TrackerCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let tracker = trackerManager.trackers[indexPath.section].trackers[indexPath.row]
        trackerManager.makeRecord(trackerUUID: tracker.id)
    }
}

// MARK: - Date Picker

extension TrackersViewController {

    func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: selectedDate)
        trackerManager.changeSelectedDay(selectedDay: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
}

// MARK: - Configure

extension TrackersViewController {

    private func setupNavBar() {
        navigationItem.title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        add.tintColor = .mainBlack
        navigationItem.leftBarButtonItem = add
        navigationItem.searchController = UISearchController(searchResultsController: nil)


    }

    private func setupViews() {
        view.backgroundColor = .mainWhite
        view.setupView(searchBar)
        view.setupView(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
