//
//  PageViewController.swift
//  Habitify
//
//  Created by kalmahik on 17.05.2024.
//

import UIKit

final class PageViewController: UIViewController {
    // MARK: - Public Properties

    var page: Pages
    
    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.text = page.name
        label.numberOfLines = Pages.allCases.count
        return label
    }()   
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView(image: page.image)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPage = page.rawValue
        pageControl.currentPageIndicatorTintColor = .mainBlack
        pageControl.pageIndicatorTintColor = .mainBlack.withAlphaComponent(0.3)
        return pageControl
    }()
    
    private lazy var doneButton = Button(
        title: NSLocalizedString("onboardingButton", comment: ""),
        color: .mainBlack,
        style: .normal
    ) {
        RootViewController().switchToApp()
    }
    
    // MARK: - Initializers
    
    init(with page: Pages) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Configure

extension PageViewController {

    private func setupViews() {
        view.setupView(imageView)
        view.setupView(titleLabel)
        view.setupView(pageControl)
        view.setupView(doneButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            pageControl.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }
}
