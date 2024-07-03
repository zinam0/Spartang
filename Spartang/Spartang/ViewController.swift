//
//  ViewController.swift
//  Spartang
//
//  Created by 남지연 on 7/2/24.
//
import UIKit
import SnapKit


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
   

    let tabs = ["장바구니", "안주", "탕", "술", "음료"]

    let images: [[String?]] = [
        [],
        ["a1", "a2", "a3", "a4", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        ["b1", "b2", "b3", "b4", "b5", "b6", "b7", "b8", nil, nil, nil, nil, nil, nil, nil, nil],
        ["c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", "c11", "c12", "c13", "c14", "c15", nil],
        ["d1", "d2", "d3", "d4", "d5", "d6", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    ]

    let tabColors: [UIColor] = [.red, .blue, .green, .orange]

    var contentLabels: [UILabel] = []

    var selectedTabIndex = 0

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //
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
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[selectedTabIndex].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        if let imageName = images[selectedTabIndex][indexPath.item], !imageName.isEmpty {
            cell.imageView.image = UIImage(named: imageName)
        } else {
            cell.imageView.image = UIImage(named: "defaultImage")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: width)
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
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ModalViewController: UIViewController {
    var imageName: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetPresentationController = sheetPresentationController {
                sheetPresentationController.detents = [.medium(), .large()]
        }
        
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
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        view.addGestureRecognizer(tapGesture)
    }
   
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}
