//
//  NewsVM.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

import RxSwift
import RxCocoa
enum NewsIntent{
    case tapCell(String)
    case refreshNews
}
enum NewsEvent {
    case showErrorMessage(String) // 네트워크 에러따른 다른 메세지를 보내기위해서
    case navigateToDetail(String) // URL 타입을 보내는것보다 문자열로 보내고 한번만 변환하기위해서
}

struct NewsState {
    let isLoaded: Bool
    let newsItems: [NewsArticle]
    
    static let initial = NewsState(isLoaded: false, newsItems: [])
}

final class NewsVM {
    private let disposeBag = DisposeBag()
    private let newsService = NewsService()
    let intentRelay = PublishRelay<NewsIntent>()
    private let stateRelay = BehaviorRelay<NewsState>(value:.initial)
    private let eventRelay = PublishRelay<NewsEvent>()
    
    var state: Driver<NewsState> { stateRelay.asDriver() }
    var event: Signal<NewsEvent> { eventRelay.asSignal() }
    
    init () {
        bindIntent()
        fetchNews()
    }
    
    private func bindIntent() {
        intentRelay
            .subscribe(onNext: { [ weak self] intent in
                guard let self = self else { return }
                switch intent {
                case .tapCell(let urlString):
                    self.eventRelay.accept(.navigateToDetail(urlString))
                case .refreshNews:
                    fetchNews(isRefreshing: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchNews(isRefreshing: Bool = false) {
        if !isRefreshing {
            stateRelay.accept(NewsState(isLoaded: false, newsItems: [])) // 초기화
        }
        
        newsService.fetchNews(query: "경제")
            .subscribe(onNext: { [weak self] newsArticles in
                guard let self = self else { return }
                
                let newState = NewsState(isLoaded: true, newsItems: newsArticles)
                self.stateRelay.accept(newState)
                
                
            }, onError: { [weak self] error in
                self?.eventRelay.accept(.showErrorMessage(error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
}
