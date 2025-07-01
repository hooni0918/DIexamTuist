// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "Swinject": .framework  // ✅ Swinject를 framework로 설정
        ]
    )
#endif

let package = Package(
    name: "DiExamTuist",
    dependencies: [
        // ✅ Swinject 의존성 추가
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1")
    ]
)
