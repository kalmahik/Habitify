import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - UIViewController

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
    }
    
    // MARK: - Configure

    private func setupViewControllers() {
        let trackersTab = TrackersViewController()
        let trackersNavigationController = UINavigationController(rootViewController: trackersTab)
        trackersNavigationController.navigationBar.prefersLargeTitles = true
        let statisticsTab = StatisticsViewController()

        trackersTab.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackersTab"),
            selectedImage: UIImage(named: "trackersTab")
        )

        statisticsTab.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "statisticsTab"),
            selectedImage: UIImage(named: "statisticsTab")
        )

        tabBar.tintColor = .mainBlue
        viewControllers = [trackersNavigationController, statisticsTab]

        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .mainWhite
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {}
}
