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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var emptyView: UIView!
    
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
        searchBar.delegate = self
    }
    
    @IBAction func serachAction(_ sender: Any) {
        self.searchView.isHidden = false
        self.viewModel.resetValues()
        self.tableView.reloadData()
    }
    
    @IBAction func closeSearchAction(_ sender: Any) {
        self.searchView.isHidden = true
        self.viewModel.resetValues()
        self.tableView.reloadData()
        self.viewModel.fetchData()
        self.view.endEditing(true)
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
                self.emptyView.isHidden = false
//                self.showEmptyAnimation()
            case .error(let error):
                self.hideLoadingAnimation()
                self.showAlert("Error", error?.localizedDescription ?? "")
            }
        }
     
        viewModel.newsList = { [weak self] list in
            guard let self = self else { return }
            self.emptyView.isHidden = true
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
       // coordinator?.openDetails(article: viewModel.selectedResult)
//        dismiss(animated: true, completion: nil)
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
//
//        vc.isSearching = viewModel.isSearching ? true : false
//                vc.delegate = self
//
//        if let id  = self.viewModel.selectedResult?.id {
//            vc.id_popular = id
//        }
//        show(vc, sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = viewModel.cellViewModels.count
        if count == indexPath.row + 1 { viewModel.fetchData() }
    }
}

//MARK: - Conform Search Delegates
extension HomeVC : UISearchControllerDelegate,UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard  let text = searchBar.text else {return}
        DispatchQueue.main.async(execute: {
            self.viewModel.resetValues()
            self.viewModel.searchTerm = text
            self.tableView.reloadData()
            self.viewModel.fetchData()
        })
    }
    
    
}

