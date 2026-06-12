//
//  AppDIContainer.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import UIKit

final class AppDIContainer {

    func makeJobListViewController() -> UIViewController {

        let service = JobService()
        let repository = JobRepository(service: service)

        let viewModel = JobListViewModel(
            repository: repository
        )

        return JobListViewController(
            viewModel: viewModel
        )
    }
}
