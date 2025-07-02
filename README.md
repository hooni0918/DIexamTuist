```swift
@main
struct DiExamTuistApp: App {
    init() {
        print("🚀 DiExamTuist 앱 시작 (레퍼런스 방식)")

        // 1️⃣ 전역 설정만 수행 (DI 등록은 아직 없음)
        AppDependencyConfiguration.configure()

        print("✅ 앱 초기화 완료 - Feature들이 스스로 관리")
    }

    var body: some Scene {
        WindowGroup {
            ContentView() // 2️⃣ 메인 화면으로 이동
        }
    }
}

```

 `AppDependencyConfiguration.configure()`가 호출하고 FCM관련 설정이나 크래시 리포팅 같은거 넣게될떄 사용될만한 부분입니다. (저희는 shared로 다 빼기 떄문에 지금 당장은 필요없고 나중에나 사용되지 않을까,,)

```swift
enum AppDependencyConfiguration {
    static func configure() {
        print("🔧 레퍼런스 방식 앱 설정 시작")
        setupAppConfiguration() // 폰트, 색상, 로깅 등
        print("✅ 레퍼런스 방식 설정 완료 (App은 DI 모름)")
    }
}

```

## 2: 화면 구성과 Coordinator 생성

앱이 부팅되면 `ContentView`가 생성되고, 여기서 각 Feature의 Coordinator들이 준비됩니다

```swift
struct ContentView: View {
    @State private var routeState: ContentView.RouteType = .home
    private let coordinatorFactory: CoordinatorFactory = CoordinatorFactory()

    init() {
        print("📱 ContentView 초기화 (전체 구조)")
    }
}

```

`CoordinatorFactory`에서는 각 Feature별 Coordinator를 생성하고 SwiftUI Environment에 주입합니다. 이때 실제 데이터 처리는 일어나지 않고 코디네이터 생성만 됩니다

```swift
struct CoordinatorFactory {
    var homeCoordinatorRootView: some View {
        let coordinator = HomeCoordinator() // 3️⃣ Coordinator 생성
        return HomeCoordinatorView()
            .environment(coordinator) // SwiftUI Environment에 주입
    }
}

```

## 3: 사용자가 홈 탭 선택

사용자가 홈 버튼을 누르면 비로소 HomeFeature가 활성화되고, 본격적인 DI 설정이 시작.

```swift
// ContentView에서 홈 버튼 클릭
Button("홈") {
    routeState = .home 
    print("🏠 홈으로 이동")
}

```

상태가 `.home`으로 변경되면 `coordinatorFactory.homeCoordinatorRootView`가 화면에 표시되고, `HomeCoordinatorView`를 생성합니다.

## 4: HomeView 생성

`HomeCoordinatorView`가 생성되면서 내부적으로 `HomeView`가 생성.

```swift
public struct HomeView: View {
    @Environment(HomeCoordinator.self) var coordinator
    @State private var viewModel = HomeViewModel()
    
    public init() {
        print("🏠 HomeView 초기화")
    }
}

```

`@State private var viewModel = HomeViewModel()`이 실행될 때, DI가 동작.

## 5: HomeViewModel 초기화

```swift
@Observable
public final class HomeViewModel {
    // 6️⃣ Property Wrapper만 준비 (아직 resolve 안됨)
    @ObservationIgnored
    @Dependency private var getCurrentUserUseCase: GetCurrentUserUseCaseProtocol
    @ObservationIgnored
    @Dependency private var getAllUsersUseCase: GetAllUsersUseCaseProtocol
    @ObservationIgnored
    @Dependency private var switchUserUseCase: SwitchUserUseCaseProtocol

    public init() {
        print("🏠 HomeViewModel 생성 - 지연 의존성 주입 방식")

        // 7️⃣ 여기서 실제 DI 등록이 발생!
        HomeDataModule.configure()

        // 8️⃣ 비동기로 데이터 로드 시작
        Task {
            await loadUserData()
            await loadAllUsers()
        }
    }
}

```

 **`@Dependency` Property Wrapper들은 이 시점에서는 단순히 준비만 되어있고 실제로 `DIContainer.shared.resolve()`가 호출되지는 않은 상태**

