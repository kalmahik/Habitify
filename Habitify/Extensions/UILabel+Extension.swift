//
//  UILabel+Extension.swift
//  Habitify
//
//  Created by kalmahik on 11.04.2024.
//

import UIKit

extension UILabel {
    func makeGray() -> UIImageView {
        self.textAlignment = .center
        let image = UIImage.imageWithLabel(label: self)
        let tonalFilter = CIFilter(name: "CIPhotoEffectTonal")
        let imageToBlur = CIImage(cgImage: image.cgImage!)
        tonalFilter?.setValue(imageToBlur, forKey: kCIInputImageKey)
        let outputImage: CIImage? = tonalFilter?.outputImage
        let tonalImageView = UIImageView(frame: self.frame)
        tonalImageView.image = UIImage(ciImage: outputImage ?? CIImage())
        return tonalImageView
    }
}

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
