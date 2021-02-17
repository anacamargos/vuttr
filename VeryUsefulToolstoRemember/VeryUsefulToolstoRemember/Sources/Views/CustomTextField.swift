//
//  CustomTextField.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 17/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class CustomTextField: CodedView {
    
    // MARK: - Public Properties

    var textField: UITextField {
        get { textInput.self }
        set {
            textInput.self = newValue
        }
    }

    var placeholder: String? {
        get { textInput.placeholder }
        set {
            textInput.placeholder = newValue
        }
    }

    var errorMessageText: String? {
        get { errorMessageLabel.text }
        set {
            errorMessageLabel.text = newValue
        }
    }

    var errorMessageTextIsHidden: Bool {
        get { errorMessageLabel.isHidden }
        set {
            errorMessageLabel.isHidden = newValue
        }
    }

    var keyboardType: UIKeyboardType {
        get { textInput.keyboardType }
        set {
            textInput.keyboardType = newValue
        }
    }

    var isSecureTextEntry: Bool {
        get { textInput.isSecureTextEntry }
        set {
            textInput.isSecureTextEntry = newValue
        }
    }

    var text: String? {
        get { textInput.text }
        set {
            textInput.text = newValue
        }
    }

    var inputContainerHeight: CGFloat {
        get { inputContainer.frame.height }
        set {
            inputContainer.heightAnchor.constraint(equalTo: heightAnchor, constant: newValue).isActive = true
        }
    }
    
    // MARK: - Constants

    private enum ViewMetrics {
        static let inputHeight: CGFloat = 50
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
    }

    // MARK: - View components

    private lazy var textInput: UITextField = {
        let input = UITextField()
        input.font = .themeFont(for: .body, weight: .regular)
        input.textColor = .ink
        input.autocorrectionType = .no
        input.autocapitalizationType = .none
        input.returnKeyType = .done
        input.contentMode = .center
        input.tintColor = .ink
        return input
    }()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .caption, weight: .regular)
        label.textColor = .red
        label.isHidden = true
        label.numberOfLines = .zero
        return label
    }()

    private lazy var inputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.darkestWhite.cgColor
        view.layer.borderWidth = ViewMetrics.borderWidth
        return view
    }()

    private lazy var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Metrics.Spacing.xSmall
        return stackView
    }()

    private let hapticGenerator = UIImpactFeedbackGenerator(style: .light)

    // MARK: - Properties

    public weak var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            textInput.delegate = textFieldDelegate
        }
    }

    // MARK: - Initialziers

    public init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    public func setLoading(_ isLoading: Bool) {
        if isLoading {
            textInput.endEditing(true)
            textInput.isUserInteractionEnabled = false
        } else {
            textInput.isUserInteractionEnabled = true
        }
    }

    public func presentError() {
        inputContainer.layer.borderColor = UIColor.red.cgColor
        inputContainer.layer.borderWidth = ViewMetrics.borderWidth
        errorMessageLabel.isHidden = false
        hapticGenerator.impactOccurred()
    }

    public func resetView() {
        inputContainer.layer.borderColor = UIColor.darkestWhite.cgColor
        inputContainer.layer.borderWidth = ViewMetrics.borderWidth
        errorMessageLabel.isHidden = true
    }
    
    // MARK: - Private Methods

    // MARK: - CodedView

    override public func addSubviews() {
        addSubview(container)
        container.addArrangedSubview(inputContainer)
        container.addArrangedSubview(errorMessageLabel)
        inputContainer.addSubview(textInput)
    }

    override public func constrainSubviews() {
        container.layout(using: [
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        inputContainer.layout(using: [
            inputContainer.heightAnchor.constraint(equalToConstant: ViewMetrics.inputHeight)
        ])
        textInput.layout(using: [
            textInput.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: Metrics.Spacing.small),
            textInput.topAnchor.constraint(equalTo: inputContainer.topAnchor),
            textInput.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -Metrics.Spacing.small),
            textInput.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor)
        ])
    }
}

