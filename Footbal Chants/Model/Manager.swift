//
//  Manager.swift
//  Footbal Chants
//
//  Created by 엄승주 on 2/21/24.
//

import Foundation

enum JobType : String {
    case manager = "Manager"
    case headCoach = "Head Coach"
}

struct Manager{
    let name: String
    let job: JobType
}
