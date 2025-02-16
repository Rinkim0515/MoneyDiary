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

final class NewsVC: UIViewController {
    private let viewModel: NewsVM
    private let mainView = UIView()
    private let disposeBag = DisposeBag()
    var coordinator: Coordinator
    
    init(viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
