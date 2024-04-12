//
//  CollectionHeader.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class CollectionHeader: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "CollectionHeader"
    
    // MARK: - Private Properties
    
    private lazy var trackerNameInput: UITextField = {
        let textField = TextField()
        textField.placeholder = "Введите название трекера"
        textField.backgroundColor = .mainLigthGray
        textField.layer.cornerRadius = 16
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private lazy var arrowCategoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainLigthGray
        button.setTitleColor(.mainBlack, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitle("Категория", for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)     
        button.contentHorizontalAlignment = .leading
        return button
    }()   
//    
//    private lazy var arrowCategoryButton: ChevronButton = {
//        let button = ChevronButton()
//        button.backgroundColor = .mainLigthGray
//        button.setTitleColor(.mainBlack, for: .normal)
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        return button
//    }()
    
    
    private lazy var arrowScheduleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .mainLigthGray
        button.setTitleColor(.mainBlack, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitle("Расписание", for: .normal)
        return button
    }()
    
    private let titleView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 0
        return stack
    }()
    
    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 0
        stack.layer.cornerRadius = 16
        stack.layer.masksToBounds = true
        return stack
    }()
    
    // MARK: - Initializers
    
    convenience init() {
        self.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Public Methods

    
    // MARK: - Private Methods
    
    @objc private func didTapButton() {
    }
}

extension CollectionHeader {
    private func setupViews() {
        contentView.setupView(trackerNameInput)        
        contentView.setupView(wrapperView)
        wrapperView.addArrangedSubview(arrowCategoryButton)
        wrapperView.addArrangedSubview(arrowScheduleButton)
        layer.borderWidth = 1
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            trackerNameInput.heightAnchor.constraint(equalToConstant: 75),
            trackerNameInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trackerNameInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            wrapperView.heightAnchor.constraint(equalToConstant: 150),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            wrapperView.topAnchor.constraint(equalTo: trackerNameInput.bottomAnchor, constant: 24),
        ])
    }
}