## 6: HomeDataModule.configure() - 실제 구현체들의 등록

이제 `HomeDataModule.configure()`가 호출되면서 DI Container에 실제 구현체들이 등록. 

```swift
public struct HomeDataModule {
    public static func configure() {
        print("🏠 HomeDataModule 등록 시작 - 실제 데이터 연동")

// Repository 등록 (.container 스코프 = 싱글톤같은.. (의존성 주입이라 테스트코드와는 무관)
        DIContainer.shared.register(HomeRepository.self, scope: .container) { _ in
            return HomeRepositoryImpl() // 실제 API 통신하는 구현체
        }

//UseCase들 등록 (.graph 스코프 = 매번 새 인스턴스)
        DIContainer.shared.register(GetCurrentUserUseCaseProtocol.self, scope: .graph) { resolver in
            let repository = resolver.resolve(HomeRepository.self) // 의존성 체인
            return GetCurrentUserUseCase(homeRepository: repository)
        }

        // 기타 UseCase들도 유사하게 등록...
    }
}

```

이 시점에서 DI Container가 직접 등록부를 가지게 됨

- `HomeRepository.self` → `HomeRepositoryImpl` 생성 방법
- `GetCurrentUserUseCaseProtocol.self` → `GetCurrentUserUseCase` 생성 방법 (Repository 의존성 포함)
- 기타 등등...

## 7: 지연 로딩

HomeViewModel의 `init()`에서 `Task`가 실행되어 `loadUserData()`가 호출됩니다. (지연로딩)

```swift
@MainActor
private func loadUserData() async {
    isLoading = true
    errorMessage = ""

    do {
        // 여기서 getCurrentUserUseCase에 첫 접근
        let user = await Task.detached { [weak self] in
            return self?.getCurrentUserUseCase.execute() //지연 로딩
        }.value
    }
}

```

`self?.getCurrentUserUseCase.execute()`가 실행되는 순간, `@Dependency` Property Wrapper의 `wrappedValue` getter가 호출됩니다.

> **Swift lazy**: 단순히 첫 접근까지 초기화를 미루는 것
> 
> 
> **@Dependency 지연 로딩**: DI Container의 복잡한 의존성 해결 과정을 실제 사용 시점까지 미루는 것
> 

## 8: Property Wrapper- 실제 Resolve

이제 `@Dependency` Property Wrapper 내부에서 실제 resolve가 일어납니다.

```swift
public var wrappedValue: T {
    //처음 접근이므로 _wrappedValue는 nil
    if let value = _wrappedValue {
        return value
    }

    //DI Container에서 실제 resolve 수행
    let resolved = DIContainer.shared.resolve(T.self) // T = GetCurrentUserUseCaseProtocol
    _wrappedValue = resolved //캐싱하여 다음번에는 바로 반환
    return resolved
}

```

## 9: DI Container의 의존성 해결

`DIContainer.shared.resolve(GetCurrentUserUseCaseProtocol.self)`가 호출되면, DI Container는 등록된 팩토리 함수를 실행합니다.

```swift
//등록된 팩토리 함수 실행
{ resolver in
    let repository = resolver.resolve(HomeRepository.self) //먼저 Repository resolve
    return GetCurrentUserUseCase(homeRepository: repository) //UseCase 생성
}

```

`GetCurrentUserUseCase`는 `HomeRepository`가 필요하므로, DI Container는 다시 `HomeRepository`를 resolve함

```swift
// HomeRepository resolve 과정
{ _ in
    return HomeRepositoryImpl() // 새로운 Repository 인스턴스 생성
}

```

## 10: 진짜 비즈니스 로직 실행

모든 의존성이 해결되면  실제 비즈니스 로직이 실행됨

```swift
//GetCurrentUserUseCase.execute() 실행
public func execute() -> User? {
    Logger.shared.log("👤 현재 사용자 정보 조회 실행")

    //Repository를 통해 실제 데이터 조회
    guard let user = homeRepository.getCurrentUser() else {
        return nil
    }

    // 비즈니스 로직 (검증 등..)
    guard !user.name.isEmpty, !user.email.isEmpty else {
        return nil
    }

    return user
}

```

