//
//  MenuView.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

class MenuView: UIView {
    //해라님이 짠 코드와 연결시켜서 사용해야함

    var currentCategory = "탕"
  
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
   /*     layout.estimatedItemSize = CGSize.zero*/ // extimate 사용안하는 방법
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2.0 // 셀 옆 부분 간격 조정
        layout.minimumLineSpacing = 2.0 // 셀 아랫부분 간격 조정
        return layout
    }()
    

    
    //반드시 lazy var 선언 해야함
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,  collectionViewLayout: flowLayout)
//        view.dataSource = self // 뷰 나타낼려면 필수
//        view.delegate = self // 뷰 나타낼려면 필수
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
//        view.backgroundColor = .lightGray //.clear
        view.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier) // 뷰 나타낼려면 필수
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   func makeUI() {
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
    }
    
    public func categoryLoadData(_ newCatagory: String) {
       
        currentCategory = newCatagory
        collectionView.reloadData()
    }
}


extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //카테고리 갯수
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //currentCategory 키값을 찾아서 탕 - 9
        return DataContainer.shared.menuItems[currentCategory]?.count ?? 0 // private 가져오는 방법 
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else {
            return UICollectionViewCell()
          }
        
        // estimate 사용 안하기 - 커스텀마이징 할때 사용 제로가 아니면 이미지뷰가 안나올수도 있음.
//        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                    flowlayout.estimatedItemSize = .zero
//                }
        if let filteredItems = DataContainer.shared.menuItems[currentCategory],
           let menuItem = filteredItems[indexPath.item]{
            DispatchQueue.main.async {
                cell.configure(menuItem)
//                cell.backgroundColor = .blue
//                cell.contentView.isUserInteractionEnabled = false
            }
        }
        return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width: CGFloat = ( (collectionView.frame.width - 20) / 3)
//        return CGSize(width: width, height: width ) // 셀의 이미지 사이즈
        let interItemSpacing: CGFloat = 10
        let width = (collectionView.bounds.width - interItemSpacing * 2) / 3
        let height = width * 1.1
        return CGSize(width: width, height: height)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: self.frame.width, height: 40)
//    }
//    
}
