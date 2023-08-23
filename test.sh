cd counter_app/
flutter clean
sh build-flutter-app.sh
cd ..
cd flathub_repo
flatpak-builder --user --install --force-clean build-dir com.example.FlutterApp.yml
flatpak run com.example.FlutterApp