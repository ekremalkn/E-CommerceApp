//
//  Product.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import Foundation

// MARK: - Product
struct Product: Codable, SpecialCollectionCellProtocol, ProductCollectionCellProtocol, ProductDetailViewProtocol, CartCollectionCellProtocol {

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
        if let image = image {
            return image
        }
        return ""
    }
    
    var specialTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var specialDetail: String {
        if let productDescription = productDescription {
            return productDescription
        }
        return ""
    }
    
    //MARK: - ProductCollectionCellProtocol
    
    var productId: Int {
        if let id = id {
            return id
        }
        return 0
    }
    var productImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var productTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var productRatingCount: String {
        if let rating = rating?.rate {
            return "\(rating)"
        }
        return ""
       
    }
    
    var productSalesAmount: String {
        if let salesAmount = rating?.count {
            return "\(salesAmount) sold"
        }
        return ""
    }
    
    var productPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
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
    
    //MARK: - CartCollectionCellProtocol
    
    var cartCellImage: String {
        if let image = image {
            return image
        }
        return ""
    }
    
    var cartCellTitle: String {
        if let title = title {
            return title
        }
        return ""
    }
    
    var cartCellPrice: String {
        if let price = price {
            return "$\(price)"
        }
        return ""
    }
    
    var cartCellProductId: Int {
        if let id = id {
            return id
        }
        return 0
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



