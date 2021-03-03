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
        
    // MARK: - Properties

    var layout: ButtonLayout

    override var isEnabled: Bool {
        didSet { updateButtonLayout() }
    }
    
    override var isHighlighted: Bool {
        didSet {
            changeBackgroudColor(isHighlighted)
        }
    }
    
    // MARK: - View components
    
    private let loading = UIActivityIndicatorView(style: .white)

    // MARK: - Initialization

    init(
        frame: CGRect = .zero,
        layout: ButtonLayout = .primary
    ) {
        self.layout = layout
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
    }
    
    private func addSubviews() {
        addSubview(loading)
    }
    
    private func constrainSubviews() {
        loading.layout(using: [
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func changeBackgroudColor(_ isHighlighted: Bool) {
        if isEnabled && isHighlighted {
            backgroundColor = layout.enabled.selectedBackgroundColor
        } else if isEnabled {
            backgroundColor = layout.enabled.backgroundColor
        }
    }
    
    private func updateButtonLayout() {
        isEnabled ? applyLayoutProperties(layout.enabled) : applyLayoutProperties(layout.disabled)
    }
    
    // MARK: - Public methods
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            setTitleColor(.clear, for: .normal)
            isUserInteractionEnabled = false
            loading.isHidden = false
            loading.startAnimating()
        } else {
            updateButtonLayout()
            isUserInteractionEnabled = true
            loading.isHidden = true
            loading.stopAnimating()
        }
    }
}

