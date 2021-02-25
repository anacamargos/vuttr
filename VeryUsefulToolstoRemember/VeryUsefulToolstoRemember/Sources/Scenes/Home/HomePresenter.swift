//
//  HomePresenter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 25/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentToolsViewState()
}

final class HomePresenter {
    
    // MARK: - Dependencies
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Private Methods
    
    private func getEstimatedWidthByWord(_ word: String) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Metrics.FontSize.body.value)]
        let estimatedWidth = NSString(string: word).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedWidth.width
    }
}

// MARK: - HomePresentationLogic

extension HomePresenter: HomePresentationLogic {
    
    func presentToolsViewState() {
        let tool = Home.UsefulTools.Tool(
            title: "Notion",
            description: "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized",
            tags: [
                .init(text: "#test", estimatedWidth: getEstimatedWidthByWord("#test")),
                .init(text: "#test", estimatedWidth: getEstimatedWidthByWord("#test")),
                .init(text: "#testawdqwd", estimatedWidth: getEstimatedWidthByWord("#testawdqwd")),
                .init(text: "#test", estimatedWidth: getEstimatedWidthByWord("#test")),
                .init(text: "#test", estimatedWidth: getEstimatedWidthByWord("#test")),
                .init(text: "#testawdqwd", estimatedWidth: getEstimatedWidthByWord("#testawdqwd")),
            ]
        )
        let viewData = Home.UsefulTools.ViewData(tools: [tool, tool, tool])
        viewController?.displayUsefulToolsViewState(.content(viewData))
    }
}
