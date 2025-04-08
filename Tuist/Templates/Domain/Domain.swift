//
//  Domain.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let domainTemplate = Template(
    description: "Domain module scaffold template",
    attributes: [
        .required("name")
    ],
    items: [
        .file(
            path: "Domain/{{ name }}/Project.swift",
            templatePath: "project.stencil"
        ),

        .file(
            path: "Domain/{{ name }}/Sources/Interface/{{ name }}Interface.swift",
            templatePath: "DomainModuleFile.swift"
        ),
        .file(
            path: "Domain/{{ name }}/Sources/Implementation/{{ name }}Implementation.swift",
            templatePath: "DomainModuleFile.swift"
        ),
        .file(
            path: "Domain/{{ name }}/Tests/UnitTests/{{ name }}Tests.swift",
            templatePath: "DomainModuleFile.swift"
        ),
        .file(
            path: "Domain/{{ name }}/Tests/Testing/{{ name }}Testing.swift",
            templatePath: "DomainModuleFile.swift"
        )
    ]
)
