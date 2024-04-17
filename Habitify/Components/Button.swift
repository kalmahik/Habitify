//
//  EmptyTrackersView.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

enum ButtonStyle {
    case normal
    case flat
}

final class Button: UIButton {
    // как сделать поля опциональными
    var action: () -> Void = {} //чет какая-то дичь, может можно проще?
    var color: UIColor = .mainBlack
    var style: ButtonStyle = .normal
    
    convenience init(
        title: String,
        color: UIColor,
        style: ButtonStyle,
        action: @escaping () -> Void
    ) {
        self.init()
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        self.action = action
        self.color = color
        self.style = style
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
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = style == .flat ? .mainWhite : color
        button.setTitleColor(style == .flat ? color : .mainWhite, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
        return button
    }()
    
    // попахивает говном
    @objc private func didTapButton() {
        action()
    }
    
    private func setupViews() {
        setupView(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
