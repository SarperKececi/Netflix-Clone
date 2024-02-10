//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 2.02.2024.
//

import UIKit

class SearchViewController: UITabBarController, UITableViewDataSource, UITableViewDelegate  {
   
    
    
    private var titles: [Title] = []
    
    let searchViewTableView: UITableView = {
        let searchViewTable = UITableView()
        searchViewTable.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return searchViewTable
    }()
    
    let searchResultView: UISearchController = {
        let searchResultView = UISearchController(searchResultsController: SearchResultViewController())
        searchResultView.searchBar.placeholder = "Search for a Movie or a TV shows"
        searchResultView.searchBar.searchBarStyle = .minimal
        searchResultView.searchBar.tintColor = .white
        return searchResultView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchViewTableView)
        searchViewTableView.delegate = self
        searchViewTableView.dataSource = self
        navigationItem.searchController = searchResultView
        searchResultView.searchResultsUpdater = self
        
        fetchDiscoverMovies()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchViewTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    func fetchDiscoverMovies() {
        APICaller.shared.discoverMovies { [weak self] result in
            switch result {
            case .success(let title):
                self?.titles = title
                DispatchQueue.main.async {
                    self?.searchViewTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: (title.original_name ?? title.original_title) ?? "nil", posterUrl: title.poster_path ?? "")
        cell.confgure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
extension SearchViewController: UISearchResultsUpdating { // searchBar içinde ki değişiklikleri dinleyen UISearchResultsUpdating protokolünü uyguladım.
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchResultView.searchBar
       
        guard let query = searchBar.text , !query.isEmpty , !query.trimmingCharacters(in: .whitespaces).isEmpty , query.trimmingCharacters(in: .whitespaces).count >= 3,
        let resultController = searchResultView.searchResultsController as? SearchResultViewController else {
            return
            
        }
        
        
        APICaller.shared.searchMovies(query: query) {  result in
            switch result {
            case.success(let titles):
                resultController.titles = titles
                DispatchQueue.main.async {
                    resultController.searchResultCollectionView.reloadData()
                }
                
               
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        
    }
}
