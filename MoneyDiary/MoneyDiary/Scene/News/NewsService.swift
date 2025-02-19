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

final class NewsService {
    private let apiKey = "a1d480fcc229476fbd35777ba6abee2d"
    private let baseURL = "https://newsapi.org/v2/everything"
    
    func fetchNews(query: String) -> Observable<[NewsArticle]> {
        //경제뉴스만 받을예정
        let urlString = "\(baseURL)?q=\(query)&language=ko&apiKey=\(apiKey)"
        // url 유효성 검사.
        guard let url = URL(string: urlString) else {
            return Observable.error(NetworkError.invalidURL)
        }
        // 비동기 API 호출
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data -> [NewsArticle] in
                // data 디코딩 JSON 변환
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                // 2024-02-15T14:30:00Z 같은 형식이 ISO 8601임
                let response = try decoder.decode(NewsResponse.self, from: data)
                
                return response.articles
            }
        // 에러 핸들링 
            .catch { error in
                return Observable.error(NetworkError.apiError(error.localizedDescription))
            }
    }
}


