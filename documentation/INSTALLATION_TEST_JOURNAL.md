# Journal des installations et tests

Ce journal conserve la mémoire chronologique des installations, configurations,
tests, incidents et solutions du projet Smartphone.

Le fichier Markdown est la source de vérité. Un export PDF avec Pandoc ne doit
être généré qu'à la demande explicite d'Eric. Les entrées les plus récentes sont
placées en haut.

## 2026-07-31 01:23 - Première installation sur le Motorola physique

- Cible : Motorola Edge 50 Ultra, Android 16/API 36, architecture ARM64.
- Préparation effectuée par Eric sur le téléphone :
  - activation des options pour les développeurs ;
  - activation du débogage USB ;
  - connexion USB et autorisation de l'ordinateur.
- Détection :
  - `adb devices -l` retourne le téléphone dans l'état `device` ;
  - `flutter devices` identifie le Motorola comme cible Android ARM64 ;
  - le numéro de série matériel n'est pas consigné dans Git.
- Projet :
  `S:\Smartphone\experiments\calculator_flutter`.
- APK Debug :
  `build\app\outputs\flutter-apk\app-debug.apk`, 75 530 239 octets.
- Installation :
  `adb -s <appareil> install -r <app-debug.apk>` retourne `Success`.
- Paquet Android installé :
  `com.ericloriaux.calculator_flutter`.
- Validation sur l'appareil physique :
  - l'activité `com.ericloriaux.calculator_flutter.MainActivity` est au premier
    plan ;
  - la hiérarchie Android de l'interface contient le titre
    `Calculatrice d'Eric Loriaux` ;
  - l'affichage initial `0` est présent.
- Incidents et solutions :
  - `flutter run --debug --no-resident` a dépassé la limite locale de 124
    secondes sans restituer sa sortie, mais avait produit l'APK ; installation
    finalisée directement avec ADB ;
  - une première commande de lancement utilisait l'identifiant Flutter
    générique `com.example.calculator_flutter` et n'a trouvé aucune activité ;
    relance réussie avec l'identifiant réel
    `com.ericloriaux.calculator_flutter`.
- Résultat : la calculatrice Debug est installée et ouverte sur le téléphone
  physique. Elle reste utilisable après déconnexion du câble USB.
- Aucun PDF Pandoc généré.

## 2026-07-31 01:09 - Extension du lecteur virtuel S: aux projets Codex

- Outil : commande Windows intégrée `subst`.
- Ancienne association :
  `S:\` vers `D:\$rapatries\Documents\Codex\Smartphone`.
- Nouvelle association :
  `S:\` vers `D:\$rapatries\Documents\Codex`.
- Commandes PowerShell importantes :
  - `subst S: /D` pour retirer uniquement l'ancienne association virtuelle ;
  - `subst S: 'D:\$rapatries\Documents\Codex'` pour créer l'association commune.
- Motivation : conserver le contournement du défaut Flutter 3.44.8 avec le
  caractère `$` tout en permettant l'emploi de `S:` par les autres projets
  placés dans le dossier Codex.
- Chemin Flutter du projet Smartphone après le changement :
  `S:\Smartphone\experiments\calculator_flutter`.
- Vérifications :
  - `subst` retourne
    `S:\: => D:\$rapatries\Documents\Codex` ;
  - `S:\Smartphone` existe ;
  - `S:\Smartphone\experiments\calculator_flutter` existe ;
  - `flutter test`, exécuté depuis ce nouveau chemin, réussit les 7 tests.
- Incident utile : une première commande utilisant des guillemets doubles sous
  PowerShell a interprété `$rapatries` comme une variable et produit
  momentanément l'association incorrecte `S:\` vers `D:\Documents\Codex`.
  L'association a été retirée puis recréée avec des apostrophes. Aucun fichier
  réel n'a été déplacé, copié, modifié ou supprimé par `subst`.
- Persistance : l'association devra être recréée après un redémarrage de
  Windows.
- Aucun PDF Pandoc généré.

## 2026-07-31 01:04 - Prototype Calculatrice Flutter

- Projet créé :
  `D:\$rapatries\Documents\Codex\Smartphone\experiments\calculator_flutter`.
- Objectif : deuxième prototype Flutter Android, plus proche d'une vraie app que
  le compteur initial.
- Fonctionnalités :
  - calculatrice simple avec `+`, `-`, `×`, `÷`, `=`, `C`, retour arrière,
    inversion de signe et virgule décimale ;
  - titre visible : `Calculatrice d'Eric Loriaux` ;
  - icône de lancement Android personnalisée à partir de l'image fournie par
    Eric ;
  - logique séparée dans `lib/calculator_engine.dart` ;
  - interface dans `lib/main.dart`.
