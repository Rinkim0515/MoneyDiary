//
//  NewsService.swift
//  MoneyDiary
//
//  Created by KimRin on 2/19/25.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case invalidURL
    case apiError(String)
}
// https://newsapi.org/v2/everything?q=경제&from=2025-02-19&to=2025-02-20&sortBy=publishedAt&language=ko&pageSize=20&page=1&apiKey=a1d480fcc229476fbd35777ba6abee2d



final class NewsService {
    private let baseURL = "https://newsapi.org/v2/everything"
    private let apiKey = "a1d480fcc229476fbd35777ba6abee2d"

    func fetchNews(query: String, publishedDate: String, page: Int) -> Observable<[NewsArticle]> {
        var components = URLComponents(string: "https://newsapi.org/v2/everything")!
        components.queryItems = [
            URLQueryItem(name: "q", value: "경제"),
            URLQueryItem(name: "from", value: publishedDate),
            URLQueryItem(name: "to", value: publishedDate),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "language", value: "ko"),
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components.url else {
            print(#function)
            return Observable.error(NSError(domain: "URL 생성 실패", code: -1, userInfo: nil))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return URLSession.shared.rx.data(request: request)
            .map { data -> [NewsArticle] in
                do {
                    let response = try JSONDecoder().decode(NewsResponse.self, from: data)
                    return response.articles
                } catch {
                    throw NSError(domain: "JSON 디코딩 실패", code: -1, userInfo: nil)
                }
            }
    }
}


