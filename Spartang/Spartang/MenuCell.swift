//
//  MenuCell.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let autoView = ViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(conder:) has not been implemented")
    }
    
    let myImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let myLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        backgroundColor = .red
        addSubview(myImage)
        addSubview(myLabel)
        addSubview(myLabel2)
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: autoView.scrollView.bottomAnchor , constant: 10),
            myImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: myImage.bottomAnchor , constant: 1),
            myLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myLabel2.topAnchor.constraint(equalTo: myLabel.bottomAnchor , constant: 1),
            myLabel2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myLabel2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myLabel2.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }

}
