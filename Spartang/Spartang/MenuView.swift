//
//  MenuView.swift
//  Spartang
//
//  Created by 남지연 on 7/4/24.
//

import UIKit

class MenuView: UIView  {
    
// 예찬
// MARK: - Start
    private var cartItems: [Menu] = []  //클릭한 메뉴 장바구니에 담기
    
    // UIView안에 테이블을 넣어서 사용하는 방식 적용
    private let cartView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell") // 셀 위치에 들어갈 커스텀 CartCell 등록
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - End
    
    
    
}


extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //카테고리 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
    // MARK: - TableView Area
    // tableview 필요한 row 갯수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    // dequeueReusableCell 재사용 가능한 셀 생성
    // configure(with:) cartItems 배열의 해당 항목으로 셀을 구성
    // cell.delegate = self를 통해 셀의 델리게이트를 현재 뷰 컨트롤러로 설정 -> 버튼 클릭 등의 이벤트 처리 가능
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.configure(with: cartItems[indexPath.row])
//        cell.delegate = self  // removebutton을 위한 델리게이터 설정
        
//        cell.minusButton.addTarget(self, action: #selector(minusButtonTapped(_:)), for: .touchUpInside)
//        cell.plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
//        cell.removeButton.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // tableview엣허 행 삭제 동작 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic) // 테이블 뷰에서 해당 행을 애니메이션과 함께 삭제
//            updateTotalPrice() // 변동사항에 따른 실시간 업데이트
        }
    }
    
    // 전체 총 주문 가격 계싼
    private func updateTotalPrice() {
        let totalPrice = cartItems.reduce(0) { $0 + $1.price}
        totalPriceLabel.text = "총 \(cartItems.count)개 결제: \(totalPrice)원"
    }
    
    // 메뉴 수량 변경
    func didUpdateQuantity(on cell: CartCell, quantity: Int) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
//        cartItems[indexPath.row].quantity = quantity
        cartTableView.reloadRows(at: [indexPath], with: .none) // 테이블 뷰의 해당 행을 다시 로드
        updateTotalPrice()
    }
    
    // 메뉴 삭제
    func didTapRemoveButton(on cell: CartCell) {
        guard let indexPath = cartTableView.indexPath(for: cell) else { return }
        cartItems.remove(at: indexPath.row)
        cartTableView.deleteRows(at: [indexPath], with: .automatic) // 테이블 뷰에서 해당 행을 애니메이션과 함께 삭제
        updateTotalPrice()
    }
    
}
