//
//  AppDependencyConfiguration.swift
//  DiExamTuist
//
//  Created by 이지훈 on 7/2/25.
//

import Foundation

/**
 완전 분리된 방식:
 - 모든 Feature가 자체 구현
 - Data 모듈들은 미래를 위한 skeleton
 - App은 DI도 사용하지 않음
*/

enum AppDependencyConfiguration {
    static func configure() {
        print("🔧 단순한 App 설정 시작")
        
        setupAppConfiguration()
        
        print("✅ 단순 방식 설정 완료 (모든 Feature 자체 구현)")
    }
    
    /// 앱 전역 설정 (폰트, 색상, 로깅 등)
    private static func setupAppConfiguration() {
        print("🎨 앱 전역 설정 적용")
        
        // - 폰트 등록
        // - 색상 테마 설정
        // - 로깅 레벨 설정
        // - 외관 모드 설정
        // - FCM관련 설정이나 크래시 리포팅 같은거
        
        print("✅ 앱 전역 설정 완료")
    }
}
