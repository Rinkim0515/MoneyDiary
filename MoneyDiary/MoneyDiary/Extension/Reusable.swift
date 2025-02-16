//
//  Reusable.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//

import Foundation

//MARK: - CEll id generator
protocol CellReusable {
    static var id: String { get }
    
}

extension CellReusable {
    static var id: String {
        String(describing: self)
    }
}
