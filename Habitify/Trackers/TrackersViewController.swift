//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController {

    // MARK: - Constants

    static let reloadCollection = Notification.Name(rawValue: "reloadCollection")

    // MARK: - Private Properties

    private var observer: NSObjectProtocol?
    private let trackerManager = TrackerManager.shared
    private lazy var searchBar = UISearchBar(frame: .zero)
    private lazy var collectionWidth = collectionView.frame.width
    private var dataProvider: DataProviderProtocol? {
        DataProvider(Store.shared, delegate: self)
    }

    // MARK: - UIViews

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
        collectionView.backgroundColor = UIColor.mainWhite
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
        observer = NotificationCenter.default.addObserver(
            forName: TrackersViewController.reloadCollection,
            object: nil,
            queue: .main
        ) {
            [weak self] _ in self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if trackerManager.filteredtrackers.isEmpty {
            collectionView.setEmptyMessage("💫", NSLocalizedString("trackersEmpty", comment: ""))
        } else {
            collectionView.restore()
        }
        return trackerManager.filteredtrackers.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trackerManager.filteredtrackers[section].trackers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.identifier, for: indexPath)
        guard let trackerCell = cell as? TrackerCell else { return UICollectionViewCell() }
        trackerCell.delegate = self
        let tracker = trackerManager.filteredtrackers[indexPath.section].trackers[indexPath.row]
        let trackerCount = trackerManager.getTrackerCount(trackerId: tracker.id)
        let isCompleted = trackerManager.isTrackerCompleteForSelectedDay(trackerId: tracker.id) >= 0
        let isPinned = tracker.categoryName == NSLocalizedString("pinnedCategory", comment: "")
        trackerCell.setupCell(tracker: tracker, count: trackerCount, isCompleted: isCompleted, isPinned: isPinned)
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
        sectionTitle.setupSection(title: trackerManager.filteredtrackers[indexPath.section].title)
        return sectionTitle
    }
}

// MARK: - UICollectionViewDelegate

extension TrackersViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackerCell.identifier, for: indexPath)
        guard let trackerCell = cell as? TrackerCell else { return UIContextMenuConfiguration() }
        let tracker = trackerManager.getTracker(by: indexPath)
        let isPinned = tracker.categoryName == NSLocalizedString("pinnedCategory", comment: "")
        return trackerCell.configureContextMenu(indexPath, self, isPinned)
    }
}

// MARK: - DataProviderDelegate

extension TrackersViewController: DataProviderDelegate {
    func didUpdate() { collectionView.reloadData() }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth = (collectionWidth - Insets.horizontalInset.left - Insets.horizontalInset.right - Config.trackerSpaceBetweenCells) / 2
        return CGSize(width: cellWidth, height: Config.trackerCellHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets { Insets.horizontalInset }

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
    ) -> CGSize { CGSize(width: collectionWidth, height: 46) }
}

// MARK: - TrackerCellDelegate

extension TrackersViewController: TrackerCellDelegate {
    func didTapPlusButton(_ cell: TrackerCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let tracker = trackerManager.getTracker(by: indexPath)
        trackerManager.makeRecord(trackerId: tracker.id)
    }

    func didTapPinAction(_ indexPath: IndexPath) {
        trackerManager.pinTracker(with: indexPath)
    }

    func didTapUnpinAction(_ indexPath: IndexPath) {
        trackerManager.unpinTracker(with: indexPath)
    }

    func didTapEditAction(_ indexPath: IndexPath) {
        let tracker = trackerManager.getTracker(by: indexPath)
        trackerManager.resetCurrentTracker(tracker)
        let viewController = TrackerCreationViewController().wrapWithNavigationController()
        self.present(viewController, animated: true)
    }

    func didTapDeleteAction(_ indexPath: IndexPath) {
        let tracker = trackerManager.getTracker(by: indexPath)
        trackerManager.makeRecord(trackerId: tracker.id)
    }
}

// MARK: - Date Picker

extension TrackersViewController {
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        trackerManager.changeSelectedDay(selectedDay: sender.date)
    }
}

// MARK: - Configure

extension TrackersViewController {

    private func setupNavBar() {
        navigationItem.title = NSLocalizedString("trackersTitle", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        add.tintColor = .mainBlack
        navigationItem.leftBarButtonItem = add
        navigationItem.searchController = UISearchController(searchResultsController: nil)
    }

    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.maximumDate = Date()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
    }

    private func setupViews() {
        view.backgroundColor = UIColor.mainWhite
        view.setupView(searchBar)
        view.setupView(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
