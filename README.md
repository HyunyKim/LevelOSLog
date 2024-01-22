# LevelOSLog
OSLogExtension

## 실무에서 사용하던 로그 필터를 하나씩 적용해 보고 있습니다. 
### 패키지로 배포 하려고 하니 레벨 설정에는 무리가 좀 있는듯 하지만
### 최초로 지향 하던 방향을 밀고 나가려 합니다. 

## 아무것도 설정하지 않는다면 기본적으로 모든 레벨에 로그로 보이게 됩니다. 

## 원하는 레벨을 설정하고자 하면 LLog에 loglevels를 설정해 주세요

debug,network만 보고자 할떄의 설정입니다. 
```Swift
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear() {
            LLog.shared.changeLevel(levels: [.debug,.network])
        }
    }
}
```
