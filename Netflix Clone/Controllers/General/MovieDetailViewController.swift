//
//  MovieDetailViewController.swift
//  Netflix Clone
//
//  Created by Sarper Kececi on 11.02.2024.
//

import UIKit
import WebKit





class MovieDetailViewController: UIViewController {

    private let webKit : WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold) // Yazı tipi ve kalınlık
        label.text = "Harry Potter"
        return label
        
    }()
    
    
    private let overviewLabel : UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font  = UIFont.systemFont(ofSize: 18, weight: .regular)
        overviewLabel.numberOfLines = 0
        overviewLabel.text = "Harry Potter is the best movie ever to watch as a kid!"
        
        
        
        return overviewLabel
    }()
     
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        
        return button
    }()
 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        view.addSubview(overviewLabel)
        view.addSubview(webKit)
        
       configureConstraits()
        view.backgroundColor = .systemBackground
        
        
    }
    func  configureConstraits() {
       
        
        NSLayoutConstraint.activate([
         webKit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
         webKit.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         webKit.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         webKit.heightAnchor.constraint(equalToConstant: 250)
        ])
           // titleLabel constraints
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: webKit.bottomAnchor , constant: 30),
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 30),
              
           ])
           // overviewLabel constraints
           NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor , constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
           ])
           // downloadButton constraints
           NSLayoutConstraint.activate([
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 40) ,
            downloadButton.widthAnchor.constraint(equalToConstant : 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
           ])
       }
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.overviewTitle
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId ?? "nil")") else { return }
        
        webKit.load(URLRequest(url: url))
    }

}