- Ressources graphiques :
  - source conservée :
    `experiments/calculator_flutter/assets/icons/eric_loriaux_launcher_source.png` ;
  - icônes Android générées dans les dossiers `mipmap-mdpi`, `mipmap-hdpi`,
    `mipmap-xhdpi`, `mipmap-xxhdpi` et `mipmap-xxxhdpi`.
- Validations Flutter :
  - `dart format lib test` ;
  - `flutter analyze` : aucun problème ;
  - `flutter test` : 7 tests réussis.
- Validations Android :
  - `flutter build apk --debug` : APK généré ;
  - `flutter run -d emulator-5554 --debug --no-resident` : app installée et
    lancée sur `emulator-5554` ;
  - test ADB `2 + 3 = 5` : titre et affichage vérifiés par `uiautomator dump` ;
  - `gradlew.bat lintDebug --rerun-tasks` : `BUILD SUCCESSFUL`.
- Capture de validation conservée localement hors Git :
  `tmp/test-results/calculator_flutter.png`.
- Incidents et solutions :
  - fenêtre d'émulateur à nouveau ouverte hors écran, replacée à `Left=25`,
    `Top=25`, `Width=420`, `Height=850` avec l'API Win32 `MoveWindow` ;
  - dialogue `System UI isn't responding`, résolu par le choix `Wait` ;
  - `android/local.properties`, ignoré par Git, est réécrit par Flutter avec des
    chemins Windows qui font échouer Android Lint ; correction locale appliquée
    avant le lint final.
- Aucun PDF Pandoc généré.

## 2026-07-25 22:25 - Validation après redémarrage de Codex

- Action utilisateur : redémarrage de ChatGPT Codex, puis fermeture volontaire
  de l'émulateur Android.
- Résultat PATH :
  - `flutter --version` fonctionne directement et retourne Flutter 3.44.8 ;
  - `dart --version` fonctionne directement et retourne Dart 3.12.2 ;
  - `adb devices` fonctionne directement.
- Résultat ADB : aucun appareil listé, état cohérent avec la fermeture de
  l'émulateur Android par Eric.
- Git : branche `main` alignée sur `origin/main`, aucun changement local avant
  cette entrée de journal.
- Lecteur de substitution `S:` encore présent dans la session Windows.

## 2026-07-25 22:18 - Validation Android Lint

- Première commande : `gradlew.bat lintDebug`.
- Résultat initial : échec local sur `android/local.properties`, fichier ignoré
  par Git, car Android Lint exige l'échappement complet des chemins Windows dans
  les fichiers `.properties`.
- Correction locale :
  - `sdk.dir=C\:\\Users\\Eric\\AppData\\Local\\Android\\Sdk` ;
  - `flutter.sdk=C\:\\Users\\Eric\\develop\\flutter`.
- Relance : `gradlew.bat lintDebug --rerun-tasks`.
- Résultat : `BUILD SUCCESSFUL` en 44 secondes.
- Observations non bloquantes : avertissements de compatibilité Kotlin/Gradle et
  un avertissement `drawable-v21` issu du squelette Flutter généré.
- Contrôle final `flutter doctor -v` :
  - Android toolchain validée avec SDK 36.0.0 et licences acceptées ;
  - émulateur Android visible comme appareil connecté `emulator-5554` ;
  - avertissement de session sur le PATH Flutter, alors que le PATH utilisateur
    contient bien `C:\Users\Eric\develop\flutter\bin` ;
  - Visual Studio signale l'absence du workload C++ pour les apps Windows
    natives, sans impact sur les essais Android.

## 2026-07-25 22:11 - Nettoyage des archives temporaires d'installation

- Suppression des dossiers temporaires validés comme internes au projet :
  `tmp/flutter-install` et `tmp/android-install`.
- Espace libéré : environ 2,1 Go.
- Conservation de `tmp/test-results/hello_flutter.png`, qui contient la capture
  de validation du premier écran Flutter.
- Aucun PDF Pandoc généré.

## 2026-07-25 22:04 - Validation fonctionnelle du premier écran Flutter

- Projet :
  `D:\$rapatries\Documents\Codex\Smartphone\experiments\hello_flutter`.
- Cible : `emulator-5554`, AVD `Smartphone_Pixel_7_API_36`,
  Android 16/API 36.
