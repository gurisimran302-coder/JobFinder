//
//  MockJobRepository.swift
//  MockJobRepository
//
//  Created by Gursimran Singh on 11/06/26.
//

import XCTest
@testable import JobFinder

final class MockJobRepository: JobRepositoryProtocol {

    var shouldFail = false

    var mockJobs: [Job] = [
        Job(
            id: 1,
            title: "Senior iOS Developer",
            company: "Apple",
            location: "Remote",
            salary: "$100k",
            description: "Build apps"
        ),
        Job(
            id: 2,
            title: "Backend Developer",
            company: "Google",
            location: "London",
            salary: "$120k",
            description: "Build APIs"
        )
    ]

    func getJobs() async throws -> [Job] {

        if shouldFail {

            throw NSError(
                domain: "MockError",
                code: 1
            )
        }

        return mockJobs
    }
}
