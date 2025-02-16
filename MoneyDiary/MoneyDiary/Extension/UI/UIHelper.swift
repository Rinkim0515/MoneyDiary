//
//  UIHelper.swift
//  MoneyDiary
//
//  Created by KimRin on 2/16/25.
//Call by Value , 필요한 일정의 값

import UIKit

struct UIHelper {
    // baseRatio: 화면대비 차지할 비율, min: 최소 CGFloat 값, max: 최대 CGFloat값
    static func dynamicHeight(baseRatio: CGFloat, min minValue: CGFloat, max maxValue: CGFloat) -> CGFloat {
        let calculatedHeight = UIScreen.main.bounds.height * baseRatio
        return max(minValue, min(calculatedHeight, maxValue))
    }
    

}
