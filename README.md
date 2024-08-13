# diary_flutter
flutter project for google gemini competition by GemStar

## Getting Started
1. Copy the .env file with the GEMENI_API_KEY to the root of your project
2. Run
```bash
fvm install 3.22.2
fvm use 3.22.2
fvm flutter pub get
fvm dart run build_runner build
fluttergen -c flutter_gen.yaml
```
3. Deploy(YouTube thumbnail CORS issue forces HTML rendering)
```bash
fvm flutter build web --web-renderer html
firebase deploy 
```
