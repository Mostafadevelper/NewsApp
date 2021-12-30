//
//  DetailsViewModel.swift
//  AppTest
//
//  Created by Mostafa on 28/12/2021.
//

import Foundation

class DetailsViewModel: ViewModel {
    
    //MARK:- Variable:-
    var article: HomeCellViewModel!
    private var saveArticleInCashing = ArticleData()
    
    
    func saveArticle(title: String,image: String) {
        
        saveArticleInCashing.addArticle(title: title, image: image, index: UUID())
    }
}
