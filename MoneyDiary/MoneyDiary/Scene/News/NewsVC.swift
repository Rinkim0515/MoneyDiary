//
//  NewsVC.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class NewsVC: UITableViewController {
    private let viewModel: NewsVM
    private let mainView = UIView()
    private let disposeBag = DisposeBag()
    var coordinator: NewsCoordinator?
    
    
    private let refreshControlView = UIRefreshControl()
    
    init(viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    override func viewDidLoad() {
        setupUI()
        bindViewModel()
        setupInfiniteScroll()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.id)
        tableView.refreshControl = refreshControlView
        
        
    }
    
    private func bindViewModel() {
        tableView.dataSource = nil
        tableView.delegate = nil
        // ViewModel의 state를 TableView에 바인딩
        viewModel.state
            .map { $0.newsItems }
            .drive(tableView.rx.items(cellIdentifier: NewsCell.id, cellType: NewsCell.self)) { _, news, cell in
                cell.configure(with: news)
            }
            .disposed(by: disposeBag)
        
        // 뉴스 항목 선택 시 이벤트 처리
        tableView.rx.modelSelected(NewsArticle.self)
            .map { NewsIntent.tapCell($0.url ?? "") }
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)
        
        // Pull to Refresh 동작 시 intentRelay에 refresh 이벤트 전달
        refreshControlView.rx.controlEvent(.valueChanged)
            .map { NewsIntent.refreshNews }
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)

        // ViewModel 이벤트 핸들링 (네비게이션 등)
        viewModel.event
            .emit(onNext: { [weak self] event in
                switch event {
                case .showErrorMessage(let message):
                    self?.showErrorAlert(message: message)
                case .navigateToDetail(let url):
                    self?.coordinator?.naviagteToDetail(url)
                    
                }
            })
            .disposed(by: disposeBag)
        
        // 상태 업데이트 후 RefreshControl 종료
        viewModel.state
            .map { !$0.isLoaded }
            .drive(refreshControlView.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    
    private func setupInfiniteScroll() {
        tableView.rx.didScroll
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let offsetY = tableView.contentOffset.y
                let contentHeight = tableView.contentSize.height
                let height = tableView.frame.size.height
                
                if offsetY > contentHeight - height - 100 { // 스크롤 끝에서 100px 전
                    self.viewModel.intentRelay.accept(.loadMore)
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension NewsVC {

}


