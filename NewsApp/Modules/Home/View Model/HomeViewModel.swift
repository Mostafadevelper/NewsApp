//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit
import Foundation
import Alamofire

class HomeViewModel: ViewModel {

    private let homeApi = HomeApi()
    private var articles : [Article] = [Article]()
    var cellViewModels: [HomeCellViewModel] = [HomeCellViewModel]()
    var loading :((Bool) ->())!
    var error : ((String)-> ())!
    var newsList :(([HomeCellViewModel])->())!
    var selectedResult: HomeCellViewModel?
    var total_page : Int = 1
    var page: Int = 1
    var isSearching = false
    var searchTerm = "apple"

}

extension HomeViewModel {

    func resetValues() {
        page = 1
        articles = []
        cellViewModels = []
        total_page = 1
        searchTerm = "apple"
    }

    //MARK:- To load data From API
    func fetchData() {

        guard self.page <= self.total_page else { return }
        if self.page == 1 { self.state = .loading}
        homeApi.getNewsList(page: page, search: searchTerm).get { [weak self] response in
            if let articles = response.articles, !articles.isEmpty  {
                self?.page += 1
                self?.total_page = ((response.totalResults ?? 0) / 20 )
                self?.state = .normal
                self?.processFetchedResult(result: articles)
            }else { self?.state = .empty }
        }.catch { [weak self] error in
            self?.state = .error(error)
        }

    }


    func getCellViewModel( at indexPath: IndexPath ) -> HomeCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    private func processFetchedResult(result : [Article]) {

        if self.articles.count == 0 {
            self.articles = result
        }else{
            self.articles.append(contentsOf: result)
        }

        var list = [HomeCellViewModel]()
        for movie in articles {
            list.append(createCellViewModel(at: movie))
        }
        self.cellViewModels = list

        self.newsList(self.cellViewModels)
    }
    
    func createCellViewModel(at result : Article) -> HomeCellViewModel {
        
        let createDate = Date().customDate(result.publishedAt ?? "")
        return   HomeCellViewModel(
            title: result.title ?? "",
            image: result.urlToImage ?? "",
            description: result.content ?? "",
            urlToImage: result.urlToImage ?? "",
            publishedAt: createDate,
            author: result.author)
    }

//
    func didSelect( at indexPath: IndexPath ){
        let new = self.cellViewModels[indexPath.row]
        self.selectedResult = new
    }
}
