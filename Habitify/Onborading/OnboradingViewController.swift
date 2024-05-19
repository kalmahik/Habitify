//
//  OnboradingViewController.swift
//  Habitify
//
//  Created by kalmahik on 17.05.2024.
//

import UIKit

final class OnboradingViewController: UIPageViewController {
    private var pages: [Pages] = Pages.allCases
    
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        dataSource = self
        delegate = self
        let initialVC = PageViewController(with: pages[0])
        setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboradingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else {
            return nil
        }
        var index = currentVC.page.rawValue
        if index == 0 {
            return nil
        }
        index -= 1
        return PageViewController(with: pages[index])
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let currentVC = viewController as? PageViewController else {
            return nil
        }
        var index = currentVC.page.rawValue
        if index >= self.pages.count - 1 {
            return nil
        }
        index += 1
        return PageViewController(with: pages[index])
    }
}
