//
//  File.swift
//  Minima
//
//  Created by Jaka on 2024-06-16.
//

import Foundation

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
