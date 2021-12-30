//
//  Date+Ex.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import Foundation

extension Date {
    
    var getCurrentDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: self))
        return  formatter.string(from: self)
    }
}
