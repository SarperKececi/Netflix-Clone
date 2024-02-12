import UIKit

class HeroHeaderUIView: UIView {
    private var titles : [Title] = []
    // Download butonu için UIButton öğesi
    private let downloadButton: UIButton = {
        let downloadButton = UIButton()
        // Butonun metnini "Download" olarak ayarla
        downloadButton.setTitle("Download", for: .normal)
        // Butonun metin rengini beyaz olarak ayarla
        downloadButton.setTitleColor(.white, for: .normal)
        // Butonun kenarlıklarını beyaz renkli ve 1 piksel kalınlığında yap
        downloadButton.layer.borderColor = UIColor.white.cgColor
        downloadButton.layer.borderWidth = 1
        // Otomatik boyutlandırmayı devre dışı bırak
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.layer.cornerRadius = 8
        return downloadButton
    }()
    
    // Play butonu için UIButton öğesi
    private let playButton: UIButton = {
        let playButton = UIButton()
        // Butonun metnini "Play" olarak ayarla
        playButton.setTitle("Play", for: .normal)
        // Butonun metin rengini beyaz olarak ayarla
        playButton.setTitleColor(.white, for: .normal)
        // Butonun kenarlıklarını beyaz renkli ve 1 piksel kalınlığında yap
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 1
        // Otomatik boyutlandırmayı devre dışı bırak
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.cornerRadius = 8
        return playButton
    }()
   
    // HeroImageView, arkaplan görselini görüntülemek için UIImageView öğesi
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        // İmajın içeriğini boyutlandırmayı ve sıkıştırmayı belirle
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // İmaja varsayılan bir görüntü ataması yap (örneğin, "fightclup")
        imageView.image = UIImage(named: "fightclup")
        return imageView
    }()
  
    // Gradient katmanını eklemek için yardımcı fonksiyon
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        // Gradient renklerini belirle
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        // Gradient katmanının boyutunu belirle
        gradientLayer.frame = bounds
        // Gradient katmanını ana katmana ekle
        layer.addSublayer(gradientLayer)
    }
    
    // Kısıtlamaları uygulamak için yardımcı fonksiyon
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]

        // İlgili kısıtlamaları etkinleştir
        NSLayoutConstraint.activate(playButtonConstraints)

   let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]

        // İlgili kısıtlamaları etkinleştir
        NSLayoutConstraint.activate(downloadButtonConstraints)
    
   
     }

    // UIView'in alt sınıfını başlatmak için gerekli init fonksiyonu
    override init(frame: CGRect) {
          super.init(frame: frame)
          // Alt sınıfın öğelerini ana görünüme ekle
          addSubview(heroImageView)
          addGradient()
          addSubview(playButton)
          addSubview(downloadButton)
          applyConstraints()
          
          // TrendingMovies'i al ve ilk öğenin poster_url'sini kullan
          APICaller.shared.getTrendingMovies { [weak self] result in
              switch result {
              case .success(let titles):
                  self?.titles = titles
                  if let firstItemPosterURL = titles.first?.poster_path {
                      self?.heroImageView.sd_setImage(with: URL(string: TitleCollectionViewCell.baseUrl + firstItemPosterURL))
                  }
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }
    // NSCoder aracılığıyla başlatma işlevi (kod içinde kullanılmıyor)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UIView'in boyutu değiştiğinde çağrılan işlev
    override func layoutSubviews() {
        super.layoutSubviews()
        // ImageView'in boyutunu ebeveynin boyutuna ayarla
        heroImageView.frame = bounds
    }
}
