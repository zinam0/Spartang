//
//  ViewController.swift
//  Spartang
//
//  Created by 차해라 on 7/2/24.
//

import UIKit
import SnapKit
import SwiftUI

//class MyViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let swiftUIView = ContentView()
//        let hostingController = UIHostingController(rootView: swiftUIView)
//
//        addChild(hostingController)
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
//
//        hostingController.view.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//}

class ViewController: UIViewController {
    
    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "스파르탕"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let cart = CartManager()
    
    let totalPriceLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    func addItemToCart(menu: Menu) {
        cart.menu.append(menu)
        collectionView.reloadData()
        calculateTotalPrice()
    }
    
    func calculateTotalPrice() {
        
        for item in cart.menu {
            cart.totalPrice += item.price * item.quantity
        }
        print("총 금액 : \(cart.totalPrice)")
    }
    
    let tabs = ["장바구니", "안주", "탕", "술", "음료"]
    
    let images: [[String?]] = [
        [],
        ["a1", "a2", "a3", "a4", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        ["b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", nil, nil, nil, nil, nil, nil, nil, nil],
        ["c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", "c11", "c12", "c13", "c14", "c15", nil],
        ["d1", "d2", "d3", "d4", "d5", "d6", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    ]
    
    var selectedTabIndex = 0
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        for (index, tab) in tabs.enumerated() {
            
            let tabButton = UIButton()
            tabButton.setTitle(tab, for: .normal)
            tabButton.setTitleColor(.black, for: .normal)
            tabButton.backgroundColor = .white
            tabButton.layer.cornerRadius = 10
            tabButton.layer.masksToBounds = true
            tabButton.layer.borderWidth = 1
            tabButton.layer.borderColor = UIColor.black.cgColor
            tabButton.tag = index
            tabButton.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            tabButton.snp.makeConstraints { make in
                make.width.equalTo(100)
            }
            stackView.addArrangedSubview(tabButton)
        }
        
        view.addSubview(totalPriceLabel)
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
        
        totalPriceLabel.isHidden = true
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    @objc func tabTapped(_ sender: UIButton) {
        selectedTabIndex = sender.tag
        collectionView.reloadData()
    }
    
    func presentHalfScreenModal(with imageName: String) {
        
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .pageSheet
        modalViewController.imageName = imageName
        modalViewController.delegate = self
        present(modalViewController, animated: true, completion: nil)
    }
}

extension ViewController: ModalViewControllerDelegate{
    
    func updateCart(menu: Menu) {
        addItemToCart(menu: menu)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedTabIndex == 0 {
            return cart.menu.count
        } else {
            return images[selectedTabIndex].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        
        if selectedTabIndex == 0 {
            cell.imageView.isHidden = true
            cell.totalPriceLabel.isHidden = false
            
            if indexPath.item < cart.menu.count {
                let item = cart.menu[indexPath.item]
                cell.totalPriceLabel.text = "\(item.name), \(item.quantity)개, 가격: \(item.price)원"
            } else {
                cell.totalPriceLabel.text = ""
            }
        } else {
            cell.imageView.isHidden = false
            cell.totalPriceLabel.isHidden = true
            if let imageName = images[selectedTabIndex][indexPath.item], !imageName.isEmpty {
                cell.imageView.image = UIImage(named: imageName)
            } else {
                cell.imageView.image = UIImage(named: "defaultImage")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedTabIndex == 0 { return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            let width = collectionView.frame.width / 2
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { if selectedTabIndex != 0 { if let imageName = images[selectedTabIndex][indexPath.item], !imageName.isEmpty { presentHalfScreenModal(with: imageName) } } } }

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.menu.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCartItem(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.reuseIdentifier, for: indexPath) as! CartItemCell
        let menuItem = cart.menu[indexPath.row]
        cell.productNameLabel.text = menuItem.name
        cell.quantityLabel.text = "수량 : \(menuItem.quantity)"
        cell.priceLabel.text = "\(menuItem.price)원"
        cell.checkBox.isSelected = false
        return cell
    }
}

extension ViewController {
    func deleteCartItem(at indexPath: IndexPath) {
        
        let deletedMenu = cart.menu[indexPath.row]
        cart.menu.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        cart.totalPrice -= deletedMenu.price * deletedMenu.quantity
        totalPriceLabel.text = "총 금액 : \(cart.totalPrice)원"
        totalPriceLabel.isHidden = cart.menu.isEmpty
    }
}

class ImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCell"
    
    let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        
        return imageView
    }()
    
    let totalPriceLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(totalPriceLabel)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        totalPriceLabel.numberOfLines = 0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CartItemCell: UITableViewCell {
    
        static let reuseIdentifier = "CartItemCell"
    
        let productNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            return label
        }()
    
        let quantityLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .gray
            return label
        }()
    
        let priceLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .gray
            return label
        }()
    
        let checkBox: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "square"), for: .normal)
            button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            return button
        }()
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(productNameLabel)
            addSubview(quantityLabel)
            addSubview(priceLabel)
            addSubview(checkBox)

            checkBox.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(10)
                make.width.height.equalTo(20)
            }
            
            productNameLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(checkBox.snp.trailing).offset(10)
            }
            
            quantityLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(productNameLabel.snp.trailing).offset(10)
            }
            
            priceLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().offset(-10)
            }
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

protocol ModalViewControllerDelegate {
    func updateCart(menu: Menu)
}

class ModalViewController: UIViewController {
    
    var delegate: ModalViewControllerDelegate?
    var imageName: String?
    var productName: String = "상품 이름"
    var price: Int = 10000
    var quantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(quantity)"
        }
    }
    
    let imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("담기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            setupViews()
        }
        
        func setupViews() {
            view.backgroundColor = .white
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            if let imageName = imageName,
               let image = UIImage(named: imageName) {
                imageView.image = image
            }
            
            view.addSubview(imageView)
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true

            view.addSubview(nameLabel)
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
            nameLabel.text = productName

            view.addSubview(priceLabel)
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
            priceLabel.text = "\(price)원"

            view.addSubview(quantityLabel)
            quantityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            quantityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16).isActive = true
            quantityLabel.text = "\(quantity)"

            view.addSubview(minusButton)
            minusButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor).isActive = true
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -16).isActive = true
            minusButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            minusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)

            view.addSubview(plusButton)
            plusButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor).isActive = true
            plusButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 16).isActive = true
            plusButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            plusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
            view.addSubview(addToCartButton)
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            addToCartButton.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 20).isActive = true
            addToCartButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
            addToCartButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func increaseQuantity() {
        quantity += 1
    }
    
    @objc func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
    }
    
    @objc func addToCart(_ sender: UIButton) {
        delegate?.updateCart(menu: Menu(name: productName, quantity: quantity, price: price))
        dismiss(animated: true, completion: nil)
    }
}



