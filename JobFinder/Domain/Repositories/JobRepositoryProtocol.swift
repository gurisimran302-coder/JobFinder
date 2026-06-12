//
//  JobRepositoryProtocol.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

protocol JobRepositoryProtocol {
    func getJobs() async throws -> [Job]
}
