//
//  MockApiClient.swift
//  CopperTests
//
//  Created by Richard Pickup on 01/12/2021.
//
import Combine
import Foundation

@testable import Copper

final class MockApiClient: CopperClient {
    let mockFileName: String
    lazy var apiClient: APIClient = {
        return APIClient()
    }()
    
    var orderData: OrderResponse?
    
    
    init(fileName: String) {
        self.mockFileName = fileName
    }
    
    func orders() -> AnyPublisher<OrderResponse, Error> {
        let data = JSONParseUtils.loadDataFromJsonFile(name: mockFileName)!
        
        if let value = try? JSONDecoder().decode(OrderResponse.self, from: data) {
            self.orderData = value
            return Just(value)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let error = NSError(domain:"dummy json error", code:99, userInfo:["filename": mockFileName])
        return Fail(error: error).eraseToAnyPublisher()
    }
}

