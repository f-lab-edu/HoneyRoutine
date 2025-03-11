import ProjectDescription

let project = Project(
    name: "HoneyRoutine",
    targets: [
        .target(
            name: "HoneyRoutine",
            destinations: .iOS,
            product: .app,
            bundleId: "com.BeePeach.HoneyRoutine",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        ),
        .target(
            name: "HoneyRoutineTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.BeePeach.HoneyRoutineTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "HoneyRoutine")]
        ),
    ]
)
