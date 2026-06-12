//
//  JobRepository.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import Foundation

final class JobRepository: JobRepositoryProtocol {

    private let service: JobServiceProtocol

    init(service: JobServiceProtocol) {
        self.service = service
    }

    func getJobs() async throws -> [Job] {
        try await service.fetchJobs()
    }
}
