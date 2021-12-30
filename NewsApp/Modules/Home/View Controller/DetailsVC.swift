//
//  DetailsVC.swift
//  AppTest
//
//  Created by Mostafa on 28/12/2021.
//

import UIKit

class DetailsVC: UIViewController {

    //MARK:- Layout
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsAuthorLB: UILabel!
    @IBOutlet weak var newsDescriptionLB: UILabel!
    @IBOutlet weak var newsTitleLB: UILabel!
    @IBOutlet weak var newsPublishedAtLB: UILabel!
    @IBOutlet weak var titleLB: UILabel!
    
    //MARK:- Variable:-
    weak var coordinator: MainCoordinator?
    lazy var viewModel : DetailsViewModel  = {
        return DetailsViewModel()
    }()

    //MARK:- Life Cycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailsData()
    }
    
    //MARK:- PopUp action
    @IBAction func backAction(_ sender: Any) {
        coordinator?.popUpDetailsVC()
    }
    
    //MARK:- To Load News Url
    @IBAction func loadNewsEventsAction(_ sender: Any) {
        
        guard let url = URL(string: viewModel.article.image) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        self.viewModel.saveArticle(title: viewModel.article.title, image: viewModel.article.image)
    }
    
    
    @IBAction func loadFovorite(_ sender: Any) {
        coordinator?.loadFavorite()
    }
    
}

//MARK:- Details Data
extension DetailsVC {
   
    func loadDetailsData() {
    let detailsData = viewModel.article
        newsAuthorLB.text = detailsData?.author
        self.newsImage.loadImage(urlName: detailsData?.urlToImage)
        self.newsTitleLB.text = detailsData?.title
        self.newsDescriptionLB.text = detailsData?.description
        self.newsPublishedAtLB.text = detailsData?.publishedAt
    }
}
