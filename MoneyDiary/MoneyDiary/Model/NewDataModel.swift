//
//  NewDataModel.swift
//  MoneyDiary
//
//  Created by KimRin on 2/19/25.
//

import Foundation

import Foundation

struct NewsResponse: Decodable {
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
