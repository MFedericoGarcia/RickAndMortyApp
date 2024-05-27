//
//  Date+EXT.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 27/05/2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
