//
//  CopperClient.swift
//  Copper
//
//  Created by Richard Pickup on 01/12/2021.
//

import Combine
import Foundation

protocol CopperClient {
    var apiClient: APIClient { get }
    func orders() -> AnyPublisher<OrderResponse, Error>
}

final class CopperTestClient: CopperClient {
    lazy var apiClient: APIClient = {
        return APIClient()
    }()
    
    func orders() -> AnyPublisher<OrderResponse, Error> {
        return apiClient.fetch(endpoint: CopperEndpoint.orders)
            .map(\.object)
            .eraseToAnyPublisher()
    }
}
