//
//  ColorCell.swift
//  Habitify
//
//  Created by kalmahik on 05.04.2024.

import UIKit

final class ColorCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static let identifier = "ColorCell"
    
    // MARK: - Private Properties
    
    private lazy var colorView: UIView = {
        let view = UIView()
        return view
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
    
    func setupCell(color: UIColor) {
        colorView.backgroundColor = color
        colorView.layer.cornerRadius = 8
    }
    
    func selectCell() {
        backgroundColor = .gray
    }
    
    // MARK: - Private Methods

}

extension ColorCell {
    private func setupViews() {
        contentView.setupView(colorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
