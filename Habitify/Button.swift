//
//  EmptyTrackersView.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

final class Button: UIButton {
    var action: (() -> Void)? //чет какая-то дичь, может можно проще?
    
    convenience init(title: String, action: @escaping () -> Void) {
        self.init()
        button.setTitle(title, for: .normal)
        self.action = action
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
        button.backgroundColor = .mainBlack
        button.setTitleColor(.mainWhite, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.layer.cornerRadius = 16
        return button
    }()
    
    // попахивает говном
    @objc private func didTapButton() {
        guard let action else { return }
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
