//
//  File.swift
//  Minima
//
//  Created by Jaka on 2024-06-16.
//

import Foundation
import RealmSwift

struct Shopping: Decodable {
    var total: Int
    var items: [Item]
}

struct Item: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
}

class savedItemsTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var productName: String
    @Persisted var seller: String
    @Persisted var price: Int
    @Persisted var image: String?
    
    convenience init(id: ObjectId, productName: String, seller: String, price: Int, image: String? = nil) {
        self.init()
        self.id = id
        self.productName = productName
        self.seller = seller
        self.price = price
        self.image = image
    }
}
