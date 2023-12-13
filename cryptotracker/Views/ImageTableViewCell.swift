//
//  ImageTableViewCell.swift
//  cryptotracker
//
//  Created by Josiel Perez on 11/30/23.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    let largeImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        largeImageView.contentMode = .scaleAspectFit
        contentView.addSubview(largeImageView)
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            largeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            largeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            largeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            largeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            largeImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

