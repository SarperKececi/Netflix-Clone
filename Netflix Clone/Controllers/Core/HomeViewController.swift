//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 2.02.2024.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case Popular = 1
    case TrendingTV = 2
    case Upcoming = 3
    case TopRated = 4
    
}



class HomeViewController: UITabBarController , UITableViewDelegate, UITableViewDataSource {
   
    private let homeFeedTableView: UITableView = { // stored property
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
          return tableView
      }()
    
    let sectionTitles = ["TrendIng movIes" ,"Popular", "TrendIng TV" ,"UpcomIng MovIes" , "Top rated" , ]
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
        
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        
       
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width , height: 400))
        homeFeedTableView.tableHeaderView = headerView
      
        configureNavBar()
      
    }
    
    
   
    
    private func configureNavBar() {
        var image = UIImage(named: "netflixpng")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        leftBarButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -90, bottom: 0, right: 0) // Sol kenar boşluğunu ayarla
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }

    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        //homeFeedTableView.frame = view.bounds
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue :
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        case Sections.Popular .rawValue :
            APICaller.shared.getPopularMovies { result in
                switch result {
                case.success(let titles) :
                    cell.configure(with: titles)
                case.failure(let error) :
                    print(error.localizedDescription)
                    
                }
            }
        case Sections.TrendingTV.rawValue :
            APICaller.shared.getTrendingTv { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error) :
                    print(error.localizedDescription)
                    
                    
                    
                }
            }
        case Sections.Upcoming.rawValue :
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case.success(let titles) :
                    cell.configure(with: titles)
                case.failure(let error) :
                    print(error.localizedDescription)
                
                    
                }
            }
       
       
        case Sections.TopRated.rawValue : 
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case.success(let titles) :
                    cell.configure(with: titles)
                case.failure(let error) :
                    print(error.localizedDescription)
                    
                
                    
                }
            }
       
        
        default:
            return UITableViewCell()
        }
        return cell
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
  
    
    func numberOfSections(in tableView: UITableView) -> Int { // kaç section olacağını belirler
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y , width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLetter()
       
    }
       

    
}
