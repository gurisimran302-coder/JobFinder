//
//  Job.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import Foundation

struct Job: Codable {
    let id: Int
    let title: String
    let company: String
    let location: String
    let salary: String
    let description: String
}

