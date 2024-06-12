//
//  HabitifyTests.swift
//  HabitifyTests
//
//  Created by kalmahik on 09.06.2024.
//

import XCTest
import SnapshotTesting
@testable import Habitify

final class HabitifyTests: XCTestCase {

    func testLightViewController() {
        let vc = TrackersViewController()
        assertSnapshots(matching: vc, as: [.image(traits: .init(userInterfaceStyle: .light))])
    }

    func testDarkViewController() {
        let vc = TrackersViewController()
        assertSnapshots(matching: vc, as: [.image(traits: .init(userInterfaceStyle: .dark))])
    }
}
