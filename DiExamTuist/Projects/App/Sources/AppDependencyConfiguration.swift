//
//  AppDependencyConfiguration.swift
//  DiExamTuist
//
//  Created by 이지훈 on 7/2/25.
//


//
//  AppDependencyConfiguration.swift
//  App
//
//  Created by 이지훈 on 7/1/25.
//

import Foundation

/**
 레퍼런스 방식: App은 Feature만 알고, DI도 사용하지 않음
 Feature가 Mock 데이터를 직접 관리
*/

enum AppDependencyConfiguration {
    static func configure() {
        print("🔧 레퍼런스 방식 앱 설정 시작")
        
        // ✅ 공통 설정만 (필요시)
        setupAppConfiguration()
        
        // ❌ DI Container 설정 완전 제거!
        // Feature들이 스스로 Mock 데이터 관리
        
        print("✅ 레퍼런스 방식 설정 완료 (App은 DI 모름)")
    }
    
    /// 앱 전역 설정 (폰트, 색상, 로깅 등)
    private static func setupAppConfiguration() {
        print("🎨 앱 전역 설정 적용")
        
        // TODO: 필요시 추가
        // - 폰트 등록
        // - 색상 테마 설정
        // - 로깅 레벨 설정
        // - 외관 모드 설정
        
        print("✅ 앱 전역 설정 완료")
    }
}