//
//  CollectionFooter.swift
//  Habitify
//
//  Created by kalmahik on 09.04.2024.
//

import UIKit

final class CollectionFooter: UICollectionViewCell {

    // MARK: - Constants

    static let identifier = "CollectionFooter"
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public Properties

    weak var delegate: CollectionFooterDelegate?
    
    // MARK: - UIViews

    private let footerLabel = UILabel()

    private let trackerManager = TrackerManager.shared

    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - Private Functions

    private lazy var cancelButton = Button(
        title: NSLocalizedString("cancelButton", comment: ""), color: .mainRed, style: .flat
    ) {
        self.parentViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }

    private lazy var creationButton = Button(
        title: NSLocalizedString("creationButton", comment: ""), color: .mainBlack, style: .normal
    ) {
        self.delegate?.didTapCreate()
    }

    // MARK: - Initializers

    func setupCell() {
        creationButton.isEnabled = trackerManager.isValid
    }
}

extension CollectionFooter {
    private func setupViews() {
        contentView.setupView(wrapperView)
        wrapperView.addArrangedSubview(cancelButton)
        wrapperView.addArrangedSubview(creationButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            wrapperView.heightAnchor.constraint(equalToConstant: 60),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
