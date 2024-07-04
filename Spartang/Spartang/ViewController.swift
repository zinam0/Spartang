//
//  ViewController.swift
//  Spartang
//
//  Created by 차해라 on 7/2/24.
//
import UIKit
import SnapKit
import SwiftUI

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = ContentView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



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
    
    
    func addItemToCart(name: String, quantity: Int, price: Int) {
        let food = Menu(name: name, quantity: quantity, price: price)
        cart.menu.append(food)
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
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
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
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
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
        present(modalViewController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if selectedTabIndex == 0 {
            return 1
        } else {
            return images[selectedTabIndex].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[selectedTabIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        
        if selectedTabIndex == 0 {
            cell.imageView.image = UIImage(named: "cartImage")
        } else {
            if let imageName = images[selectedTabIndex][indexPath.item], !imageName.isEmpty {
                cell.imageView.image = UIImage(named: imageName)
            } else {
                cell.imageView.image = UIImage(named: "defaultImage")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedTabIndex == 0 {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
        } else {
            let width = collectionView.frame.width / 2
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let imageName = images[selectedTabIndex][indexPath.item], !imageName.isEmpty {
            presentHalfScreenModal(with: imageName)
        }
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 5
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ModalViewController: UIViewController {
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
            // Name label setup
            view.addSubview(nameLabel)
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
            nameLabel.text = productName
            // Price label setup
            view.addSubview(priceLabel)
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
            priceLabel.text = "\(price)원"
            // Quantity label setup
            view.addSubview(quantityLabel)
            quantityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            quantityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16).isActive = true
            quantityLabel.text = "\(quantity)"
            // Minus button setup
            view.addSubview(minusButton)
            minusButton.centerYAnchor.constraint(equalTo: quantityLabel.centerYAnchor).isActive = true
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -16).isActive = true
            minusButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            minusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
            // Plus button setup
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
        
        
        
        // Tap gesture recognizer to dismiss modal view
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

        dismiss(animated: true, completion: nil)
    }
}


