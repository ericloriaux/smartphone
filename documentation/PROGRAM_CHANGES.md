# Journal des changements du projet Smartphone

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
