//
//  NetworkHelper.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation

//MARK: - NetworkEndPoint

enum NetworkEndPoint: String {
    case BASE_URL = "https://fakestoreapi.com"
}

final class NetworkHelper {
    deinit {
        print("deinit networkhelper")
    }
    static let shared = NetworkHelper()

    func requestUrl(url: String) -> String {
        return "\(NetworkEndPoint.BASE_URL.rawValue)\(url)"
    }
}
