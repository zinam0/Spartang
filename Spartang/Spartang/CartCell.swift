//
//  CartCell.swift
//  Spartang
//
//  Created by t2023-m0013 on 7/4/24.
//

import UIKit

class CartCell: UITableViewCell {

    // 수량 Update를 위한 변수 생성
    private var quantity: Int = 0
    
// MARK: - Label, Button 세팅
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(removeButton)
        
        // MARK: - TableViewCell Constraints 설정
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: 0),
            minusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            quantityLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: 0),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 0),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: -8),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            removeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("잘 모르겠고 그냥 에러임")
    }
    
    func configure(with menuItem: Menu) {
        nameLabel.text = menuItem.name
        priceLabel.text = "\(menuItem.price)원"
//        quantityLabel.text = "\(menuItem.quantity)"
    }



}

#Preview {
    CartCell()
}
