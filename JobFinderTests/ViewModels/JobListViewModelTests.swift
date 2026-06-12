//
//  JobListViewModelTests.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import XCTest
@testable import JobFinder

@MainActor
final class JobListViewModelTests: XCTestCase {

    private var repository: MockJobRepository!
    private var viewModel: JobListViewModel!

    override func setUp() {

        super.setUp()

        repository = MockJobRepository()

        viewModel = JobListViewModel(
            repository: repository
        )
    }

    override func tearDown() {

        repository = nil
        viewModel = nil

        super.tearDown()
    }
    
    func testInitialState() {

        XCTAssertTrue(viewModel.filteredJobs.isEmpty)
    }
    
    func testFetchJobsSuccess() async {

        await viewModel.fetchJobs()

        XCTAssertEqual(
            viewModel.filteredJobs.count,
            repository.mockJobs.count
        )
    }
    
    func testFetchJobsEmptyResponse() async {

        repository.mockJobs = []

        var receivedStates: [ViewState] = []

        viewModel.onStateChange = {
            receivedStates.append($0)
        }

        await viewModel.fetchJobs()

        XCTAssertTrue(
            receivedStates.contains(.empty)
        )
    }
    
    func testFetchJobsFailure() async {

        repository.shouldFail = true

        var receivedState: ViewState?

        viewModel.onStateChange = {
            receivedState = $0
        }

        await viewModel.fetchJobs()

        if case .error = receivedState {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected error state")
        }
    }
    
    func testSearchByTitle() async {

        await viewModel.fetchJobs()

        viewModel.search(text: "iOS")

        XCTAssertEqual(
            viewModel.filteredJobs.count,
            1
        )
    }
    
    func testSearchByCompany() async {

        await viewModel.fetchJobs()

        viewModel.search(text: "Apple")

        XCTAssertEqual(
            viewModel.filteredJobs.count,
            1
        )
    }

    func testSearchEmptyTextReturnsAllJobs() async {

        await viewModel.fetchJobs()

        viewModel.search(text: "")

        XCTAssertEqual(
            viewModel.filteredJobs.count,
            repository.mockJobs.count
        )
    }
    
    func testSearchNoResults() async {

        await viewModel.fetchJobs()

        viewModel.search(
            text: "Flutter"
        )

        XCTAssertEqual(
            viewModel.filteredJobs.count,
            0
        )
    }
    
    func testSearchIsCaseInsensitive() async {

        await viewModel.fetchJobs()

        viewModel.search(
            text: "apple"
        )

        XCTAssertEqual(
            viewModel.filteredJobs.count,
            1
        )
    }
    
    func testSearchNoResultsTriggersEmptyState() async {

        await viewModel.fetchJobs()

        var state: ViewState?

        viewModel.onStateChange = {
            state = $0
        }

        viewModel.search(text: "XYZ")

        XCTAssertEqual(state, .empty)
    }
    
    func testFetchJobsEmitsLoadingState() async {

        var receivedStates: [ViewState] = []

        viewModel.onStateChange = {
            receivedStates.append($0)
        }

        await viewModel.fetchJobs()

        XCTAssertTrue(
            receivedStates.contains(.loading)
        )
    }
    
    func testFetchJobsEmitsLoadedState() async {

        var receivedStates: [ViewState] = []

        viewModel.onStateChange = {
            receivedStates.append($0)
        }

        await viewModel.fetchJobs()

        XCTAssertTrue(
            receivedStates.contains(.loaded)
        )
    }
    
    func testSearchResultTriggersLoadedState() async {

        await viewModel.fetchJobs()

        var state: ViewState?

        viewModel.onStateChange = {
            state = $0
        }

        viewModel.search(text: "Apple")

        XCTAssertEqual(state, .loaded)
    }
    
}
