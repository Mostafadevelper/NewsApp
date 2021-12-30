//
//  RequestParamters.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit

protocol RequestParamters: Codable {
    func getParamsAsJson() -> [String: Any]
}

extension RequestParamters {
    func getParamsAsJson() -> [String: Any] {
        let jsonEncoder = JSONEncoder()
        
        guard let jsonData = try? jsonEncoder.encode(self) else {
            return [:]
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        
        return dictionary
    }
}
