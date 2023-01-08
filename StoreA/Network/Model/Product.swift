//
//  Product.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation

// MARK: - Product
struct Product: Codable, SpecialCollectionCellProtocol, ProductCollectionCellProtocol, ProductDetailViewProtocol {
   
    let id: Int?
    let title: String?
    let price: Double?
    let productDescription: String?
    let category: Category?
    let image: String?
    let rating: Rating?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case productDescription = "description"
        case category, image, rating
    }
    
    //MARK: - SpecialCollectionCellProtocol

    var specialImage: String {
        image ?? ""
    }
    
    var specialTitle: String {
        title ?? ""
    }
    
    var specialDetail: String {
        productDescription ?? ""
    }
    
    //MARK: - ProductCollectionCellProtocol
    
    var productImage: String {
        image ?? ""
    }
    
    var productTitle: String {
        title ?? ""
    }
    
    var productRatingCount: String {
        "\(rating?.rate ?? 0)"
    }
    
    var productSalesAmount: String {
        "\(rating?.count ?? 0) sold"
    }
    
    var productPrice: String {
        "$\(price ?? 0)"
    }
    
    //MARK: - ProductDetailViewProtocol
    
    var productDetailImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var productDetailTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var productDetailSalesAmount: String {
        if let salesAmount = rating?.count {
            return "\(salesAmount) sold"
        }
        return ""
    }
    
    var productDetailRatingCount: String {
        if let ratingCount = rating?.rate {
            return "\(ratingCount)"
        }
        return ""
    }
    
    var productDetailDescription: String {
        if let description = productDescription {
            return description
        }
        return ""
    }
    
    var productDetailPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }

    

    
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}



