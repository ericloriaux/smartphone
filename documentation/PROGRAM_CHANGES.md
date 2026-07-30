# Journal des changements du projet Smartphone

## 2026-07-31 01:09 - Extension du lecteur virtuel S: aux projets Codex

- Fichiers concernés : `AGENTS.md`,
  `documentation/INSTALLATION_TEST_JOURNAL.md` et
  `documentation/PROGRAM_CHANGES.md`.
- Changement visible : `S:` représente désormais le dossier commun
  `D:\$rapatries\Documents\Codex`; le projet Smartphone est accessible sous
  `S:\Smartphone`.
- Changement technique : remplacement de l'association `subst` limitée au
  projet Smartphone par une association réutilisable pour les autres projets
  Codex. La commande documentée emploie des apostrophes PowerShell afin de
  préserver littéralement le caractère `$`.
- Incident documenté : association transitoire incorrecte vers
  `D:\Documents\Codex`, immédiatement retirée sans modification des fichiers.
- Vérifications : association retournée par `subst`, existence de
  `S:\Smartphone` et du prototype `S:\Smartphone\experiments\calculator_flutter`,
  puis 7 tests Flutter réussis depuis ce nouveau chemin.
- Raison : rendre le contournement du défaut Flutter lié au caractère `$`
  commun à l'ensemble des projets d'Eric.
- Aucun PDF Pandoc généré.

## 2026-07-31 01:04 - Ajout du prototype Calculatrice Flutter

- Fichiers concernés : `experiments/calculator_flutter/`,
  `documentation/INSTALLATION_TEST_JOURNAL.md` et
  `documentation/PROGRAM_CHANGES.md`.
- Changement visible : ajout d'une app Android Flutter intitulée
  `Calculatrice d'Eric Loriaux`, avec boutons de calcul, affichage, gestion des
  décimales à virgule, division par zéro et icône de lancement personnalisée.
- Changement technique : séparation de la logique dans
  `lib/calculator_engine.dart`, interface Flutter dans `lib/main.dart`, tests
  unitaires et widget tests, conservation de l'image source de l'icône et
  génération des densités Android.
- Incidents documentés : fenêtre d'émulateur hors écran, ralentissement
  `System UI`, et réécriture locale de `android/local.properties` par Flutter
  avant le lint.
- Vérifications : `flutter analyze`, `flutter test`, `flutter build apk
  --debug`, installation/lancement sur `emulator-5554`, test ADB `2 + 3 = 5`,
  capture visuelle et `gradlew.bat lintDebug --rerun-tasks`.
- Documentation : README du prototype et journal d'installation/test mis à jour.
  Aucun PDF Pandoc généré.
- Raison : disposer d'un premier prototype applicatif compréhensible pour
  apprendre Flutter avec une logique métier testable et une interface Android.

## 2026-07-25 22:04 - Environnement Flutter Android installé et validé

- Fichiers concernés : `AGENTS.md`,
  `documentation/INSTALLATION_TEST_JOURNAL.md`,
  `documentation/PROGRAM_CHANGES.md` et
  `experiments/hello_flutter/`.
- Changement visible : un Pixel 7 virtuel sous Android 16/API 36 démarre sous
  Windows et affiche le premier écran Flutter; son compteur réagit au bouton `+`.
- Changement technique : installation et validation de Flutter 3.44.8, Dart
  3.12.2, Android Studio 2026.1.2.10, Android SDK/API 36, ADB, émulateur, image
  x86_64, JBR 21, Gradle 9.1, NDK 28.2 et CMake 3.22.1; ajout des extensions VS
  Code Flutter et Dart; conservation du wrapper Gradle dans le prototype pour
  éviter toute dépendance à une installation Gradle globale.
- Incidents documentés : premier démarrage ADB lent, avertissement protobuf sans
  corruption de l'image, fenêtre hors écran, ralentissement de System UI,
  caractère `$` non échappé par `flutter test` et certificat Norton absent du
  magasin Java.
