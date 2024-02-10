//
//  UpcomingTableViewCell.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 5.02.2024.
//

import UIKit
class UpcomingTableViewCell : UITableViewCell  {
    
    
   static let identifier = "UpcomingTableViewCell"
   
    private var playTitleButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle" , withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image , for: .normal)
        return button
    }()
    
    
    private var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var titlePosterUIImageView : UIImageView = {
        let titlePoster = UIImageView()
        titlePoster.contentMode = .scaleAspectFill
        titlePoster.clipsToBounds = true
        titlePoster.translatesAutoresizingMaskIntoConstraints = false
        return titlePoster
    }()
    
    func confgure(with viewModel : TitleViewModel) {
        guard let url = URL(string: TitleCollectionViewCell.baseUrl + viewModel.posterUrl) else {
            return
        }
        titlePosterUIImageView.sd_setImage(with: url)
        titleLabel.text = viewModel.titleName
        
        
    }
    
    
    func applyContraints() {
        let titlePosterUIImageViewContraints = [
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor) ,
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 15) ,
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15) ,
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100) ,
           
            
        ]
        
        NSLayoutConstraint.activate(titlePosterUIImageViewContraints)
        
        let textLabelContraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.leadingAnchor, constant: 150) ,
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(textLabelContraints)
        
        let titleLabelButtonConstraints = [
            playTitleButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelButtonConstraints)
        
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        contentView.addSubview(titlePosterUIImageView)
        applyContraints()
       
        
    }
    
}

