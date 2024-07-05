//
//  MenuView.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

class MenuView: UIView, CartTableViewCellDelegate {
    //해라님이 짠 코드와 연결시켜서 사용해야함
    var currentCategory = "탕"
    
    private var cartItems: [String: [Menu]] = [:]  // 장바구니 담기
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2.0 // 셀 옆 부분 간격 조정
        layout.minimumLineSpacing = 40.0 // 셀 아랫부분 간격 조정
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
        view.backgroundColor = .lightGray //.clear
        view.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier) // 뷰 나타낼려면 필수
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Yechan
    private let cartView: UIView = {
        let view = UIView()
        //        view.backgroundColor = .systemGray6 // layout 확인차
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell") // 셀 위치에 들어갈 커스텀 CartTableViewCell 등록
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("주문하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        //addsubview
        //lay out - view. x Topanchor / leadinganchor
        
        addSubview(collectionView)
        addSubview(cartView)
        addSubview(cartTableView)
        addSubview(totalPriceLabel)
        addSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            //            collectionView.bottomAnchor.constraint(equalTo: cartView.bottomAnchor, constant: -20),
            
            // MARK: - Yechan
            cartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cartView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            cartView.heightAnchor.constraint(equalToConstant: 300),
            
            cartTableView.topAnchor.constraint(equalTo: cartView.topAnchor),
            cartTableView.leadingAnchor.constraint(equalTo: cartView.leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: cartView.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: totalPriceLabel.topAnchor, constant: -10),
            //
            totalPriceLabel.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -20),
            totalPriceLabel.bottomAnchor.constraint(equalTo: cartView.bottomAnchor),
            //
            //            checkoutButton.leadingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: 20),
            //            checkoutButton.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -20),
            //            checkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            //            checkoutButton.heightAnchor.constraint(equalToConstant: 30),
            
            
        ])
        
    }
    
    //MARK: - Yechan
    private func addToCart(_ item: Menu) {
        // 장바구니에 같은 카테고리의 항목이 없으면 새로 추가, 있으면 기존에 추가된 항목에 더함
        print(currentCategory)
        
        if var existingItems = cartItems[item.name] {
            existingItems.append(item)
            cartItems[item.name] = existingItems
        } else {
            cartItems[item.name] = [item]
        }
        
//        if var existingItems = cartItems[currentCategory] {
//            existingItems.append(item)
//            cartItems[currentCategory] = existingItems
//        } else {
//            cartItems[currentCategory] = [item]
//        }
    }
    
    
    public func categoryLoadData(_ newCatagory: String) {
        
        currentCategory = newCatagory
        collectionView.reloadData()
    }
}


extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    //카테고리 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //currentCategory 키값을 찾아서 탕 - 9
        return DataContainer.shared.menuItems[currentCategory]?.count ?? 0 // private 가져오는 방법
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as? MenuCell else {
            return UICollectionViewCell()
        }
        if let filteredItems = DataContainer.shared.menuItems[currentCategory],
           let menuItem = filteredItems[indexPath.item]{
            cell.configure(menuItem)
            cell.backgroundColor = .blue
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80) // 셀의 이미지 사이즈
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filteredItems = DataContainer.shared.menuItems[currentCategory]
        if let selectedItem = filteredItems?[indexPath.item] {
            // cartItems에 추가 또는 업데이트 로직을 여기에 구현
            addToCart(selectedItem)
        }
        cartTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        //        let cartInfo = Array(cartItems.values)[indexPath.row]
        //        cell.configure(with: cartInfo.menuItem)
        ////        cell.quantityLabel.text = "\(cartInfo.quantity)"
        //        cell.delegate = self
        //        return cell
        // cartItems에서 해당 인덱스의 항목을 가져옵니다.
        let categoryKey = Array(cartItems.keys)[indexPath.row]
        if let menuItem = cartItems[categoryKey]?.first {
            cell.configure(menuItem)
        }
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = Array(cartItems.keys)[indexPath.row]
            cartItems.removeValue(forKey: key)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            //            updateTotalPrice()
        }
    }
    
    func didTapRemoveButton(on cell: CartCell) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
        let key = Array(cartItems.keys)[indexPath.row]
        cartItems.removeValue(forKey: key)
        cartTableView.deleteRows(at: [indexPath], with: .automatic)
        //        updateTotalPrice()
    }
    
    
    
    
    
}






