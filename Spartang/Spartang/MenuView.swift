//
//  MenuView.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

class MenuView: UIView {
    
    //해라님이 짠 코드와 연결시켜서 사용해야함
    var currentCategory = "베스트"
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2.0
        return layout
    }()
    
    //반드시 lazy var 선언 해야함
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,  collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        view.backgroundColor = .lightGray //.clear
        view.register(MenuCell.self, forCellWithReuseIdentifier: "MenuCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        //addsubview
        //lay out - view. x Topanchor / leadinganchor
    }
    
    public func categoryLoadData() {
        
        collectionView.reloadData()
    }
}


extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    //카테고리 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //currentCategory 키값을 찾아서 탕 - 9 
        return DataContainer.shared.menuItems[currentCategory]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}
