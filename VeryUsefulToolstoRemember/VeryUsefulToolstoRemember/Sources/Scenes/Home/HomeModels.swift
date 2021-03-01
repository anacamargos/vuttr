//
//  HomeModels.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

enum Home {
    
    enum UsefulTools {
        
        enum Response {
            case content([GetUsefulToolsUseCaseModels.Tool])
            case loading
            case error
        }
        
        enum ViewState {
            case content(ViewData)
            case loading
            case error
        }
        
        struct ViewData {
            let tools: [Tool]
        }
        
        struct Tool {
            let title: String
            let description: String
            let tags: [Tag]
        }
        
        struct Tag {
            let text: String
            let estimatedWidth: CGFloat
        }
    }
}
