//
//  ArticleData.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//


import Foundation
import CoreData

class ArticleData {
    
    private var dataController : DataController = DataController(modelName: "NewsModel")
    private var articles: [ArticleCoreData] = [ArticleCoreData]()
    
    init() {
        dataController.load()
    }
    
    final func addArticle(
        title : String ,
        image : String,
        index: UUID
    ){
        
        let article = ArticleCoreData(context: dataController.viewContext)
        article.title = title
        article.imageURl = image
        article.index = index
        self.save()
    }
    
    final func getArticles() -> [ArticleCoreData] {
        let fetchRequest: NSFetchRequest<ArticleCoreData> = ArticleCoreData.fetchRequest()
        
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            articles = result
        }
        
        return articles
    }
    
    
    final func removeArticle(index: Int){
        
        let articles = self.getArticles()
        
        dataController.viewContext.delete(articles[index])
        save()
    }
    
    
    
    final  func save() {
        do {
            try dataController.viewContext.save()
        }catch { print(error.localizedDescription) }
    }
}
