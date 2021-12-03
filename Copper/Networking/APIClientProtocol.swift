//
//  APIClient.swift
//  Copper
//
//  Created by Richard Pickup on 30/11/2021.
//
import Combine
import Foundation

struct APIClient {
    
    struct Response<T> {
        let object: T
        let response: URLResponse
    }
    
    func fetch<T: Decodable>(endpoint: Endpointable) -> AnyPublisher<Response<T>, Error> {
        guard let request = endpoint.request
            else {
                /* This fatel error would be if the url wasn't valid
                 in this scenario it is better to fail in test early than proceed to production
                 */
                fatalError("Couldn't create Request")
            }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try JSONDecoder().decode(T.self, from: result.data)
                return Response(object: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