- Solutions : démarrage à froid sans instantané, remise en place de la fenêtre,
  choix `Wait`, lecteur `subst S:`, JBR Android Studio et magasin de confiance
  Gradle dédié sans désactivation TLS.
- Vérifications : `flutter doctor` valide Android; `flutter analyze`,
  `flutter test` et `gradlew.bat lintDebug --rerun-tasks` réussissent; APK Debug
  compilé, installé et lancé; activité et paquet contrôlés avec ADB; compteur
  passé de 0 à 1 et rendu inspecté.
- Documentation : inventaire et journal d'installation détaillés mis à jour.
  Aucun PDF Pandoc généré.
- Raison : disposer d'une première chaîne Android reproductible avant de
  développer les essais d'applications.

## 2026-07-25 21:14 - Création du journal des installations et tests

- Fichiers concernés : `AGENTS.md`,
  `documentation/INSTALLATION_TEST_JOURNAL.md` et
  `documentation/PROGRAM_CHANGES.md`.
- Changement visible : création d'une mémoire chronologique dédiée aux
  installations, configurations, essais, incidents et solutions.
- Changement technique : obligation de consigner versions, chemins, commandes
  importantes et résultats réellement vérifiés.
- Impact documentaire : le Markdown devient la source de vérité de ce journal ;
  aucun export PDF Pandoc ne doit être produit sans demande explicite d'Eric.
- Raison : permettre de reproduire ultérieurement l'environnement et de retrouver
  l'historique exact des essais.
- Vérifications : les opérations Flutter déjà réalisées le 25 juillet 2026 ont
  été reportées rétroactivement.

## 2026-07-25 21:03 - Priorité donnée aux essais Android

- Fichiers concernés : `AGENTS.md`,
  `documentation/decisions/ADR-0001-priorite-android.md` et
  `documentation/PROGRAM_CHANGES.md`.
- Changement visible : les premiers prototypes seront installés et testés sur le
  smartphone Android physique d'Eric.
- Changement technique : la chaîne iOS n'est pas configurée pendant la première
  phase ; la compatibilité future reste un critère de sélection et la compilation
  distante via GitHub Actions est conservée comme option.
- Impact documentaire : création de la première décision d'architecture.
- Raison : commencer avec la plateforme réellement disponible tout en évitant de
  fermer la voie à une version iPhone ultérieure.
- Vérifications : cohérence contrôlée avec la priorité Android et les limites iOS
  déjà documentées dans `AGENTS.md`.

## 2026-07-25 20:35 - Initialisation des règles du projet

- Fichiers concernés : `AGENTS.md`, `.gitignore` et
  `documentation/PROGRAM_CHANGES.md`.
- Changement visible : création du cadre de travail pour l'étude et le futur
  développement d'applications Android, avec possibilité multiplateforme.
- Changement technique : définition des règles de développement, sécurité,
  tests, documentation, backups et Git ; inventaire initial des outils mobiles
  présents et absents sur le PC ; initialisation du dépôt Git local sur `main`,
  configuration de `origin`, de `schannel`, de Git Credential Manager et de
  l'identité locale utilisée par les projets DMG et Kine.
- Impact documentaire : adaptation locale du document externe
  `D:\$rapatries\Documents\Codex\DMG\documentation\AGENTS_STANDARDS_TRANSVERSES_FR.md`,
  consulté en lecture seule.
- Raison : initialiser le projet Smartphone avant toute discussion structurante
  ou sélection de framework.
- Vérifications : lecture intégrale des 410 lignes de la source ; contrôle des
  chemins d'outils ; versions Java, Node.js, npm et .NET vérifiées ; workloads
  .NET listés ; absence de la chaîne Android et de Flutter contrôlée ; dépôt
  GitHub distant interrogé avec le magasin de certificats Windows ; configurations
  Git de Boursier, DMG et Kine comparées en lecture seule.
