//
//  JobListViewModel.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import Foundation

@MainActor
final class JobListViewModel {

    private let repository: JobRepositoryProtocol

    private(set) var jobs: [Job] = []

    private(set) var filteredJobs: [Job] = []

    var onStateChange: ((ViewState) -> Void)?

    init(repository: JobRepositoryProtocol) {
        self.repository = repository
    }

    func fetchJobs() async {

        onStateChange?(.loading)

        do {

            jobs = try await repository.getJobs()

            filteredJobs = jobs

            if jobs.isEmpty {
                onStateChange?(.empty)
            } else {
                onStateChange?(.loaded)
            }

        } catch {
            onStateChange?(
                .error(error.localizedDescription)
            )
        }
    }

    func search(text: String) {

        guard !text.isEmpty else {

            filteredJobs = jobs

            onStateChange?(.loaded)

            return
        }

        filteredJobs = jobs.filter {

            $0.title.lowercased()
                .contains(text.lowercased())

            ||

            $0.company.lowercased()
                .contains(text.lowercased())
        }

        if filteredJobs.isEmpty {
            onStateChange?(.empty)
        } else {
            onStateChange?(.loaded)
        }
    }
}
