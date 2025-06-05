//
//  project.stencil
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "TimerDomain",
    moduleLayer: .domain,
    targets: [
        .interface,
        .implementation,
        .tests,
        .testing
    ],
    dependencies: [
        .implementation: [
            .target(name: "TimerDomainInterface")
        ],
        .tests: [
            .target(name: "TimerDomainInterface"),
            .target(name: "TimerDomainImplementation"),
            .target(name: "TimerDomainTesting")
        ],
        .testing: [
            .target(name: "TimerDomainInterface"),
            .target(name: "TimerDomainImplementation")
        ]
    ]
)
