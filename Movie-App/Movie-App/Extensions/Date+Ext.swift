//
//  Date+Ext.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.day().month().year())
    }
}
