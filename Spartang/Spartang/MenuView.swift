//  MenuView.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

class MenuView: UIView, CartTableViewCellDelegate {
    
    // 해라님이 짠 코드와 연결시켜서 사용해야함
    
    var currentCategory = "탕"
    
    //    private var cartItems: [String: [Menu]] = [:]  // 장바구니 담기
    private var cartItems: [String: (menu: Menu, quantity: Int)] = [:]
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        /*     layout.estimatedItemSize = CGSize.zero*/ // extimate 사용안하는 방법
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2.0 // 셀 옆 부분 간격 조정
        layout.minimumLineSpacing = 2.0 // 셀 아랫부분 간격 조정
        return layout
    }()
    
    // 반드시 lazy var 선언 해야함
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,  collectionViewLayout: flowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = true
        view.showsVerticalScrollIndicator = false
        view.clipsToBounds = true
        //        view.backgroundColor = .lightGray //.clear
        view.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier) // 뷰 나타낼려면 필수
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Yechan
    private let cartView: UIView = {
        let view = UIView()
        
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
    
    private let clearAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체 삭제", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
        
        addSubview(collectionView)
        addSubview(cartView)
        addSubview(clearAllButton)
        
        cartView.addSubview(cartTableView)
        cartView.addSubview(totalPriceLabel)
        cartView.addSubview(checkoutButton)
        
        setupClearAllButtonConstraints()
        clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside) // Add target to checkout button
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
            collectionView.heightAnchor.constraint(equalToConstant: 350),
            
            // MARK: - Yechan
            cartView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cartView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            cartView.heightAnchor.constraint(equalToConstant: 230),
            
            cartTableView.topAnchor.constraint(equalTo: cartView.topAnchor),
            cartTableView.leadingAnchor.constraint(equalTo: cartView.leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: cartView.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: totalPriceLabel.topAnchor, constant: -10),
            
            totalPriceLabel.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -10),
            totalPriceLabel.bottomAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: -40),
            
            //bottom, height 둘 다 사용할건가? ⚠️
            checkoutButton.leadingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: 20),
            checkoutButton.trailingAnchor.constraint(equalTo: cartView.trailingAnchor, constant: -20),
            checkoutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            checkoutButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }
    
    //MARK: - Yechan
    private func setupClearAllButtonConstraints() {
        NSLayoutConstraint.activate([
            clearAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            clearAllButton.bottomAnchor.constraint(equalTo: cartView.topAnchor, constant: -2),
            clearAllButton.widthAnchor.constraint(equalToConstant: 80),
            clearAllButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func clearAllButtonTapped() {
        cartItems.removeAll()
        updateTotalPrice()
        cartTableView.reloadData()
    }
    
    @objc private func checkoutButtonTapped() {
        let alert = UIAlertController(title: "주문 확인", message: "주문을 완료하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            // Handle order confirmation here
            self.cartItems.removeAll()
            self.updateTotalPrice()
            self.cartTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        if let viewController = self.findViewController() {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
    
    private func addToCart(_ item: Menu) {
        // 장바구니에 같은 카테고리의 항목이 없으면 새로 추가, 있으면 기존에 추가된 항목에 더함
        print(currentCategory)
        
        if var existingItems = cartItems[item.name] {
            existingItems.quantity += 1
            cartItems[item.name] = existingItems
        } else {
            cartItems[item.name] = (menu: item, quantity: 1)
        }
    }
    
    public func categoryLoadData(_ newCatagory: String) {
        
        currentCategory = newCatagory
        collectionView.reloadData()
    }
}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 카테고리 갯수
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
            //뷰 메인에서 그려줌 (GCD) 다른 메인이 아닌 거에 그림을 그리면 절대 그려지지 않거나 오류나게됨
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
    
    // 셀 부분 ⚠️
    // if let filteredItems = DataContainer.shared.menuItems[currentCategory],
    //    let menuItem = filteredItems[indexPath.item]{
    //    cell.configure(menuItem)
    //    cell.backgroundColor = .white
    // }
    // return cell
    // }
    
    // 다시 정의 이전 깃 확인
    // func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //    return CGSize(width: 80, height: 80) // 셀의 이미지 사이즈
    // }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filteredItems = DataContainer.shared.menuItems[currentCategory]
        if let selectedItem = filteredItems?[indexPath.item] {
            // cartItems에 추가 또는 업데이트 로직을 여기에 구현
            addToCart(selectedItem)
        }
        cartTableView.reloadData()
        updateTotalPrice()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        let categoryKey = Array(cartItems.keys)[indexPath.row]
        
        if let (menuItem, quantity) = cartItems[categoryKey] {
            cell.configure(menuItem:menuItem, quantity: quantity)
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = Array(cartItems.keys)[indexPath.row]
            cartItems.removeValue(forKey: key)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalPrice()
        }
    }
    
    private func updateTotalPrice() {
        let totalPrice = cartItems.reduce(0) { (result, item) -> Int in
            let (menuItem, quantity) = item.value
            return result + (menuItem.price * quantity)
        }
        totalPriceLabel.text = "총 메뉴 \(cartItems.count)개 결제: \(totalPrice)원"
    }
    
    func didTapRemoveButton(on cell: CartCell) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
        let key = Array(cartItems.keys)[indexPath.row]
        cartItems.removeValue(forKey: key)
        cartTableView.deleteRows(at: [indexPath], with: .automatic)
        updateTotalPrice()
    }
    
    func didUpdateQuantity(on cell: CartCell, quantity: Int) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
        let key = Array(cartItems.keys)[indexPath.row]
        cartItems[key]?.quantity = quantity
        cartTableView.reloadRows(at: [indexPath], with: .none)
        updateTotalPrice()
    }
}
