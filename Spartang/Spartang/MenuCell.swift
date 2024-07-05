//
//  MenuCell.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

//기본적으로 collectionview는 스크롤이 탑재되어있어서 여기서 구현하지 않아도됨
class MenuCell: UICollectionViewCell {
    
    static let identifier = "MenuCell"
    
    
//    private let menuViewSize: CGFloat = 100
   
    private lazy var menuTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var menuImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill // 비율유지하면서 전체화면 꽉 채우기
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(conder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        menuImage.frame = CGRect(x: 120, y: 120, width: 120, height: 120)
//        menuTitleLabel.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
//        priceLabel.frame = CGRect(x: 20, y: 20, width: 20, height: 20)
//    }
    
    func setupView() {
//        backgroundColor = .red
        //cell은 contentView 사용해야함
        self.contentView.addSubview(self.menuTitleLabel)
        self.contentView.addSubview(self.menuImage)
        self.contentView.addSubview(self.priceLabel)
        
        NSLayoutConstraint.activate([
            menuImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
//            menuImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            menuTitleLabel.topAnchor.constraint(equalTo: menuImage.bottomAnchor , constant: 1),
            menuTitleLabel.centerXAnchor.constraint(equalTo: menuImage.centerXAnchor),
        ])
//        menuTitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        menuTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: menuTitleLabel.bottomAnchor , constant: 1),
            priceLabel.centerXAnchor.constraint(equalTo: menuImage.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 10)
        ])
//        priceLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
          //cell 테두리 체크 
//        contentView.layer.cornerRadius = 3.0
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = UIColor.red.cgColor
    }
    
    func configure(_ menu: Menu) {
        menuImage.image = UIImage(named: menu.image)
        menuTitleLabel.text = menu.name
        priceLabel.text = formatAndDisplayPrice(menu.price)
    }
    //1000단위로 , 표기
    private func formatAndDisplayPrice(_ num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let formattedValue = formatter.string(from: NSNumber(value: num)) {
            return "\(formattedValue)"
        } else {
            return "\(num)"
        }
    }
}
