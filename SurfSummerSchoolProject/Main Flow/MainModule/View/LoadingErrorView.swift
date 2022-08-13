//
//  LoadingErrorView.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 11.08.2022.
//

import UIKit

class LoadingErrorView: UIView {
    
    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadError")
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Не удалось загрузить ленту\nОбновите экран или попробуйте позже"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.backgroundColor = .black
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, label, refreshButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 15
        
        return stack
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
            label.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            refreshButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 48)
        
        ])
    }
}
