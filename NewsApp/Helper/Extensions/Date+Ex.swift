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
    
    //2021-12-28T13:53:00Z
    func customDate(_ date: String)-> String{
        
        var newDate = date
        newDate =  newDate.replacingOccurrences(of: "Z", with: "", options: NSString.CompareOptions.literal, range:nil)

        let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if  let date = dateFormatter.date(from: newDate) {
            dateFormatter.dateFormat = "d MMMM yyyy 'At' h a"
            return dateFormatter.string(from: date)
        }
        return newDate
    }
}