- Vérifications :
  - activité au premier plan :
    `com.ericloriaux.hello_flutter/.MainActivity` ;
  - paquet `com.ericloriaux.hello_flutter` installé ;
  - rendu visuel contrôlé par capture ADB ;
  - appui ADB sur le bouton `+` ;
  - hiérarchie UI contrôlée avec `uiautomator dump`.
- Résultat : le compteur passe de `0` à `1` et le bouton accessible
  `Increment` reste actif. Premier essai Android réussi.
- Capture temporaire :
  `tmp/test-results/hello_flutter.png`, non versionnée.

## 2026-07-25 22:03 - Installation et lancement de l'application

- Commande depuis le lecteur de substitution `S:` :
  `flutter run -d emulator-5554 --debug --no-resident`.
- Résultat :
  - compilation incrémentale : 33,0 secondes ;
  - APK installé en environ 3 secondes ;
  - application synchronisée et lancée ;
  - moteur Flutter Impeller actif avec OpenGLES.
- Avertissement informatif : évolution future de la transmission des drapeaux
  du moteur Flutter par `Intent`; aucun effet sur ce prototype.

## 2026-07-25 22:02 - Première compilation APK réussie

- Commande : `flutter build apk --debug`.
- Java :
  `C:\Program Files\Android\Android Studio\jbr\bin\java.exe`,
  OpenJDK 21.0.10.
- Gradle : 9.1.0 via le wrapper du projet.
- Résultat :
  `build\app\outputs\flutter-apk\app-debug.apk` créé avec succès.
- Durée : environ 812,5 secondes.
- Explication : premier téléchargement Gradle, résolution des dépendances Maven
  et installation du NDK et de CMake. Les caches sont ensuite réutilisés.

## 2026-07-25 22:01 - Installation automatique de CMake

- Composant : CMake 3.22.1.
- Chemin :
  `C:\Users\Eric\AppData\Local\Android\Sdk\cmake\3.22.1`.
- Déclencheur : première compilation du modèle Flutter Android.
- Résultat : licence déjà acceptée, installation terminée par Gradle.

## 2026-07-25 21:57 - Installation automatique du NDK Android

- Composant : NDK Side by side 28.2.13676358.
- Chemin :
  `C:\Users\Eric\AppData\Local\Android\Sdk\ndk\28.2.13676358`.
- Déclencheur : première compilation du modèle Flutter Android.
- Résultat : licence déjà acceptée, installation terminée par Gradle.

## 2026-07-25 21:50 - Correction de la confiance TLS de Gradle

- Échec initial : `flutter build apk --debug` ne pouvait pas télécharger Gradle
  et renvoyait `SSLHandshakeException` puis `PKIX path building failed`.
- Diagnostic vérifié avec une connexion TLS .NET à `services.gradle.org` :
  Norton remplace le certificat distant pendant son analyse HTTPS et le signe
  avec `Norton Web/Mail Shield Root`.
- Cette autorité publique est approuvée par Windows, mais absente du magasin
  Java JBR.
- Solution sécurisée :
  - copie du magasin JBR vers
    `C:\Users\Eric\.gradle\truststores\jbr-plus-windows-cacerts.p12` ;
  - ajout de l'autorité Norton déjà approuvée par Windows ;
  - variable utilisateur `GRADLE_OPTS` configurée pour ce magasin.
- Vérification : empreinte SHA-256 de l'entrée contrôlée avec `keytool`; les
  téléchargements Gradle et Maven ont ensuite abouti.
- Aucune désactivation de la vérification TLS n'a été utilisée.

## 2026-07-25 21:48 - Configuration du Java d'Android Studio

- Commande :
  `flutter config --jdk-dir="C:\Program Files\Android\Android Studio\jbr"`.
- Version : OpenJDK Runtime Environment 21.0.10, JetBrains Runtime.
- Motif : utiliser la combinaison Android officielle plutôt que le JDK général
  25.0.3 déjà installé.
- Vérification : `flutter doctor -v` rapporte ce binaire et conserve la chaîne
  Android au vert.
- Ce changement seul ne corrigeait pas le certificat Norton; la solution est
  consignée dans l'entrée de 21:50.

## 2026-07-25 21:45 - Test Flutter et contournement du caractère `$`

- Commande initiale depuis le chemin réel : `flutter test`.
- Échec : Flutter 3.44.8 a généré un import Dart contenant
  `file:///D:/$rapatries/...`; Dart a interprété `$rapatries` comme une
  interpolation et refusé l'URI.
- Le code de l'application n'était pas en cause.
- Solution :
  `subst S: "D:\$rapatries\Documents\Codex\Smartphone"`, puis exécution depuis
  `S:\experiments\hello_flutter`.
