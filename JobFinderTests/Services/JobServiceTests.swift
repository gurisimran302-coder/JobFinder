//
//  JobServiceTests.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import XCTest
@testable import JobFinder

final class JobServiceTests: XCTestCase {

    private var service: JobService!

    override func setUp() {
        super.setUp()
        service = JobService()
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testFetchJobsReturnsJobs() async throws {

        let jobs = try await service.fetchJobs()

        XCTAssertFalse(jobs.isEmpty)
    }
    
    func testFetchJobsCount() async throws {

        let jobs = try await service.fetchJobs()

        XCTAssertEqual(
            jobs.count,
            15
        )
    }
}
