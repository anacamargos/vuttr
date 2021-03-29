//
//  NetworkResponseDecoder.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 29/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol NetworkResponseDecoder {
    
    func decodeDataRequestResult<T: Codable>(
        _ result: Result<NetworkResponse, NetworkError>,
        ofType: T.Type,
        then handle: @escaping (Result<T?, NetworkError>) -> Void
    )
}
