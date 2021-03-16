//
//  HomePresenter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 25/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentToolsResponse(_ response: Home.UsefulTools.Response)
    func presentURL(_ url: URL)
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
    
    private func mapToolTags(_ tags: [String]) -> [Home.UsefulTools.Tag] {
        tags.map {
            Home.UsefulTools.Tag(text: $0, estimatedWidth: getEstimatedWidthByWord($0))
        }
    }
    
    private func mapDomainDataToViewData(_ domainData: [GetUsefulToolsUseCaseModels.Tool]) -> Home.UsefulTools.ViewData {
        let tools = domainData.map {
            Home.UsefulTools.Tool(id: $0.id, title: $0.title, description: $0.description, tags: mapToolTags($0.tags))
        }
        return .init(tools: tools)
    }
}

// MARK: - HomePresentationLogic

extension HomePresenter: HomePresentationLogic {
    
    func presentToolsResponse(_ response: Home.UsefulTools.Response) {
        let viewState: Home.UsefulTools.ViewState
        switch response {
        case let .content(domainData):
            let viewData = mapDomainDataToViewData(domainData)
            viewState = .content(viewData)
        case .loading:
            viewState = .loading
        case .empty:
            viewState = .empty
        case .error:
            viewState = .error
        }
        viewController?.displayUsefulToolsViewState(viewState)
    }
    
    func presentURL(_ url: URL) {
        viewController?.displayURL(url)
    }
}
