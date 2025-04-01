//
//  template.swift
//  Config
//
//  Created by JUNHEE JO on 4/1/25.
//

import ProjectDescription

let template = Template(
    description: "Domain module scaffold template",
    attributes: [
        .required("name")
    ],
    items: [
        // Project.swift
        .file(
            path: "Domain/{{ name }}/Project.swift",
            templatePath: "project.stencil"
        ),

        // 기본 Swift 파일 템플릿 (빈 파일이면 tuist generate 되지 않기 때문입니다.)
        .file(
            path: "Domain/{{ name }}/Sources/Interface/{{ name }}Interface.swift",
            templatePath: "ModuleFile.swift"
        ),
        .file(
            path: "Domain/{{ name }}/Sources/Implementation/{{ name }}Implementation.swift",
            templatePath: "ModuleFile.swift"
        ),
        .file(
            path: "Domain/{{ name }}/Tests/UnitTests/{{ name }}Tests.swift",
            templatePath: "ModuleFile.swift"
        ),
        .file(
            path: "Domain/{{ name }}/Tests/Testing/{{ name }}Testing.swift",
            templatePath: "ModuleFile.swift"
        ),

        // 폴더 자동 생성 스크립트
        .file(
            path: "Domain/{{ name }}/scripts/create_structure.sh",
            templatePath: "scripts/create_structure.sh"
        )
    ]
)
