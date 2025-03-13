# HoneyRoutine
iOS Pomodoro &amp; Routine App with SwiftUI and Combine.

## 1. 프로젝트 목표
- 집중을 위한 심플하고 직관적인 타이머 제공
- 손가락 제스처를 이용한 빠르고 쉬운 시간 설정
- 최소한의 UI로 방해 요소 제거

## 2. 핵심 기능
- 기본 시간: **60분**, 최대 **180분** 설정 가능
- 손가락 제스처를 사용하여 다이얼 방식으로 시간 조정
- 시작 / 일시정지 / 버튼 제공
- 타이머 종료 시 알림(소리 또는 진동) 제공

## 3. 유저 플로우
1. 앱 실행 → 메인화면 기본값(60분) 표시
2. 손가락 제스처로 다이얼을 돌려 원하는 시간 설정
3. 시작버튼을 누르면 타이머 시작
4. 일시정지 버튼 사용 가능
5. 설정한 시간이 끝나면 알람 및 진동으로 알림 제공

## 4. 추가 고려사항
- 알람 방식 선택 가능: 사운드, 진동, 옵션 제공 고려
- **다크 모드 지원 여부**: 사용자 환경에 따라 최적의 UI 제공

## 5. 디자인 및 유저 플로우 문서
- [피그마 디자인 문서](https://www.figma.com/design/brJLUMcaCD3115jvg6KQ9M/HoneyRoutine?node-id=0-1&t=KYYdk14TlM1iP6Rc-1) 
- [피그마 유저 플로우 문서](https://www.figma.com/board/lZwOMVJyVZJ67qzs2XEz0M/HoneyRoutine-Planning?node-id=0-1&t=Bmst8jYcrnBnprfd-1)
---

## 6. Pomodoro Timer 설계 다이어그램

```mermaid
graph TD;
  subgraph Presentation Layer
    TimerView["🖼 TimerView (SwiftUI)"]
    TimerViewModel["⚙️ TimerViewModel (Combine)
    - startTimer()
    - stopTimer()
    - resetTimer()
    - updateRemainingTime()
    - bindToUseCase()"]
    TimerVC["📱 TimerViewController (Optional)"]
  end

  subgraph Domain Layer
    TimerUseCase["🛠 TimerUseCase
    - startTimer(duration: Int)
    - stopTimer()
    - resetTimer()
    - getCurrentTimer() -> TimerEntity?
    - updateRemainingTime(time: Int)"]
    
    TimerRepositoryProtocol["🔌 TimerRepositoryProtocol
    - saveTimer(_ timer: TimerEntity)
    - loadTimer() -> TimerEntity?
    - clearTimer()"]
    
    TimerEntity["🗂 TimerEntity
    - duration: Int
    - remainingTime: Int
    - isRunning: Bool"]
    
    TimerProtocol["⏳ TimerProtocol
    - start(duration: Int)
    - stop()
    - reset()
    - remainingTimerObservable: Observable<Int> (Combine 문법으로 변경 필요)"]
  end

  subgraph Data Layer
    TimerRepository["💾 TimerRepository
    - saveTimer(_ timer: TimerEntity)
    - loadTimer() -> TimerEntity?
    - clearTimer()"]
    
    TimerLocalDataBase["📂 TimerLocalDataBase
    - saveTimer(_ timer: TimerEntity)
    - loadTimer() -> TimerEntity?
    - clearTimer()"]
  end

  %% 연결 관계 설정
  TimerView -->|데이터 바인딩| TimerViewModel
  TimerViewModel -->|UseCase 호출| TimerUseCase
  TimerUseCase -->|타이머 동작| TimerProtocol
  TimerUseCase -->|데이터 저장/불러오기| TimerRepositoryProtocol
  TimerRepositoryProtocol -->|실제 구현| TimerRepository
  TimerRepository -->|데이터 저장/로드| TimerLocalDataBase