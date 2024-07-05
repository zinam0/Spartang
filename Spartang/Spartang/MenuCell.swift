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
        image.contentMode = .scaleAspectFill // 비율유지하면서 전체화면 꽉 채우기 
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
    
    func setupView() {
        backgroundColor = .red
        //cell은 contentView 사용해야함
        contentView.addSubview(menuTitleLabel)
        contentView.addSubview(menuImage)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            menuImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            menuTitleLabel.topAnchor.constraint(equalTo: menuImage.bottomAnchor , constant: 1),
            menuTitleLabel.centerXAnchor.constraint(equalTo: menuImage.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: menuTitleLabel.bottomAnchor , constant: 1),
            priceLabel.centerXAnchor.constraint(equalTo: menuImage.centerXAnchor),
        ])

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
