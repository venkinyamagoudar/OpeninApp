//
//  ClickData.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 3/29/24.
//

import Foundation

struct ClickData: Identifiable {
    let id = UUID()
    let date: Date
    let clickCount: Int
    
    init(year: Int, month: Int, day: Int, clickCount: Int) {
        self.clickCount = clickCount
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
    }
}
