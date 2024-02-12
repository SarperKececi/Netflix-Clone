//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 2.02.2024.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCell(_cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
    
}


class CollectionViewTableViewCell: UITableViewCell {

   static let identifier = "CollectionViewTableViewCell"
    private var title : [Title] = [Title]()
    weak var delegate : CollectionViewTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.itemSize = CGSize(width: 140, height: 200)
           layout.scrollDirection = .horizontal
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
           return collectionView
       }()
   
   
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemRed
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
           super.layoutSubviews()
           collectionView.frame = contentView.bounds
       }
    
    
    public func configure(with titles: [Title]) {
        self.title = titles
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        
        }
    }

    
}
extension CollectionViewTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        title.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = title[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)

          return cell
       }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = title[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
      
        
        
        APICaller.shared.getMovieYoutube(with: titleName + "trailer") { [weak self] result in
            switch result {
            case.success(let videoElement):
                print(videoElement.id)
                let viewModel = TitlePreviewViewModel(title: titleName, overviewTitle: title.overview, youtubeView: videoElement)
                self!.delegate?.collectionViewTableViewCell(_cell: self!, viewModel: viewModel)
            case.failure(let error):
                print(error)
            }
        }
    }
}
