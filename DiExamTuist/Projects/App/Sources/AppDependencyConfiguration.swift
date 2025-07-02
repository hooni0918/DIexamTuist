//
//  AppDependencyConfiguration.swift
//  DiExamTuist
//
//  Created by 이지훈 on 7/2/25.
//


import Foundation

/**
 App은 Feature만 알고, DI도 사용하지 않음
 Feature가 Mock 데이터를 직접 관리
*/

enum AppDependencyConfiguration {
    static func configure() {
        print("🔧 레퍼런스 방식 앱 설정 시작")
        
        setupAppConfiguration()
        
        
        print("✅ 레퍼런스 방식 설정 완료 (App은 DI 모름)")
    }
    
    /// 앱 전역 설정 (폰트, 색상, 로깅 등) -> 이 부분을 나중에 shared 로 뺴도 좋을듯? 합니다
    private static func setupAppConfiguration() {
        print("🎨 앱 전역 설정 적용")
        
        // - 폰트 등록
        // - 색상 테마 설정
        // - 로깅 레벨 설정
        // - 외관 모드 설정
        
        print("✅ 앱 전역 설정 완료")
    }
}
