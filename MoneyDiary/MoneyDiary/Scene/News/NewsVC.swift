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
    
    
    private let refreshTrigger = PublishRelay<Void>()
    
    init(viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    override func viewDidLoad() {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = Tab.news.title
        
    }
}

extension NewsVC {

}


