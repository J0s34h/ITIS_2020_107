//
//  CellView.swift
//  TableTest
//
//  Created by Joseph on 25.10.2020.
//

import UIKit

class CellView: UITableViewCell {

    let leftLabel: UILabel = UILabel()
    let rightLabel: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()

        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)
        
        rightLabel.font = UIFont.boldSystemFont(ofSize: 16.0)

        let viewsDict = [
            "name": rightLabel,
            "surname": leftLabel,
        ]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[surname]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-|", options: [], metrics: nil, views: viewsDict))

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-8-[surname]-4-[name]", options: [], metrics: nil, views: viewsDict))
    }

}
