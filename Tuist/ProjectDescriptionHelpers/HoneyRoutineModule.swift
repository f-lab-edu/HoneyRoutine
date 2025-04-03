//
//  HoneyRoutineModule.swift
//  ProjectDescriptionHelpers
//
//  Created by JUNHEE JO on 4/3/25.
//

import ProjectDescription

/// APP 모듈에 관련된 정보를 모아놓은 열거형입니다.
public enum HoneyRoutineModule {
    public static let minimumDeploymentTarget: DeploymentTargets = .iOS("17.0")

    public enum Paths {
        public static let infoPlist = "Resources/Info.plist"
        public static let resources = "Resources/**"
        public static let debugXCConfig = "App/HoneyRoutineApp/Configurations/Debug.xcconfig"
        public static let releaseXCConfig = "App/HoneyRoutineApp/Configurations/Release.xcconfig"
    }
}
