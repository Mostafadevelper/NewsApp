//
//  HomeVC.swift
//  NewsApp
//
//  Created by Mostafa on 30/12/2021.
//

import UIKit

class HomeVC: BaseVC {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!

    //MARK:- Variable:-
    weak var coordinator: MainCoordinator?
    lazy var viewModel : HomeViewModel  = {
        return HomeViewModel()
    }()

    //MARK:- Life Cycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bind()
        viewModel.fetchData()
    }
    
}

extension HomeVC {
  
    func setupTableView() {
        tableView.register(cell: HomeTableCell.self)
        tableView.tableFooterView = UIView()
    }

    func bind() {
        
        viewModel.stateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoadingAnimation()
            case .normal:
                self.hideLoadingAnimation()
            case .empty:
                self.hideLoadingAnimation()
                self.showEmptyAnimation()
            case .error(let error):
                self.hideLoadingAnimation()
                self.showAlert("Error", error?.localizedDescription ?? "")
            }
        }
     
        viewModel.newsList = { [weak self] list in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

}

//MARK:- Table View data Source
extension HomeVC :  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as HomeTableCell
        cell.listCellViewModel = viewModel.cellViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

//MARK:- table View Delegate
extension HomeVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.didSelect(at: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = viewModel.cellViewModels.count
        if count == indexPath.row + 1 { viewModel.fetchData() }
    }
}

