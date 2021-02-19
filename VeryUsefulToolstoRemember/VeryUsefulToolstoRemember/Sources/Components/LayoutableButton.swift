//
//  LayoutableButton.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 19/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

/// Defines a button that has a default layout and enable/disable logic
class LayoutableButton: UIButton {
    
    // MARK: - Dependencies
    
    private let onTappedButtonClosure: (() -> Void)?
    
    // MARK: - Properties

    var layout: ButtonLayout

    override var isEnabled: Bool {
        didSet { isEnabled ? applyLayoutProperties(layout.enabled) : applyLayoutProperties(layout.disabled) }
    }
    
    // MARK: - View components
    
    private let loading = UIActivityIndicatorView(style: .white)

    // MARK: - Initialization

    init(
        frame: CGRect,
        layout: ButtonLayout = .primary,
        onTappedButtonClosure: (() -> Void)? = nil
    ) {
        self.layout = layout
        self.onTappedButtonClosure = onTappedButtonClosure
        super.init(frame: frame)
        applyLayout(layout)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        addSubviews()
        constrainSubviews()
        loading.isHidden = true
        addTarget(self, action: #selector(onTappedButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(loading)
    }
    
    private func constrainSubviews() {
        loading.layout(using: [
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.rightAnchor.constraint(equalTo: rightAnchor, constant: -Metrics.Spacing.small)
        ])
    }
    
    @objc private func onTappedButton(_ sender: UIButton) {
        onTappedButtonClosure?()
        sender.isSelected = !sender.isSelected
        if isEnabled && sender.isSelected {
            sender.backgroundColor = layout.enabled.selectedBackgroundColor
        } else if isEnabled {
            sender.backgroundColor = layout.enabled.backgroundColor
        }
    }
    
    // MARK: - Public methods
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            isUserInteractionEnabled = false
            loading.isHidden = false
            loading.startAnimating()
        } else {
            isUserInteractionEnabled = true
            loading.isHidden = true
            loading.stopAnimating()
        }
    }
}

