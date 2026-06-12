//
//  JobServiceProtocol.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

protocol JobServiceProtocol {
    func fetchJobs() async throws -> [Job]
}
