//
//  TrackersViewController.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.
//

import UIKit

final class NewHabitViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let habits: [String] = ["1", "2", "3", "4"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HumanViewCell.self, forCellWithReuseIdentifier: HumanViewCell.identifier)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Configure

    private func setupView() {
        view.backgroundColor = .mainWhite
        navigationItem.title = "Новая привычка"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

        ])
    }
    
    @objc private func addTapped() {
    }
}

// MARK: - UICollectionViewDelegate

extension NewHabitViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - UICollectionViewDataSource

extension NewHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumanViewCell.identifier, for: indexPath)
        let human = habits[indexPath.row]
        guard let humanCell = cell as? HumanViewCell else { return UICollectionViewCell() }
        let imageName = human.count > 5 ? "infected" : "healthy"
        humanCell.configCell(imageName: imageName)
        return humanCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 100)
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
}

extension NewHabitViewController {
    func addSubViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

