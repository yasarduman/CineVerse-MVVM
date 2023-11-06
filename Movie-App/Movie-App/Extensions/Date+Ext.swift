//
//  Date+Ext.swift
//  NewAppAdvanced
//
//  Created by Erislam Nurluyol on 28.10.2023.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.day().month().year())
        }
}
