//
//  HomeService.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import Foundation
import Alamofire

enum TypeFetch {
    case mock
    case alamofire
    case urlSession
}

enum CustomError: Error {
    case fileNotFound(name: String)
    case decodingError(name: String, error: Error)
    case errorRequest(error: AFError)
    case invalidURL(url: String)
    case requestError
    case dataError
    case invalidResponse
    case noData
}

final class HomeService {
    func getHomeFromJson(completion: @escaping (Result<HomeData, CustomError>) -> Void) {
        
        if let url = Bundle.main.url(forResource: "HomeData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let homeData: HomeData = try JSONDecoder().decode(HomeData.self, from: data)
                completion(.success(homeData))
            } catch {
                completion(.failure(.decodingError(name: "HomeData", error: error)))
            }
        } else {
            completion(.failure(.fileNotFound(name: "HomeData")))
        }
    }
    
    func getHomeFromAlamofire(completion: @escaping (Result<HomeData, CustomError>) -> Void) {
        let url: String = "https://gist.githubusercontent.com/julianosgarbossa/96332db818b5954935608fc89e72bdca/raw/aef1eca923fda759e90de049d377f329e700816c/homedata.json"
        
        AF.request(url, method: .get).validate().responseDecodable(of: HomeData.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(.errorRequest(error: error)))
            }
        }
    }
    
    func getHomeFromUrlSession(completion: @escaping (Result<HomeData, CustomError>) -> Void) {
        let urlString: String = "https://gist.githubusercontent.com/julianosgarbossa/96332db818b5954935608fc89e72bdca/raw/aef1eca923fda759e90de049d377f329e700816c/homedata.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.requestError))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response .statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                let homeData = try JSONDecoder().decode(HomeData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(homeData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(name: "HomeData", error: error)))
                }
            }
        }
        task.resume()
    }
}
