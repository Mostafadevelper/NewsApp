//
//  AlamofireRequestExtensions.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//


import Alamofire
import SwiftyBeaver
import UIKit

typealias Log = SwiftyBeaver

public extension Alamofire.Request {
    /// Prints the log for the request
    @discardableResult
    func debug() -> Self {
        Log.info(debugDescription)
        return self
    }
}

public extension Alamofire.DataRequest {
    @discardableResult
    func validateErrors() -> Self {
        return validate { [weak self] (request, response, data) -> Alamofire.Request.ValidationResult in

            // get status code from server
            let code = response.statusCode

            // check the request url
            let requestURL = String(describing: request?.url?.absoluteString ?? "NO URL")

            // check if response is empty
            guard let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
                self?.log(code: code, url: requestURL, message: "Empty response" as AnyObject, isError: false, request: request)
                return .success
            }

            var result: Alamofire.Request.ValidationResult = .success

            // check if response is html
            if (response.allHeaderFields["Content-Type"] as? String)?.contains("text/html") == true {
                self?.log(code: code, url: requestURL, message: jsonData as AnyObject, isError: true, request: request)

                let error = NSError(domain: "html", code: -999, userInfo: ["html": data, NSLocalizedDescriptionKey: "somethingWentWrong"])
                result = .failure(error)
            } else {
                self?.log(code: code, url: requestURL, message: jsonData as AnyObject, isError: false, request: request)
                result = .success
            }
            return result
        }
        // validate for request errors
        .validate()

        // log request
        .debug()
    }

    private func log(code: Int, url: String, message: AnyObject, isError: Bool, request: URLRequest?) {
        if isError {
            Log.error("FAILED")
        }

        Log.info("Status Code >> \(code)")
        Log.info("URL >> \(url)")
        Log.info("Request >> \(String(describing: request?.allHTTPHeaderFields))")
        Log.info("Response >> \(message)")
    }
}