- Résultat : `Counter increments smoke test` réussi, `All tests passed`.
- Portée : l'association `subst` doit être recréée après un redémarrage.

## 2026-07-25 21:43 - Fin du premier démarrage de l'émulateur

- ADB : `emulator-5554` passe de `offline` à `device`.
- Propriétés vérifiées :
  - `sys.boot_completed=1` ;
  - `init.svc.bootanim=stopped` ;
  - Android 16, API 36 ;
  - résolution 1080 × 2400.
- Flutter détecte l'appareil comme `android-x64`.
- Incident : fenêtre de 394 × 881 pixels restaurée à la coordonnée verticale
  `-661`, donc presque entièrement hors écran.
- Solution : fenêtre replacée à `(25, 5)` et réduite à 369 × 825 pixels avec
  l'API Windows `MoveWindow`.
- Incident temporaire : dialogue `System UI isn't responding`.
- Action : choix `Wait`, et non fermeture de l'interface système.
- Résultat : retour à l'écran d'accueil; incident non reproduit.

## 2026-07-25 21:39 - Redémarrage à froid de l'émulateur

- Symptôme : `adb devices` indiquait durablement `emulator-5554 offline`.
- Action : arrêt des seuls processus lancés pour ce test, puis :
  `emulator -avd Smartphone_Pixel_7_API_36 -no-metrics -no-snapshot -wipe-data -gpu host`.
- Justification de `-wipe-data` : AVD neuf sans donnée utilisateur.
- Résultat différé : démarrage complet réussi; la première initialisation a
  simplement demandé plusieurs minutes.

## 2026-07-25 21:35 - Premier lancement de l'appareil virtuel

- AVD : `Smartphone_Pixel_7_API_36`.
- Contrôles positifs :
  - image système trouvée ;
  - hyperviseur et espace disque compatibles ;
  - GPU NVIDIA GeForce RTX 2060 et Intel UHD détectés ;
  - Vulkan/OpenGL initialisés ;
  - WHPX opérationnel.
- Avertissements :
  - absence de `quickbootChoice.ini`, normale au premier lancement ;
  - `Downloaded protobuf file is corrupt`.
- Conclusion vérifiée a posteriori : l'image système n'était pas corrompue,
  puisque l'émulateur a démarré et exécuté l'application Flutter. Le message
  concernait vraisemblablement une donnée auxiliaire ou un instantané
  téléchargeable; cette attribution précise reste une inférence.
- Les lancements automatisés suivants utilisent `-no-metrics`.

## 2026-07-25 21:33 - Création du Pixel 7 virtuel

- Nom : `Smartphone_Pixel_7_API_36`.
- Profil : Pixel 7.
- Système : Android 16/API 36, Google APIs, x86_64, révision 7.
- Carte SD virtuelle : 512 Mo.
- Chemin :
  `C:\Users\Eric\.android\avd\Smartphone_Pixel_7_API_36.avd`.
- Vérifications matérielles :
  - mémoire physique : environ 31,8 Go ;
  - `HypervisorPresent=True` ;
  - WHPX 10.0.26200 installé et utilisable selon `emulator -accel-check`.

## 2026-07-25 21:30 - Installation d'Android Studio

- Méthode : paquet WinGet officiel `Google.AndroidStudio`.
- Version : 2026.1.2.10, Android Studio Quail 2.
- Chemin :
  `C:\Program Files\Android\Android Studio\bin\studio64.exe`.
- Une demande UAC a été acceptée par Eric.
- Résultat : installation réussie; JetBrains Runtime 21.0.10 disponible.

## 2026-07-25 21:25 - Installation de la chaîne Android

- Android SDK :
  `C:\Users\Eric\AppData\Local\Android\Sdk`.
- Archive officielle :
  `commandlinetools-win-15859902_latest.zip`.
- SHA-256 vérifié :
  `90ae805d20434428bffcb699c290860f19bb5f66a67e6b330067e3de801fb04a`.
- Composants initiaux :
  - Command-line Tools 22.0 ;
  - Platform Tools 37.0.0 ;
  - ADB 1.0.41, build 14910828 ;
  - Platform Android API 36, révision 2 ;
  - Build Tools 36.0.0 ;
  - Emulator 36.6.11, build 15507667 ;
  - image Android 16/API 36 Google APIs x86_64, révision 7.
- Configuration :
  - variable utilisateur `ANDROID_HOME` ;
  - `platform-tools` et `cmdline-tools\latest\bin` ajoutés au `PATH` ;
  - `flutter config --android-sdk` ;
  - licences Android acceptées.
