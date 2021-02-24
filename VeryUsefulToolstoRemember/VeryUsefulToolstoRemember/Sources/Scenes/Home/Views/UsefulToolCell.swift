//
//  UsefulToolCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class UsefulToolCell: CodedTableViewCell {
    
    // MARK: - Properties
    
    private var tags: [Home.UsefulTools.Tag] = []
    
    // MARK: - View Metris
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let shadowAlpha: Float = 0.05
        static let shadowY: CGFloat = 5
        static let shadowBlur: CGFloat = 7
        static let iconSmallestSize: CGFloat = 12
        static let collectionViewRowHeight: CGFloat = 17
        static let collectionViewEstimatedWidth: CGFloat = 10
    }
    
    // MARK: - View Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        view.layer.borderWidth = ViewMetrics.borderWidth
        view.layer.borderColor = UIColor.darkestWhite.cgColor
        view.backgroundColor = .white
        view.applyShadow(color: .black, alpha: ViewMetrics.shadowAlpha, x: .zero, y: ViewMetrics.shadowY, blur: ViewMetrics.shadowBlur, spread: .zero)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .subtitle, weight: .semibold)
        label.textColor = .ink
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .body, weight: .regular)
        label.textColor = .ink
        label.numberOfLines = .zero
        return label
    }()
    
    private let closeIcon: UIButton = {
        let button = UIButton()
        button.setImage(.close, for: .normal)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = AlignedCollectionViewFlowLayout(horizontalAlignment: .leading, verticalAlignment: .center)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Metrics.Spacing.tiny
        layout.minimumInteritemSpacing = Metrics.Spacing.xSmall
        layout.estimatedItemSize = .init(width: ViewMetrics.collectionViewEstimatedWidth, height: ViewMetrics.collectionViewRowHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(closeIcon)
        containerView.addSubview(collectionView)
    }
    
    override func constrainSubviews() {
        constrainContainerView()
        constrainTitleLabel()
        constrainDescriptionLabel()
        constrainCloseIcon()
        constrainCollectionView()
    }
    
    // MARK: - Private Methods
    
    private func constrainContainerView() {
        containerView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainCloseIcon() {
        closeIcon.anchor(
            top: containerView.topAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small,
            widthConstant: ViewMetrics.iconSmallestSize,
            heightConstant: ViewMetrics.iconSmallestSize
        )
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small + ViewMetrics.iconSmallestSize + Metrics.Spacing.tiny
        )
    }
    
    private func constrainDescriptionLabel() {
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: titleLabel.leadingAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            bottomConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainCollectionView() {
        collectionView.anchor(
            top: descriptionLabel.bottomAnchor,
            leading: descriptionLabel.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: descriptionLabel.trailingAnchor,
            topConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.small
        )
    }
    
    private func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.className)
    }
    
    private func countNumberOfRows() -> Int {
        var totalWidthPerRow: CGFloat = .zero
        var rowCounts: Int = 1
        let collectionViewWidth = UIScreen.main.bounds.width - Metrics.Spacing.xLarge
        tags.forEach {
            let dynamicCellWidth = $0.estimatedWidth
            totalWidthPerRow += dynamicCellWidth + Metrics.Spacing.xSmall

            if totalWidthPerRow > collectionViewWidth {
               rowCounts += 1
               totalWidthPerRow = dynamicCellWidth + Metrics.Spacing.xSmall
            }
        }
        return rowCounts
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: Home.UsefulTools.Tool) {
        tags = viewData.tags
        let numberOfRows = CGFloat(countNumberOfRows())
        let lineSpacing = Metrics.Spacing.xSmall * (numberOfRows - 1)
        let collectionViewHeight = ViewMetrics.collectionViewRowHeight * numberOfRows
        collectionView.heightAnchor.constraint(equalToConstant: lineSpacing + collectionViewHeight).isActive = true
        titleLabel.text = viewData.title
        descriptionLabel.text = viewData.description
        collectionView.reloadData()
    }
}

extension UsefulToolCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.reusableCell(for: TagCell.self, indexPath: indexPath)
        let currentTag = tags[indexPath.row]
        cell.setupTag(currentTag.text)
        return cell
    }
}
