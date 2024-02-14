//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 8.02.2024.
//

import UIKit

protocol SearchResultViewControllerDelegate : AnyObject {
    func searchResultViewController (_viewModel : TitlePreviewViewModel)
}



class SearchResultViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
   
     var delegate : SearchResultViewControllerDelegate?
    
    
     public var titles : [Title] = [Title]()
    
    public var searchResultCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 10  // Sütunlar arası boşluk
        layout.minimumLineSpacing = 10       // Satırlar arası boşluk
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        
       
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return  UICollectionViewCell()
        }
       
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = (title.original_name ?? title.original_title) ?? "nil"
         
        APICaller.shared.getMovieYoutube(with: titleName) { result in
            switch result {
            case.success(let element) :
                let viewModel = TitlePreviewViewModel(title: titleName, overviewTitle: title.overview, youtubeView: element)
                self.delegate!.searchResultViewController(_viewModel: viewModel)
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}

