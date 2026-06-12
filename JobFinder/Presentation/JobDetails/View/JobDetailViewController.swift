//
//  JobDetailViewController.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import UIKit

final class JobDetailViewController:
UIViewController {

    private let viewModel:
        JobDetailViewModel

    init(viewModel: JobDetailViewModel) {

        self.viewModel = viewModel

        super.init(
            nibName: nil,
            bundle: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor =
            .systemBackground

        title = "Job Detail"

        setupUI()
    }
    
    private func setupUI() {

        let titleLabel = UILabel()

        let companyLabel = UILabel()

        let salaryLabel = UILabel()

        let locationLabel = UILabel()

        let descriptionLabel = UILabel()

        titleLabel.font =
            .boldSystemFont(ofSize: 24)

        descriptionLabel.numberOfLines = 0

        titleLabel.text =
            viewModel.job.title

        companyLabel.text =
            "Company: \(viewModel.job.company)"

        salaryLabel.text =
            "Salary: \(viewModel.job.salary)"

        locationLabel.text =
            "Location: \(viewModel.job.location)"

        descriptionLabel.text =
            viewModel.job.description

        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                companyLabel,
                salaryLabel,
                locationLabel,
                descriptionLabel
            ]
        )

        stack.axis = .vertical

        stack.spacing = 16

        view.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),

            stack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            stack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])
    }
}
