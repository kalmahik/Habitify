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

enum ButtonState {
    case normal
    case disabled
}

final class Button: UIButton {
    // как сделать поля опциональными
    var action: () -> Void = {} //чет какая-то дичь, может можно проще?
    
    var color: UIColor = .mainBlack {
        didSet {
            backgroundColor = color
        }
    }
    
    var disabledColor: UIColor = .mainGray
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = color
            }
            else {
                backgroundColor = disabledColor
                layer.borderColor = UIColor.mainGray.cgColor
            }
        }
    }
    
    var style: ButtonStyle = .normal

    init(
        title: String,
        color: UIColor,
        style: ButtonStyle,
        action: @escaping () -> Void
    ) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        self.action = action
        self.color = color
        self.style = style
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    // попахивает говном
    @objc private func didTapButton() {
        action()
    }
    
    private func setupViews() {
        backgroundColor = style == .flat ? .mainWhite : color
        setTitleColor(style == .flat ? color : .mainWhite, for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = isEnabled ? color.cgColor : UIColor.mainGray.cgColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
