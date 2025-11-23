//
//  NetworkService.swift
//  LaRedouteRaceApp
//
//  Created by Moaz Ezz on 23/11/2025.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(endpoint: String) async throws -> T
}

enum NetworkServiceError: Error {
    case networkError(Error)
    case decodingError
    case invalidURL
    case serverError(Int, String)
}


final class NetworkServiceImpl: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NetworkServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkServiceError.networkError(
                    NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                )
            }
            
            // Handle different status codes
            switch httpResponse.statusCode {
            case 200:
                return try JSONDecoder().decode(T.self, from: data)
                
            case 403:
                // Check for CAPTCHA
            
                
            case 429:
                // Check for rateLimit
            default:
                throw NetworkServiceError.serverError(httpResponse.statusCode, "Server error")
            }
            
        } catch let error as NetworkServiceError {
            throw error
        } catch let decodingError as DecodingError {
            print("Decoding error: \(decodingError)")
            throw NetworkServiceError.decodingError
        } catch {
            throw NetworkServiceError.networkError(error)
        }
    }
}
