//
//  String+Extension.swift
//  Habitify
//
//  Created by kalmahik on 24.04.2024.
//

import UIKit

extension String {
    func makeImage(size: Int = 80) -> UIImage? {
        let imageSize = CGSize(width: size, height: size)
        let scale = imageSize.width * 0.9
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: imageSize)
        UIRectFill(CGRect(origin: .zero, size: imageSize))
        self.draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: scale)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
