//
//  JobDetailViewModelTests.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import XCTest
@testable import JobFinder

final class JobDetailViewModelTests: XCTestCase {

    private var viewModel: JobDetailViewModel!

    private var mockJob: Job!

    override func setUp() {
        super.setUp()

        mockJob = Job(
            id: 1,
            title: "Senior iOS Developer",
            company: "Apple",
            location: "Remote",
            salary: "$120k",
            description: "Build amazing iOS apps"
        )

        viewModel = JobDetailViewModel(
            job: mockJob
        )
    }

    override func tearDown() {
        viewModel = nil
        mockJob = nil
        super.tearDown()
    }
    
    func testJobIsAssignedCorrectly() {

        XCTAssertNotNil(viewModel.job)
    }
}