## 11: Repository에서의 실제 데이터 처리

 `HomeRepositoryImpl`에서 실제 데이터 처리가 일어남

```swift
public func getCurrentUser() -> User? {
    logger.log("🔍 현재 사용자 조회 API 호출 시뮬레이션")

    //실제로는 API 호출, 여기서는 예시만~
    Thread.sleep(forTimeInterval: 0.5)

    let currentUser = realUserDatabase.first { $0.id == currentUserId }
    return currentUser //결과 반환
}

```

## Phase 12: 결과의 역순 전파

데이터가 준비되면 결과가 역순으로 전파됨:

1. `HomeRepositoryImpl` → `GetCurrentUserUseCase`
2. `GetCurrentUserUseCase` → `HomeViewModel`
3. `HomeViewModel` → `HomeView` (SwiftUI의 @Observable을 통해)
4. `HomeView` → 화면 업데이트

## 핵심 통찰: 왜 이렇게 복잡한 구조를 사용하는가?

이 복잡해 보이는 구조의 진정한 가치를 이해해 보겠습니다.

첫째, **테스트 가능성**입니다. 각 계층이 인터페이스를 통해 분리되어 있어서, HomeViewModel을 테스트할 때 실제 API를 호출할 필요 없이 Mock UseCase를 주입할 수 있습니다.

둘째, **유연성**입니다. 만약 API 구조가 바뀌어도 `HomeRepositoryImpl`만 수정하면 되고, 비즈니스 로직이 바뀌어도 UseCase만 수정하면 됩니다.

셋째, **재사용성**입니다. 다른 Feature에서도 같은 Repository나 UseCase를 사용할 수 있습니다.

---

화면전환

## 화면 전환 아키텍처의 전체 구조

이 앱은 **3계층 화면 전환 시스템**을 사용합니다. 이를 건물에 비유하면, 1층은 전체 앱의 탭 전환, 2층은 각 Feature 내부의 화면 전환, 3층은 모달이나 시트 같은 임시 화면들입니다.

App 레벨은 각 `ContentView` 에서 관리됨  → 탭바전환

**Feature 내부 네비게이션으로 각 Feature별** Coordinator가 관리

modal은 따로

## 1: 앱 시작과 초기 화면 설정

```swift
struct ContentView: View {
    // 현재 선택된 탭을 관리하는 상태
    @State private var routeState: ContentView.RouteType = .home

    // 각 Feature의 Coordinator를 생성하는 팩토리
    private let coordinatorFactory: CoordinatorFactory = CoordinatorFactory()

    init() {
        print("📱 ContentView 초기화 (전체 구조)")
    }
}

```

- RouteState: 현재 어떤 Feature가 활성화되어 있는지를 나타내는 상태값. 
`@State`로 관리되기 때문에, 이 값이 변경되면 자동으로 화면이 다시 그려짐 → 탭바전환용!
- `CoordinatorFactory`는 각 Feature별 Coordinator를 생성하고 관리.

## 2: contentView의 동적 화면 결정

`@ViewBuilder`를 사용하여 현재 상태에 View를 반환.

```swift
@ViewBuilder
private var contentView: some View {
    switch routeState {
    case .home:
        coordinatorFactory.homeCoordinatorRootView // HomeFeature 전체
    case .profile:
        coordinatorFactory.profileCoordinatorRootView // ProfileFeature 전체
    case .login:
        coordinatorFactory.loginCoordinatorRootView // LoginFeature 전체
    }
}

```

## 3: CoordinatorFactory의 각 Feature 준비

사용자가 홈 버튼을 클릭했다고 가정하면, `routeState`가 `.home`으로 변경되고, `coordinatorFactory.homeCoordinatorRootView`가 호출됩니다.

```swift
struct CoordinatorFactory {
    var homeCoordinatorRootView: some View {
        // HomeCoordinator 인스턴스 생성
        let coordinator = HomeCoordinator()

        // HomeCoordinatorView를 생성하고 coordinator를 환경에 주입
        return HomeCoordinatorView()
            .environment(coordinator) // SwiftUI Environment 시스템 활용
    }
}

```

. `CoordinatorFactory`는 각 Feature별로 독립적인 Coordinator 인스턴스를 생성. 

