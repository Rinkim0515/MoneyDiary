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
    case loadMore
}
enum NewsEvent {
    case showErrorMessage(String) // 네트워크 에러따른 다른 메세지를 보내기위해서
    case navigateToDetail(String) // URL 타입을 보내는것보다 문자열로 보내고 한번만 변환하기위해서
    
}

struct NewsState {
    let isLoaded: Bool
    let newsItems: [NewsArticle]
    let currentPage: Int
    
    static let initial = NewsState(isLoaded: false, newsItems: [], currentPage: 1)
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
                case .loadMore:
                    self.loadMoreNews()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchNews(isRefreshing: Bool = false) {
        let currentState = stateRelay.value
        let query = "경제"
        let publishedDate = getTodayDate() // 전날자 부터 가져올것
        let page = isRefreshing ? 1 : currentState.currentPage // 새로고침일경우 첫페이지부터
        
        if isRefreshing {
            stateRelay.accept(NewsState(isLoaded: false, newsItems: [], currentPage: 1))
        }
        newsService.fetchNews(query: query, publishedDate: publishedDate, page: page)
            .subscribe(onNext: { [weak self] newsArticles in
                guard let self = self else { return }
                
                let newState = NewsState(
                    isLoaded: true,
                    newsItems: isRefreshing ? newsArticles : currentState.newsItems + newsArticles, // 새로고침이면 덮어쓰기, 아니면 기존 데이터에 추가
                    currentPage: page
                )
                
                self.stateRelay.accept(newState)
            }, onError: { [weak self] error in
                self?.eventRelay.accept(.showErrorMessage(error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
    private func loadMoreNews() {
        let currentState = stateRelay.value
        let nextPage = currentState.currentPage + 1

        newsService.fetchNews(query: "경제", publishedDate: getTodayDate(), page: nextPage)
            .subscribe(onNext: { [weak self] newArticles in
                guard let self = self else { return }
                
                let updatedState = NewsState(
                    isLoaded: true,
                    newsItems: currentState.newsItems + newArticles, // 기존 데이터에 추가
                    currentPage: nextPage
                )
                
                self.stateRelay.accept(updatedState)
            }, onError: { [weak self] error in
                self?.eventRelay.accept(.showErrorMessage(error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
    
    private func getTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        return formatter.string(from: date)
    }
}
