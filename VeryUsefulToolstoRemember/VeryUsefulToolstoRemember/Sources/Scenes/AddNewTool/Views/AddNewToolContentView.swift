//
//  AddNewToolContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol AddNewToolContentViewProtocol: AnyObject {
    func setupLoadingState(_ isLoading: Bool)
}

final class AddNewToolContentView: CodedView {

    // MARK: - Constants

    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 4.0
        static let closeButtonSize: CGFloat = 16.0
        static let descriptionTextFieldHeight: CGFloat = 70
    }

    // MARK: - Dependencies

    private let onTappedCloseButtonClosure: () -> Void
    private let onTappedAddToolButtonClosure: (AddNewTool.Request) -> Void

    // MARK: - View Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.text = L10n.AddNewTool.addNewToolTitle
        label.font = .themeFont(for: .subtitle, weight: .semibold)
        label.numberOfLines = .zero
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.close, for: .normal)
        return button
    }()

    private let toolNameTextField: CustomTextField = {
        let textField = CustomTextField(titleText: L10n.AddNewTool.toolName)
        textField.errorMessageText = L10n.AddNewTool.requiredField
        return textField
    }()

    private let toolLinkTextField: CustomTextField = {
        let textField = CustomTextField(titleText: L10n.AddNewTool.toolLink)
        textField.errorMessageText = L10n.AddNewTool.requiredField
        return textField
    }()

    private let toolDescriptionTextField: CustomTextView = {
        let textField = CustomTextView(titleText: L10n.AddNewTool.toolDescription, inputContainerHeight: ViewMetrics.descriptionTextFieldHeight)
        textField.errorMessageText = L10n.AddNewTool.requiredField
        return textField
    }()

    private let toolTagsTextField: CustomTextField = {
        let textField = CustomTextField(titleText: L10n.AddNewTool.tags)
        textField.errorMessageText = L10n.AddNewTool.requiredField
        return textField
    }()

    private let addToolButton: LayoutableButton = {
        let button = LayoutableButton(layout: .primary)
        button.setTitle(L10n.AddNewTool.addTool, for: .normal)
        button.contentEdgeInsets = .init(top: Metrics.Spacing.small, left: Metrics.Spacing.base, bottom: Metrics.Spacing.small, right: Metrics.Spacing.base)
        return button
    }()

    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        return view
    }()

    // MARK: - Initializers

    init(
        frame: CGRect = .zero,
        onTappedCloseButtonClosure: @escaping () -> Void,
        onTappedAddToolButtonClosure: @escaping (AddNewTool.Request) -> Void
    ) {
        self.onTappedCloseButtonClosure = onTappedCloseButtonClosure
        self.onTappedAddToolButtonClosure = onTappedAddToolButtonClosure
        super.init(frame: frame)
        configureView()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(closeButton)
        container.addSubview(toolNameTextField)
        container.addSubview(toolLinkTextField)
        container.addSubview(toolDescriptionTextField)
        container.addSubview(toolTagsTextField)
        container.addSubview(addToolButton)
    }

    override func constrainSubviews() {
        constrainContainer()
        constrainTitleLabel()
        constrainCloseButton()
        constrainToolNameTextField()
        constrainToolLinkTextField()
        constrainToolDescriptionTextField()
        constraintoolTagsTextField()
        constrainAddToolButton()
    }

    // MARK: - Private Methods

    private func constrainContainer() {
        container.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
        container.anchorCenterYToSuperview()
    }

    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            trailing: closeButton.leadingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }

    private func constrainCloseButton() {
        closeButton.anchor(
            top: container.topAnchor,
            trailing: container.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small,
            widthConstant: ViewMetrics.closeButtonSize,
            heightConstant: ViewMetrics.closeButtonSize
        )
    }

    private func constrainToolNameTextField() {
        toolNameTextField.anchor(
            top: titleLabel.bottomAnchor,
            leading: container.leadingAnchor,
            trailing: container.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }

    private func constrainToolLinkTextField() {
        toolLinkTextField.anchor(
            top: toolNameTextField.bottomAnchor,
            leading: toolNameTextField.leadingAnchor,
            trailing: toolNameTextField.trailingAnchor,
            topConstant: Metrics.Spacing.xSmall
        )
    }

    private func constrainToolDescriptionTextField() {
        toolDescriptionTextField.anchor(
            top: toolLinkTextField.bottomAnchor,
            leading: toolNameTextField.leadingAnchor,
            trailing: toolNameTextField.trailingAnchor,
            topConstant: Metrics.Spacing.xSmall
        )
    }

    private func constraintoolTagsTextField() {
        toolTagsTextField.anchor(
            top: toolDescriptionTextField.bottomAnchor,
            leading: toolNameTextField.leadingAnchor,
            trailing: toolNameTextField.trailingAnchor,
            topConstant: Metrics.Spacing.xSmall
        )
    }

    private func constrainAddToolButton() {
        addToolButton.anchor(
            top: toolTagsTextField.bottomAnchor,
            bottom: container.bottomAnchor,
            trailing: toolNameTextField.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            bottomConstant: Metrics.Spacing.small
        )
    }

    private func configureView() {
        backgroundColor = .secundary80
        closeButton.addTarget(self, action: #selector(onTappedCloseButton), for: .touchUpInside)
        addToolButton.addTarget(self, action: #selector(onTappedAddToolButton), for: .touchUpInside)
        toolNameTextField.returnKeyType = .next
        toolLinkTextField.returnKeyType = .next
        toolDescriptionTextField.returnKeyType = .next
        toolTagsTextField.returnKeyType = .send
        toolLinkTextField.delegate = self
        toolNameTextField.delegate = self
        toolTagsTextField.delegate = self
    }

    private func validateTextField(_ textField: CustomTextField) -> Bool {
        if textField.text == nil {
            textField.presentError()
            return false
        } else if let text = textField.text, text.isEmpty {
            textField.presentError()
            return false
        } else {
            textField.resetView()
            return true
        }
    }

    private func validateTextView(_ textView: CustomTextView) -> Bool {
        if textView.text == nil {
            textView.presentError()
            return false
        } else if let text = textView.text, text.isEmpty {
            textView.presentError()
            return false
        } else {
            textView.resetView()
            return true
        }
    }

    private func getToolTags(_ text: String) -> [String] {
        text.components(separatedBy: " ")
    }

    @objc private func onTappedCloseButton() {
        onTappedCloseButtonClosure()
    }

    @objc private func onTappedAddToolButton() {
        let isToolNameTextFieldValidated = validateTextField(toolNameTextField)
        let isToolLinkTextFieldValidated = validateTextField(toolLinkTextField)
        let isToolDescriptionTextFieldValidated = validateTextView(toolDescriptionTextField)
        let istoolTagsTextFieldValidated = validateTextField(toolTagsTextField)
        if isToolNameTextFieldValidated
            && isToolLinkTextFieldValidated
            && isToolDescriptionTextFieldValidated
            && istoolTagsTextFieldValidated {
            let tool = AddNewTool.Request(
                toolName: toolNameTextField.text ?? "",
                toolLink: toolLinkTextField.text ?? "",
                toolDescription: toolDescriptionTextField.text ?? "",
                toolTags: getToolTags(toolTagsTextField.text ?? "")
            )
            onTappedAddToolButtonClosure(tool)
        }
    }
}

// MARK: - AddNewToolContentViewProtocol

extension AddNewToolContentView: AddNewToolContentViewProtocol {

    func setupLoadingState(_ isLoading: Bool) {
        addToolButton.setLoading(isLoading)
    }
}

// MARK: - CustomUITextFieldDelegate

extension AddNewToolContentView: CustomUITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case toolNameTextField.textField:
            textField.resignFirstResponder()
            toolLinkTextField.textField.becomeFirstResponder()
        case toolLinkTextField.textField:
            textField.resignFirstResponder()
            toolDescriptionTextField.textView.becomeFirstResponder()
        case toolTagsTextField.textField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
