# Calculatrice d'Eric Loriaux

Prototype Flutter Android d'une calculatrice simple.

## Ce que ce prototype montre

- Une interface Flutter avec boutons, affichage et titre personnalise.
- Une logique de calcul separee de l'interface dans `lib/calculator_engine.dart`.
- Des tests unitaires du moteur de calcul et des tests de widgets Flutter.
- Une icone de lancement Android personnalisee.

## Commandes utiles

Depuis `S:\experiments\calculator_flutter` :

```powershell
flutter analyze
flutter test
flutter build apk --debug
flutter run -d emulator-5554 --debug --no-resident
```

Sur cette machine, le lint Android peut necessiter de recorriger le fichier local
ignore `android/local.properties` apres une commande Flutter, puis de lancer :

```powershell
cd S:\experiments\calculator_flutter\android
.\gradlew.bat lintDebug --rerun-tasks
```
