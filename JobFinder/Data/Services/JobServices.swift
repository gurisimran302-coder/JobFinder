//
//  JobServices.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import Foundation

final class JobService: JobServiceProtocol {
    
    func fetchJobs() async throws -> [Job] {

        guard let url = Bundle.main.url(
            forResource: "jobs",
            withExtension: "json"
        ) else {
            throw NSError(domain: "File Missing", code: 0)
        }

        let data = try Data(contentsOf: url)

        do {
            return try JSONDecoder().decode([Job].self, from: data)
        } catch {
            print("Decoding Error:", error)
            throw error
        }
    }
}