- Les commandes compatibles ont utilisé `--no-metrics`.
- Vérification : `flutter doctor -v` valide Android. Le composant Windows C++
  manquant dans Visual Studio n'affecte pas Android.

## 2026-07-25 21:22 - Création du premier projet Flutter

- Commande :
  `flutter create --platforms=android --org com.ericloriaux --project-name hello_flutter`.
- Chemin :
  `D:\$rapatries\Documents\Codex\Smartphone\experiments\hello_flutter`.
- Résultat : 35 fichiers créés et dépendances Dart résolues.
- Analyse : `flutter analyze` réussie, `No issues found`.

## 2026-07-25 21:20 - Extensions Flutter et Dart pour VS Code

- Visual Studio Code : 1.128.1.
- Extensions :
  - `dart-code.flutter` 3.138.0 ;
  - `dart-code.dart-code` 3.138.0.
- Premier essai : échec Node.js `unable to verify first certificate`.
- Solution : relance de la seule commande avec
  `NODE_OPTIONS=--use-system-ca`.
- Résultat : extensions installées sans désactiver TLS.

## 2026-07-25 21:18 - Validation de Flutter et Dart

- Flutter 3.44.8, canal `stable`.
- Dart 3.12.2.
- DevTools 2.57.0.
- Flutter :
  `C:\Users\Eric\develop\flutter\bin\flutter.bat`.
- Dart :
  `C:\Users\Eric\develop\flutter\bin\cache\dart-sdk\bin\dart.exe`.
- Actions :
  - Flutter ajouté au `PATH` utilisateur ;
  - télémétrie désactivée par `flutter config --no-analytics`.
- Incident Git interne : accès distant refusé par le backend OpenSSL.
- Solution : backend `schannel` configuré uniquement dans le dépôt Git du SDK;
  `git ls-remote` réussi.
- Les applications déjà ouvertes doivent être redémarrées pour hériter du
  nouveau `PATH`.

## 2026-07-25 21:14 - Création du journal

- Action : création du journal et report rétroactif des opérations.
- Résultat : journal actif dans
  `documentation/INSTALLATION_TEST_JOURNAL.md`.
- Export PDF : non généré, conformément à la demande d'Eric.

## 2026-07-25 21:08 - Téléchargement et contrôle de Flutter

- Première tentative avec `C:\Windows\System32\curl.exe`.
- Échec TLS :
  `CRYPT_E_NO_REVOCATION_CHECK (0x80092012)`.
- Aucun contournement par désactivation TLS.
- Solution : `Invoke-WebRequest`, avec le client HTTPS Windows.
- Archive temporaire :
  `tmp\flutter-install\flutter_windows_3.44.8-stable.zip`.
- Taille : environ 1,81 Go.
- SHA-256 calculé identique à l'officiel.
- Extraction réussie vers `C:\Users\Eric\develop\flutter`.

## 2026-07-25 21:07 - Sélection de Flutter stable

- Source :
  `https://storage.googleapis.com/flutter_infra_release/releases/releases_windows.json`.
- Flutter 3.44.8 `stable`, Dart 3.12.2, publication du 23 juillet 2026.
- Archive :
  `stable/windows/flutter_windows_3.44.8-stable.zip`.
- SHA-256 officiel :
  `095c108a08e0377d8a6501fed65aeb288908a070ed3f135e525dc6431c7686e4`.
- Installation choisie :
  `C:\Users\Eric\develop\flutter`.
- Espace libre : 132,5 Go sur `C:` et 106,0 Go sur `D:`.

## 2026-07-25 21:06 - Vérification de Pinokio

- Motif : la skill Codex Pinokio imposait une recherche préalable pour une tâche
  d'installation.
- Configuration détectée : `D:\pinokio`.
- Aucun exécutable `pterm` résolu; `127.0.0.1:42000` refusait la connexion.
- Modification Pinokio : aucune.
- Décision : ne pas utiliser Pinokio; Flutter est installé comme SDK officiel
  indépendant.

## 2026-07-25 21:05 - État initial

- Système : Windows 11 Famille 64 bits, version 10.0.26200.
- Flutter, Dart et chaîne Android : absents.
- Visual Studio Code 1.128.1 déjà présent :
  `C:\Users\Eric\AppData\Local\Programs\Microsoft VS Code\Code.exe`.
- Java JDK 25.0.3 LTS déjà présent :
  `C:\Program Files\Java\jdk-25.0.3`.
- Objectif autorisé : installer Flutter avec Dart et préparer un premier essai
  Android.
