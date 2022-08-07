//
//  FavoriteItemCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 07.08.2022.
//

import UIKit

class FavoriteItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let fillHeartImage = UIImage(named: "heart-fill")
        static let heartImage = UIImage(named: "heart")
    }
    
    // MARK: - Views

    @IBOutlet private  weak var favImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var creationDateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    
    // MARK: - Events
    
    var didFavoriteTapped: (() -> Void)?
    
    // MARK: - Calculated
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }
    
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            favImage.image = image
        }
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var date: String = "" {
        didSet {
            creationDateLabel.text = date
        }
    }
    
    var content: String = "" {
        didSet {
            contentLabel.text = content
        }
    }
    
    var isFavorite: Bool = true {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        didFavoriteTapped?()
        isFavorite.toggle()
        
    }
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

}

// MARK: - Prfivate Methods

private extension FavoriteItemCollectionViewCell {
    
    func configureAppearance() {
        favImage.layer.cornerRadius = 12
        titleLabel.font = .systemFont(ofSize: 15)
        creationDateLabel.font = .systemFont(ofSize: 13)
        creationDateLabel.textColor = .lightGray
        contentLabel.font = .systemFont(ofSize: 12, weight: .light)
        favoriteButton.tintColor = .white
        isFavorite = true
        
    }
}
