//
//  JobCell.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import UIKit

final class JobCell: UITableViewCell {

    static let identifier = "JobCell"

    private let titleLabel = UILabel()
    private let companyLabel = UILabel()
    private let locationLabel = UILabel()
    private let salaryLabel = UILabel()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {

        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupUI() {

        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                companyLabel,
                locationLabel,
                salaryLabel
            ]
        )

        stack.axis = .vertical
        stack.spacing = 6

        contentView.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12
            ),

            stack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),

            stack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),

            stack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -12
            )
        ])

        titleLabel.font = .boldSystemFont(ofSize: 18)

        companyLabel.textColor = .secondaryLabel

        locationLabel.textColor = .systemBlue

        salaryLabel.textColor = .systemGreen
    }

    func configure(with job: Job) {

        titleLabel.text = job.title

        companyLabel.text = job.company

        locationLabel.text = job.location

        salaryLabel.text = job.salary
    }
}
