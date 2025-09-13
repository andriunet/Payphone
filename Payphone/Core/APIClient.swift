//
//  APIClient.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation
import Alamofire

protocol APIClientType {
    func fetchUsers() async throws -> [UserDTO]
}

struct APIClient: APIClientType {
    private let base = URL(string: "https://jsonplaceholder.typicode.com")!
    
    func fetchUsers() async throws -> [UserDTO] {
        let url = base.appendingPathComponent("users")
        print("GET:", url.absoluteString)
        
        let request = AF.request(url)
            .validate(statusCode: 200..<300)
            .serializingDecodable([UserDTO].self, decoder: JSONDecoder())
        
        do {
            let value = try await request.value
            print("API users:", value.count)
            return value
        } catch let afError as AFError {
            // Alamofire error
            if let urlErr = afError.underlyingError as? URLError {
                switch urlErr.code {
                case .notConnectedToInternet, .timedOut:
                    throw AppError.network("failed_fetch_users".localized)
                default:
                    throw AppError.network(urlErr.localizedDescription)
                }
            }
            throw AppError.network("AFError: \(afError.localizedDescription)")
        } catch let urlErr as URLError {
            // URLError
            switch urlErr.code {
            case .notConnectedToInternet, .timedOut:
                throw AppError.network("failed_fetch_users".localized)
            default:
                throw AppError.network(urlErr.localizedDescription)
            }
        } catch let decodeErr as DecodingError {
            // Decoding error
            throw AppError.validation("Error decodificando: \(decodeErr)")
        } catch {
            // Genérico
            throw AppError.network(error.localizedDescription)
        }
    }
}
