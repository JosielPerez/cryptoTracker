//
//  CryptoTableViewCell.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/9/23.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    var thumbnailView: UIImageView
    var titleLabel: UILabel
    var priceLabel: UILabel
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.thumbnailView = UIImageView()
        self.titleLabel = UILabel()
        self.priceLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.thumbnailView)
        contentView.addSubview(self.titleLabel)
        contentView.addSubview(self.priceLabel)
        
        self.setUpConstraints()

    }
    private func setUpConstraints() {
        let topPadding = 5.0
        let bottomPadding = 5.0
        let leadingPadding = 15.0
        let trailingPadding = 15.0
        let spacingBetweenLabelsAndThumbnail = 10.0
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        
        thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingPadding).isActive = true
        thumbnailView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -(topPadding + bottomPadding)).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: thumbnailView.heightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topPadding).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: spacingBetweenLabelsAndThumbnail).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -spacingBetweenLabelsAndThumbnail).isActive = true
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -bottomPadding).isActive = true
        
        
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -trailingPadding).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: spacingBetweenLabelsAndThumbnail).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
