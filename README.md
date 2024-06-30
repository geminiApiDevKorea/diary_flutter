# diary_flutter

A new Flutter project.

## Getting Started

1. GEMENI_API_KEY가 입력된 .env 파일을 프로젝트의 root에 복사합니다

2. 프로젝트 실행(유툽 썸네일 CORS 이슈로 인해 HTML 렌더링 강제)
```bash
fvm install 3.22.2
fvm use 3.22.2
fvm flutter pub get
fvm dart run build_runner build
fvm flutter run -d chrome --web-renderer html
```

3. 배포(유튭 썸네일 CORS 이슈로 인해 HTML 렌더링 강제)
```bash
fvm flutter build web --web-renderer html
firebase deploy 
```
