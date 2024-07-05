import UIKit


// 델리게이트를 위한 프로토콜 정의
protocol CartTableViewCellDelegate: AnyObject {
//    func didUpdateQuantity(on cell: CartTableViewCell, quantity: Int)
    func didTapRemoveButton(on cell: CartCell)
}

// 장바구니 Area에 포함된 내용 세팅
class CartCell: UITableViewCell {
    
    weak var delegate: CartTableViewCellDelegate?
    
    private var quantity: Int = 1
    {
            didSet {
                quantityLabel.text = "\(quantity)"
//                delegate?.didUpdateQuantity(on: self, quantity: quantity)
            }
        }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(minusButton)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(removeButton)
        setupConstraints()
        
//        // 버튼 액션 추가
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        // removeButton 액션 추가
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: 0),
            minusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            quantityLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: 0),
            quantityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: 0),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor, constant: -8),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            removeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
//    func configure(with menuItem: MenuItem) {
//        titleLabel.text = menuItem.title
//        priceLabel.text = "\(menuItem.price)원"
//        quantityLabel.text = "\(menuItem.quantity)"
//    }
//    var test = DataContainer()
//    MenuItem = test.menuItems
    func configure(_ menuItem: Menu) {
            titleLabel.text = menuItem.name
            priceLabel.text = "\(menuItem.price)원"
//            quantity = menuItem.quantity
        
//            quantityLabel.text = "\(menuItem.quantity)"
        }
//    
//    
    @objc private func minusButtonTapped() {
        if quantity > 1 {
            quantity -= 1
            print("-", quantity)
        }
    }

    @objc private func plusButtonTapped() {
        quantity += 1
        print("+", quantity)
    }
//
    @objc private func removeButtonTapped() {
        delegate?.didTapRemoveButton(on: self)
    }
    
}
//
//#Preview {
//    MenuViewController()
//}
