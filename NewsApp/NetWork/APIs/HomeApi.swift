//
//  HomeApi.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import Alamofire
import PromiseKit

class HomeApi: Api {
    
    enum APIRouter: Requestable {
        
        case getNews(HomeApi, page: Int, search: String)
        
        var baseUrl: URL {
            return URL(string: "https://newsapi.org/v2/")!
        }
        
        var path: String {
            switch self {
            case .getNews:
                return "everything"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .getNews:
                return .get
            }
        }
        
        var isWWWFormUrlEncoded: Bool? {
            return true
        }
        
        var parameters: Parameters? {
            switch self {
            case let .getNews(_, page, search):
                return [
                    "q": search ,
                    "apiKey": Keys.apiKey ,
                    "from": Keys.fromData ,
                    "page": page,
                    "pageSize": 20 ,
                    "language": "en"]
            }
        }
    }
}


extension HomeApi {
    
    func getNewsList(page: Int, search: String) -> Promise<NewsResponse> {
        return fireRequestWithSingleResponse(requestable: APIRouter.getNews(self, page: page, search: search))
    }

    
}
