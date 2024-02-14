//
//  UpComingViewController.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 2.02.2024.
//

import UIKit

class UpComingViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource {

    private var titles : [Title] = [Title]()

    private let upcomingTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        
        
        view.addSubview(upcomingTableView)
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
       
        getUpcomingMovies()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    private func getUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
              
                DispatchQueue.main.async {
                    self?.upcomingTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching upcoming movies: \(error.localizedDescription)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: TitleViewModel(titleName: titles[indexPath.row].original_title ?? "", posterUrl: titles[indexPath.row].poster_path ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 140  
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTitle = titles[indexPath.row]
        guard let selectedTitleName = selectedTitle.original_name ?? selectedTitle.original_title else { return }

        APICaller.shared.getMovieYoutube(with: selectedTitleName + "trailer") { [weak self] result in
            switch result {
            case .success(let youtubeResponse):
                let viewModel = TitlePreviewViewModel(title: selectedTitleName, overviewTitle: selectedTitle.overview, youtubeView: youtubeResponse)
                
                DispatchQueue.main.async { [weak self] in
                    let movieDetailVC = MovieDetailViewController()
                    movieDetailVC.configure(with: viewModel)
                    self?.navigationController?.pushViewController(movieDetailVC, animated: true)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }



}
