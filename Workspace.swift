//
//  Workspace.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let workspace = Workspace(
    name: "HoneyRoutine",
    projects: [
        "App/**",
        // TODO: 해당 모듈이 추가되면 주석을 해제해야합니다.
        // "Feature/**",
        // "Core/**",
        "Domain/**",
        // "Shared/**"
    ]
)
