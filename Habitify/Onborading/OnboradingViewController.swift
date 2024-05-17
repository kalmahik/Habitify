//
//  OnboradingViewController.swift
//  Habitify
//
//  Created by kalmahik on 17.05.2024.
//

import UIKit

final class OnboradingViewController: UIViewController {
    private lazy var pageController = UIPageViewController()
    private lazy var currentIndex: Int = 0
    private var pages: [Pages] = Pages.allCases
}

// MARK: - Configure

extension OnboradingViewController {
    
    private func setupViews() {
        view.backgroundColor = .red
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setupPageController() {
        pageController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        pageController.dataSource = self
        pageController.delegate = self
        pageController.view.backgroundColor = .clear
        pageController.view.frame = CGRect(x: 0,y: 0,width: view.frame.width,height: view.frame.height)
        addChild(pageController)
        view.addSubview(pageController.view)
        
        let initialVC = PageViewController(with: pages[0])
        pageController.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
        pageController.didMove(toParent: self)
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
         currentIndex
    }
}
