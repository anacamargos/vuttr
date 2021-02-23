//
//  CustomTextView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class CustomTextView: UIView {
    
    // MARK: - Public Properties

    var textView: UITextView {
        get { textInput.self }
        set {
            textInput.self = newValue
        }
    }

//    var placeholder: String? {
//        get { textInput.placeholder }
//        set {
//            textInput.placeholder = newValue
//        }
//    }

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
    
    // MARK: - Private Properties
    
    private var inputContainerHeight: CGFloat?
    
    // MARK: - Constants

    private enum ViewMetrics {
        static let inputHeight: CGFloat = 40
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
    }

    // MARK: - View components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .body, weight: .semibold)
        label.textColor = .ink
        label.numberOfLines = .zero
        return label
    }()

    private lazy var textInput: UITextView = {
        let input = UITextView()
        input.font = .themeFont(for: .body, weight: .regular)
        input.textColor = .ink
        input.autocorrectionType = .no
        input.autocapitalizationType = .none
        input.returnKeyType = .done
        input.contentMode = .center
        input.tintColor = .ink
        input.isUserInteractionEnabled = true
        input.backgroundColor = .darkerWhite
        return input
    }()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .caption, weight: .regular)
        label.textColor = .red
        label.isHidden = true
        label.numberOfLines = .zero
        label.textAlignment = .right
        return label
    }()

    private lazy var inputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .darkerWhite
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

    // MARK: - Initialziers

    init(
        titleText: String,
        inputContainerHeight: CGFloat? = nil
    ) {
        self.inputContainerHeight = inputContainerHeight
        super.init(frame: .zero)
        titleLabel.text = titleText
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    func setLoading(_ isLoading: Bool) {
        if isLoading {
            textInput.endEditing(true)
            textInput.isUserInteractionEnabled = false
        } else {
            textInput.isUserInteractionEnabled = true
        }
    }

    func presentError() {
        inputContainer.layer.borderColor = UIColor.red.cgColor
        inputContainer.backgroundColor = .mostLightestRed
        textInput.backgroundColor = .mostLightestRed
        errorMessageLabel.isHidden = false
        hapticGenerator.impactOccurred()
    }

    func resetView() {
        inputContainer.layer.borderColor = UIColor.darkestWhite.cgColor
        inputContainer.backgroundColor = .darkerWhite
        textInput.backgroundColor = .darkerWhite
        errorMessageLabel.isHidden = true
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        addSubviews()
        constrainSubviews()
        textInput.delegate = self
    }

    // MARK: - CodedView

    private func addSubviews() {
        addSubview(container)
        addSubview(titleLabel)
        container.addArrangedSubview(inputContainer)
        container.addArrangedSubview(errorMessageLabel)
        inputContainer.addSubview(textInput)
    }

    private func constrainSubviews() {
        titleLabel.layout(using: [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        container.layout(using: [
            container.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.Spacing.xSmall),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        if let inputContainerHeight = inputContainerHeight {
            inputContainer.layout(using: [
                inputContainer.heightAnchor.constraint(equalToConstant: inputContainerHeight)
            ])
        } else {
            inputContainer.layout(using: [
                inputContainer.heightAnchor.constraint(equalToConstant: ViewMetrics.inputHeight)
            ])
        }
        textInput.layout(using: [
            textInput.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: Metrics.Spacing.small),
            textInput.topAnchor.constraint(equalTo: inputContainer.topAnchor),
            textInput.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -Metrics.Spacing.small),
            textInput.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor)
        ])
    }
}

extension CustomTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputContainer.layer.borderColor = UIColor.mostDarkestWhite.cgColor
        inputContainer.backgroundColor = .darkestWhite
        textInput.backgroundColor = .darkestWhite
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        inputContainer.layer.borderColor = UIColor.darkestWhite.cgColor
        inputContainer.backgroundColor = .darkerWhite
        textInput.backgroundColor = .darkerWhite
    }
}

