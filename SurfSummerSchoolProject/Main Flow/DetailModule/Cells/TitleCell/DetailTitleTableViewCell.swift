//
//  DetailTitleTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by anita on 06.08.2022.
//

import UIKit

class DetailTitleTableViewCell: UITableViewCell {
    
    // MARK: - Views

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cartTitleLabel: UILabel!
    
    // MARK: - Properties
    var title: String = "" {
        didSet {
            cartTitleLabel.text = title
        }
    }
    
    var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    private func configureAppearance() {
        selectionStyle = .none
        cartTitleLabel.font = .systemFont(ofSize: 20)
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = UIColor(displayP3Red: 0xB3 / 255, green: 0xB3 / 255, blue: 0xB3 / 255, alpha: 1)
    }
    
}
