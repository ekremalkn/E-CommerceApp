//
//  NetworkManager.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Alamofire

//MARK: - NetworkManager

final class NetworkManager {
    deinit {
        print("deinit networkmanager")
    }
    static let shared = NetworkManager()

    func request<T>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (AFError) -> ()) where T:Codable {
        AF.request(path, encoding: JSONEncoding.default).validate().responseDecodable(of: T.self) { response in
            guard let model = response.value else { print(response.error as Any); return}
            onSuccess(model)
        }
    }
    
}
