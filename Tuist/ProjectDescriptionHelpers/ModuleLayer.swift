//
//  ModuleLayer.swift
//  ProjectDescriptionHelpers
//
//  Created by JUNHEE JO on 4/1/25.
//

import Foundation

/// 모듈이 속한 아키텍처 레이어를 정의하는 열거형입니다.
public enum ModuleLayer {
    /// 애플리케이션의 entry point
    /// AppDelegate, SceneDelegate, DIContainer 설정을 포함합니다.
    /// - 앱을 실행하고 루트 화면을 구성하는 역할
    case app

    /// 사용자에게 제공되는 화면 및 기능 단위 모듈
    /// 기능별 View, VC, VM을 포함
    case feature

    /// 핵심 비즈니스 로직 모듈 (UseCase, Entity 등)
    case domain

    /// 네트워크, 데이터베이스 등 시스템 단의 공통 기능 모듈
    case core

    /// 공통 UI 컴포넌트, 디자인 시스템, extension등 재사용 가능한 구성 요소
    case shared
}
