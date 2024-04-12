//
//  EmptyTrackersView.swift
//  Habitify
//
//  Created by Murad Azimov on 06.04.2024.
//

import UIKit

final class ChevronButton: UIButton {
    var action: (() -> Void)? //чет какая-то дичь, может можно проще?
    
    convenience init(title: String, action: @escaping () -> Void) {
        self.init()
        self.title.text = title
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
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .mainBlack
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .mainBlack
        return image
    }()
    
    private lazy var wrapper: UIView = {
        let view = UIView()
        button.backgroundColor = .mainLigthGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        button.backgroundColor = .mainLigthGray
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let wrapperView: UIStackView =  {
        let stack: UIStackView = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 0
        stack.layer.cornerRadius = 16
        stack.layer.masksToBounds = true
        return stack
    }()
    
    // попахивает говном
    @objc private func didTapButton() {
        guard let action else { return }
        action()
    }
    
    private func setupViews() {
        wrapper.setupView(title)
        wrapper.setupView(chevronImage)
        button.setupView(wrapper)
        setupView(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
