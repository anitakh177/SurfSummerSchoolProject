//
//  MainCellCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 04.08.2022.
//

import UIKit

class MainItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let fillHeartImage = UIImage(named: "heart-fill")
        static let heartImage = UIImage(named: "heart")
    }
    
    // MARK: - Views
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Events
    
    var didFavoriteTapped: (() -> Void)?
    
    // MARK: - Calculated
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            }
        }
    }
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                return
            }
            imageView.loadImage(from: url)
        }
    }
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    func setuButtons(sender: UIButton) {
        favoriteButton.setImage(Constants.fillHeartImage, for: .selected)
        favoriteButton.setImage(Constants.heartImage, for: .normal)
    }
    // MARK: - Actions
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        didFavoriteTapped?()
        isFavorite.toggle()
        //sender.isSelected = !sender.isSelected
            //UserDefaults.standard.set(sender.isSelected, forKey: "isSaved")
    }
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    

    
}

// MARK: - Private Methods

private extension MainItemCollectionViewCell {
    
    func configureAppearance() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15)
        
        imageView.layer.cornerRadius = 12
        
        favoriteButton.tintColor = .white
        //isFavorite = false
       // favoriteButton.isSelected = UserDefaults.standard.bool(forKey: "isSaved")
    
        //favoriteButton.isSelected = UserDefaults.standard.bool(forKey: "isSaved")
        //setuButtons(sender: favoriteButton)
    }

}
