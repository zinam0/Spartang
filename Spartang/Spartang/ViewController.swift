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
    let tabs = ["베스트", "탕", "사이드", "소주/맥주", "음료"]
    let tabColors: [UIColor] = [.red, .blue, .yellow, .green, .orange]
    var contentLabels: [UILabel] = []
    
    
    let menuView = MenuView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        menuView.makeUI()


    }
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view).offset(20)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(50)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        view.addSubview(menuView)

        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
//            menuView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
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

//            let contentLabel = UILabel()
//            contentLabel.text = "\(tab) 컬렉션들"
//            contentLabel.backgroundColor = tabColors[index]
//            contentLabel.textAlignment = .center
//            contentLabel.isHidden = true
//            view.addSubview(contentLabel)
//            contentLabel.snp.makeConstraints { make in
//                make.top.equalTo(scrollView.snp.bottom).offset(20)
//                make.left.equalTo(view).offset(20)
//                make.right.equalTo(view).offset(-20)
//                make.height.equalTo(100)
//            }
//            contentLabels.append(contentLabel)
        }
    }
    @objc func tabTapped(_ sender: UIButton) {
        for label in contentLabels {
            label.isHidden = true
        }
        contentLabels[sender.tag].isHidden = false
        menuView.categoryLoadData()
    }
}