그리고 `.environment(coordinator)`를 통해 해당 Coordinator를 SwiftUI의 Environment 시스템에 주입

## 4: HomeCoordinator

`HomeCoordinato` 에서 Home Feature 내부의 모든 화면 전환을 관리. 

```swift
@Observable
public final class HomeCoordinator: Coordinatorable {
    // 화면 전환에 필요한 상태들
    public var path: NavigationPath = NavigationPath()
    public var sheet: SheetScreen? //모달용
    public var fullScreenCover: FullScreen? // 풀스크린 모달용

    public init() {
        print("🧭 HomeCoordinator 생성")
    }
}

```

 이 Coordinator의 상태가 변경되면, 이를 관찰하고 있는 모든 View가 자동으로 업데이트

## 5: HomeCoordinatorView

```swift
public struct HomeCoordinatorView: View {
    @Environment(HomeCoordinator.self) var coordinator // 환경에서 coordinator 주입받음

    public var body: some View {
        @Bindable var bindableCoordinator = coordinator // 양방향 바인딩을 위한 변환

        NavigationStack(path: $bindableCoordinator.path) {
            coordinator.view(.main) // 홈 Feature의 메인 화면 표시
                .navigationDestination(for: HomeRouter.Screen.self) { screen in
                    coordinator.view(screen) // 각 화면별 View 생성
                }
                .sheet(item: $bindableCoordinator.sheet) { sheet in
                    // 시트 모달일 경우
                    NavigationView {
                        coordinator.presentView(sheet)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("닫기") {
                                        coordinator.dismissSheet()
                                    }
                                }
                            }
                    }
                }
                .fullScreenCover(item: $bindableCoordinator.fullScreenCover) { cover in
                    coordinator.fullCoverView(cover) // 풀스크린 모달일 경우
                }
        }
        .environment(coordinator) // coordinator를 하위 View들에게 전파
    }
}

```

`.navigationDestination`을 통해 각 화면별 목적지를 정의.

## 6: 실제 화면 전환이 일어나는 순간

이제 사용자가 홈 화면에서 설정 버튼을 눌렀다고 가정하면

```swift
Button("설정") {
    coordinator.push(.settings) // Coordinator의 push 메서드 호출
}

```

`coordinator.push(.settings)`가 호출되면, `Coordinatorable` 프로토콜의 확장에서 정의된 `push` 메서드가 실행

```swift
public extension Coordinatorable {
    func push(_ page: Screen...) {
        page.forEach {
            path.append($0) // NavigationPath에 새 화면 추가
            print("🔄 화면 이동: \($0)")
        }
    }
}

```

`path.append(.settings)`가 실행되면, `NavigationStack`이 이 변경사항을 감지하고 새로운 화면을 스택에 푸시. 

이때 `HomeCoordinatorView`의 `.navigationDestination`이 트리거되어 설정 화면이 생성됨.

```swift
.navigationDestination(for: HomeRouter.Screen.self) { screen in
    coordinator.view(screen) // screen이 .settings인 경우 SettingsView 반환
}
```

`coordinator.view(.settings)`가 호출되면, `HomeCoordinator`의 `view` 메서드가 실행됩니다.

```swift
@ViewBuilder
public func view(_ screen: Screen) -> some View {
    switch screen {
    case .main:
        HomeView()
    case .settings:
        SettingsView() // 설정 화면 생성
    }
}

```

## 7: 모달일 경우

```swift
// 어떤 View에서 사용자 정보 시트 호출
coordinator.sheet(.userInfo)

```

이는 `Coordinatorable`의 `sheet` 메서드를 호출합니다.

```swift
func sheet(_ sheet: SheetScreen) {
    self.sheet = sheet // sheet 상태 변경
    print("📋 시트 표시: \(sheet)")
}

```

`sheet` 프로퍼티가 변경되면, `HomeCoordinatorView`의 `.sheet` 모디파이어가 이를 감지하고 시트를 표시합니다.

```swift
.sheet(item: $bindableCoordinator.sheet) { sheet in
    NavigationView {
        coordinator.presentView(sheet) // 시트 내용 생성
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("닫기") {
                        coordinator.dismissSheet() // 시트 닫기
                    }
                }
            }
    }
}

```
