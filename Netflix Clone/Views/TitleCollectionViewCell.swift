//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 4.02.2024.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    static let identifier = "TitleCollectionViewCell"
   static let baseUrl = "https://image.tmdb.org/t/p/w500/"
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: TitleCollectionViewCell.baseUrl + model) else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
     //   print(model)
    }

}
