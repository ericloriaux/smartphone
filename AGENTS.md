# Instructions pour les agents — projet Smartphone

## Portée et autorité

- Ce fichier s'applique à tout le projet situé dans
  `D:\$rapatries\Documents\Codex\Smartphone`.
- Répondre à Eric dans sa langue de travail, le français sauf demande contraire.
- La source transversale utilisée pour initialiser ces règles est
  `D:\$rapatries\Documents\Codex\DMG\documentation\AGENTS_STANDARDS_TRANSVERSES_FR.md`.
- Cette source et tous les autres répertoires hors du projet Smartphone sont en
  lecture seule. Ne jamais y créer, modifier, déplacer ou supprimer un fichier.
- Enregistrer tous les nouveaux livrables, diagnostics et fichiers temporaires
  dans le projet Smartphone, sauf demande explicite contraire.
- Si une règle générique locale devrait normalement être reportée dans la source
  transversale, ne pas modifier celle-ci : signaler à Eric la synchronisation à
  effectuer.
- Une instruction explicite d'Eric prime sur ce fichier. En cas de conflit ou
  d'action irréversible dont la portée est incertaine, demander confirmation.

## Objet et état du projet

- Le projet sert d'abord à étudier, comparer, prototyper puis éventuellement
  développer des applications pour smartphones.
- Android est la cible prioritaire.
- Les premiers prototypes et essais doivent être construits, installés et testés
  sous Android, notamment sur le smartphone physique dont Eric dispose.
- Ne pas engager de configuration, compilation ou publication iOS pendant cette
  première phase, sauf nouvelle demande explicite d'Eric.
- Une solution commune Android/iPhone doit être étudiée lorsqu'elle est réaliste,
  sans sacrifier un besoin Android essentiel.
- Conserver la compatibilité iPhone comme objectif ultérieur. Si la pile choisie
  le permet, GitHub Actions sur runner macOS constitue la première option de
  compilation iOS distante pour le dépôt public ; Codemagic reste une solution de
  repli spécialisée. La signature et la publication resteront soumises aux
  exigences Apple, et un build distant ne remplace pas un test iOS interactif.
- Au 25 juillet 2026, Flutter 3.44.8 avec Dart 3.12.2 est la pile expérimentale
  installée et validée pour les premiers essais Android. Ce choix d'essai ne
  constitue pas encore une décision définitive d'architecture ou de
  distribution.
- Ne pas transformer une discussion exploratoire en choix technologique implicite.
  Documenter toute décision structurante dans `documentation/decisions/` sous
  forme d'ADR court : contexte, options, décision, raisons, conséquences et date.

## Démarche de choix technologique

Avant de recommander une pile, comparer au minimum lorsque les besoins le
justifient :

- Android natif avec Kotlin et Jetpack Compose ;
- Flutter ;
- React Native, avec ou sans Expo selon les fonctions natives nécessaires ;
- .NET MAUI ;
- application Web progressive et, si pertinent, emballage avec Capacitor ;
- développement iOS natif avec Swift uniquement si un environnement macOS/Xcode
  devient disponible.

Évaluer chaque option avec des critères explicites :

- fonctions attendues et accès au matériel du téléphone ;
- qualité de l'expérience Android ;
- possibilité réelle de partager le code avec iOS ;
- performances, fonctionnement hors ligne et tâches en arrière-plan ;
- accessibilité, internationalisation et tailles d'écran ;
- maturité, maintenance, dépendances et pérennité ;
- tests, débogage, publication, signature et mises à jour ;
- nécessité d'un Mac, de services distants ou d'abonnements ;
- compétences requises, délai, coût et complexité opérationnelle.

Ne pas affirmer qu'iOS est validé parce qu'un framework est multiplateforme. Sur
ce poste Windows, le build final, la signature et la soumission App Store exigent
normalement macOS avec Xcode, localement ou via un service distant autorisé. Toute
solution distante doit être présentée avec les données transmises, les coûts et
les contraintes de sécurité.

## Règles de développement

- Écrire les identifiants, noms de fichiers techniques, commentaires de code et
  logs techniques en anglais.
- Rédiger la documentation utilisateur en français par défaut.
- Suivre les conventions et formateurs officiels de la pile retenue.
- Documenter les parties non triviales pour qu'un développeur junior puisse les
  comprendre, sans commenter les évidences.
- Séparer l'interface, la logique métier, l'accès aux données et les intégrations
  externes. Ne pas enfouir la logique métier dans des écrans.
- Centraliser les constantes, la configuration et les textes visibles.
- Éviter les dépendances globales implicites. Épingler les versions utiles et
  conserver les fichiers de verrouillage générés par le gestionnaire retenu.
- Utiliser le wrapper fourni par le projet, par exemple `gradlew.bat`, plutôt
  qu'une installation globale de Gradle.
- Ne pas modifier un fichier généré si la source régénérable existe.
- Ne pas installer, mettre à jour ou supprimer un SDK, IDE, framework, workload,
  émulateur ou outil tiers sans accord explicite d'Eric.

### Python auxiliaire

Si des scripts Python sont ajoutés :

- utiliser `snake_case` pour variables et fonctions, `PascalCase` pour classes et
  `UPPER_SNAKE_CASE` pour constantes ;
- annoter les paramètres et retours, y compris `-> None` ;
- commencer chaque nouveau programme par un commentaire d'en-tête anglais
  expliquant son rôle fonctionnel ;
- placer immédiatement avant chaque import externe un commentaire anglais
  indiquant la dépendance et la commande `pip install` correspondante ;
- ne pas ajouter ce commentaire pour les modules de la bibliothèque standard.

## Portabilité des chemins et de la configuration

- Aucun programme ne doit dépendre du répertoire courant ou du champ Windows
  `Démarrer dans`.
- Ne pas utiliser `os.getcwd()` comme base des chemins applicatifs.
- Construire les chemins depuis le fichier source, la racine du projet ou les API
  officielles de la plateforme.
- Ne pas coder en dur un chemin propre à cette machine dans le code portable.
  Les chemins absolus de l'inventaire ci-dessous sont réservés aux automatisations
  locales et doivent rester configurables dans l'application.
- Créer automatiquement les sous-dossiers nécessaires.
- Lancer un script Python avec `sys.executable`.
- Les chemins choisis explicitement par l'utilisateur peuvent rester absolus.
- Ne jamais versionner `local.properties`, un chemin de SDK local, un dossier de
  SDK, un émulateur, un cache ou un répertoire de build.

## Sécurité, vie privée et publication mobile

- Demander uniquement les permissions Android/iOS strictement nécessaires et
  expliquer leur utilité à l'utilisateur.
- Ne jamais inscrire dans Git une clé API, un token, un mot de passe, un fichier
  de signature, une keystore, un certificat ou un profil de provisioning.
- Ne pas placer de secret durable directement dans le binaire applicatif.
- Ne pas journaliser de données personnelles, identifiants, tokens ou contenu
  sensible.
- Utiliser TLS et le stockage sécurisé de la plateforme pour les secrets locaux.
- Documenter les données collectées, leur finalité, leur destination et leur
  durée de conservation avant d'ajouter télémétrie, publicité ou analyse.
- Aucun achat, abonnement, compte développeur, publication en boutique, signature
  de version ou envoi à un service externe sans accord explicite d'Eric.
- Ne pas présenter un prototype, un APK ou un bundle généré comme prêt pour la
  production sans revue humaine, tests, contrôle des permissions, signature et
  validation de la fiche de boutique.

## Interface, accessibilité et langues

- Concevoir pour plusieurs tailles, densités, orientations et zones sûres.
- Respecter les composants et comportements natifs de la plateforme cible.
- Prévoir des libellés accessibles, un ordre de navigation cohérent, un contraste
  suffisant et le redimensionnement du texte.
- Ne pas utiliser la couleur comme seul vecteur d'information.
- Centraliser les textes visibles avec des clés anglaises stables.
- Prévoir le français dès le début et éviter la concaténation de fragments
  traduits.
- Sauvegarder le choix de langue si l'application permet de le modifier.
- Tester les textes longs, les nombres, dates, heures et unités localisés.

## Données, concurrence et traitements longs

- Pour les fichiers de configuration ou d'état partagés, protéger les accès
  concurrents et préférer une écriture atomique avec fichier temporaire unique
  puis remplacement.
- Nettoyer les temporaires après échec.
- Distinguer une erreur métier d'une erreur tardive de persistance.
- Empêcher les exécutions concurrentes dangereuses.
- Un verrou périmé ne doit jamais bloquer définitivement l'utilisateur.
- Fournir un état d'avancement et des messages d'erreur compréhensibles pour les
  synchronisations ou traitements longs.
- Respecter les contraintes de cycle de vie mobile : interruption, mise en
  arrière-plan, perte réseau, économie d'énergie et reprise.

## Vérifications attendues

- Adapter l'effort de validation au risque et à l'ampleur du changement.
- Exécuter les formateurs, l'analyse statique, les tests unitaires et les tests
  d'intégration disponibles avant de déclarer un changement terminé.
- Pour une interface, tester au minimum l'état nominal, le chargement, l'absence
  de données, l'erreur, la perte réseau et la restauration après interruption.
- Vérifier sur émulateur et appareil physique lorsque le matériel est disponible.
- Ne jamais prétendre qu'un test Android ou iOS a été effectué si la chaîne
  correspondante n'est pas installée ou si aucun appareil n'a été utilisé.
- Pour Android, valider au minimum le build Debug, les tests, le lint et
  l'installation sur une cible avant une livraison testable.
- Pour une version de diffusion, ajouter les contrôles Release, taille du paquet,
  versionnement, signature, permissions et comportement de mise à jour.

## Documentation et ressources graphiques

- Les Markdown sont les sources de vérité ; DOCX, PDF et PPTX sont des exports
  régénérables sauf décision explicite contraire.
- Maintenir `documentation/INSTALLATION_TEST_JOURNAL.md` comme journal
  chronologique détaillé de toutes les installations, configurations et
  validations réalisées pour le projet.
- Chaque entrée de ce journal doit indiquer au minimum la date et l'heure, l'outil
  ou le test, la version et le chemin concernés, les commandes ou actions
  importantes, le résultat réel, ainsi que les incidents et solutions vérifiées.
- Mettre le journal à jour pendant la tâche afin de conserver aussi les essais
  infructueux utiles au diagnostic, et pas uniquement le résultat final.
- Le Markdown de ce journal reste la source de vérité. Ne générer son export PDF
  avec Pandoc que si Eric le demande explicitement.
- Corriger la source puis régénérer un PDF ; ne pas modifier le PDF à la main.
- Après une modification significative d'un PDF, rendre les pages en images et
  vérifier visuellement coupures, chevauchements, glyphes, pages blanches,
  pagination, format, texte extrait et liens.
- Pour les icônes et illustrations, conserver la source éditable et produire les
  densités/formats requis par la plateforme sans écraser la source.
- Vérifier les droits d'utilisation de toute image, police, son ou contenu tiers.
- Placer les diagnostics temporaires dans `tmp/` et ne pas les versionner.

## Backups et journal des changements

- Avant une modification significative d'un fichier existant et validé, créer si
  nécessaire un backup dans `backups/` au format
  `nom_categorie_YYYYMMDD_HHMMSS.zip`.
- La création initiale d'un fichier qui n'existait pas ne requiert pas de backup
  vide.
- Ne jamais inclure d'autres ZIP dans un backup.
- Ajouter à l'archive un `readme.txt` cumulatif, du plus récent au plus ancien,
  indiquant date, raison, changements et fichiers concernés.
- Conserver au maximum les dix derniers backups de chaque catégorie, après avoir
  vérifié le nouveau backup.
- Les ZIP de backup restent locaux et ne sont pas versionnés.
- Maintenir `documentation/PROGRAM_CHANGES.md`, entrées les plus récentes en haut,
  avec date/heure, fichiers, changements visibles et techniques, raison,
  documentation et vérifications.
- Ajouter une note PO/FA en français lorsqu'un changement fonctionnel visible le
  justifie.

## Git et GitHub

- Le projet utilise Git.
- Dépôt officiel : `https://github.com/ericloriaux/smartphone`.
- La branche par défaut visée est `main`.
- Vérifier `git status -sb` et le diff avant toute modification ou publication.
- Après une longue interruption, faire un fetch puis uniquement un
  `pull --ff-only` lorsque c'est sûr. Ne jamais faire de merge automatique.
- Ne jamais utiliser `git reset --hard` ou `git checkout --` sans demande
  explicite.
- Ajouter explicitement seulement les fichiers concernés ; ne pas publier caches,
  builds, paquets de test, captures temporaires ou données volumineuses.
- Le workflow local validé, identique à DMG et Kine, autorise les commits et push
  directs sur `main` après vérification, lorsque la tâche demandée est terminée.
- Utiliser une branche dédiée et une pull request lorsqu'Eric le demande, lorsque
  plusieurs variantes doivent être comparées ou lorsqu'un changement risqué
  mérite une revue avant intégration.
- Identité Git locale de référence : `Eric Loriaux <eric.loriaux@gmail.com>`.
- L'authentification HTTPS passe par Git Credential Manager, helper `manager`
  fourni par l'installation Git système. Ne jamais intégrer d'identifiants dans
  l'URL du remote ou dans un fichier du projet.
- Le contrôle distant du 25 juillet 2026 indique un dépôt vide.
- Sur ce PC, Git avec son backend OpenSSL échoue actuellement sur la chaîne de
  certificats locale. La commande vérifiée utilise ponctuellement le magasin
  Windows : `git -c http.sslBackend=schannel ...`. Ne jamais contourner le
  problème avec `http.sslVerify=false`.
- GitHub CLI `gh` n'est pas installé au 25 juillet 2026 et n'est pas requis pour
  les commits et push Git directs. Il reste nécessaire uniquement aux opérations
  qui dépendent explicitement de ses fonctions, notamment certains workflows de
  pull request.

## Inventaire local validé

Utiliser les chemins absolus pour les automatisations. Ne jamais supposer qu'un
outil est disponible par son seul nom. Mettre cette section à jour dans la même
tâche après toute installation, mise à jour, suppression, reconfiguration ou
validation d'un outil.

### Outils directement pertinents pour le mobile

- Java JDK 25.0.3 LTS :
  `C:\Program Files\Java\jdk-25.0.3\bin\java.exe` et
  `C:\Program Files\Java\jdk-25.0.3\bin\javac.exe`. `JAVA_HOME` pointe vers ce
  JDK. Validation : `java -version` et `javac -version`, 25 juillet 2026.
- Flutter utilise toutefois le JetBrains Runtime OpenJDK 21.0.10 fourni avec
  Android Studio, configuré par `flutter config --jdk-dir` :
  `C:\Program Files\Android\Android Studio\jbr\bin\java.exe`.
- Flutter 3.44.8, canal `stable` :
  `C:\Users\Eric\develop\flutter\bin\flutter.bat`.
- Dart 3.12.2, fourni par Flutter :
  `C:\Users\Eric\develop\flutter\bin\cache\dart-sdk\bin\dart.exe`.
- Flutter DevTools 2.57.0 est fourni dans le SDK Flutter. La télémétrie Flutter
  a été désactivée avec `flutter config --no-analytics`.
- Android Studio 2026.1.2.10 :
  `C:\Program Files\Android\Android Studio\bin\studio64.exe`.
- Android SDK :
  `C:\Users\Eric\AppData\Local\Android\Sdk`. `ANDROID_HOME` pointe vers ce
  dossier.
- Android SDK Command-line Tools 22.0 :
  `C:\Users\Eric\AppData\Local\Android\Sdk\cmdline-tools\latest\bin\sdkmanager.bat`.
- Android Platform Tools 37.0.0 et ADB 1.0.41, build 14910828 :
  `C:\Users\Eric\AppData\Local\Android\Sdk\platform-tools\adb.exe`.
- Android Emulator 36.6.11, build 15507667 :
  `C:\Users\Eric\AppData\Local\Android\Sdk\emulator\emulator.exe`.
- Android Platform API 36 révision 2 et Build Tools 36.0.0 sont installés.
- Image système Android 16/API 36 Google APIs x86_64 révision 7 :
  `C:\Users\Eric\AppData\Local\Android\Sdk\system-images\android-36\google_apis\x86_64`.
- NDK Android 28.2.13676358 et CMake 3.22.1 sont installés sous le SDK Android.
- Appareil virtuel validé : `Smartphone_Pixel_7_API_36`, profil Pixel 7,
  Android 16/API 36, Google APIs x86_64 :
  `C:\Users\Eric\.android\avd\Smartphone_Pixel_7_API_36.avd`.
  L'accélération WHPX 10.0.26200 et le rendu matériel sur NVIDIA GeForce RTX
  2060 sont opérationnels.
- Gradle 9.1.0 est utilisé via le wrapper du prototype Flutter ; ne pas installer
  Gradle globalement.
- Le trafic HTTPS est inspecté par Norton. Pour Gradle, le certificat public
  `Norton Web/Mail Shield Root`, déjà approuvé par Windows, a été ajouté à une
  copie dédiée du magasin JBR :
  `C:\Users\Eric\.gradle\truststores\jbr-plus-windows-cacerts.p12`.
  La variable utilisateur `GRADLE_OPTS` référence ce magasin sans désactiver la
  vérification TLS.
- Le chemin racine contient le caractère `$`, que `flutter test` 3.44.8 n'échappe
  pas correctement dans son fichier Dart temporaire. La substitution de lecteur
  vérifiée pour les commandes Flutter est
  `subst S: 'D:\$rapatries\Documents\Codex'`, puis exécution du projet Smartphone
  depuis `S:\Smartphone\...`. Les apostrophes empêchent PowerShell d'interpréter
  `$rapatries` comme une variable. Cette association commune peut également
  servir aux autres projets placés sous `D:\$rapatries\Documents\Codex` et doit
  être recréée après un redémarrage de Windows.
- Node.js 24.18.0 : `C:\Program Files\nodejs\node.exe`.
- npm 11.16.0 : `C:\Program Files\nodejs\npm.cmd`.
- .NET SDK 10.0.302 : `C:\Program Files\dotnet\dotnet.exe`.
- Visual Studio Community 2026 18.8.0 :
  `C:\Program Files\Microsoft Visual Studio\2026\Community\Common7\IDE\devenv.exe`.
  Validation par
  `C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe`.
- Visual Studio Code 1.128.1 :
  `C:\Users\Eric\AppData\Local\Programs\Microsoft VS Code\Code.exe`.
- Extensions VS Code Flutter 3.138.0 (`dart-code.flutter`) et Dart 3.138.0
  (`dart-code.dart-code`) installées et validées.
- Aucun workload .NET mobile n'est installé selon `dotnet workload list`.
- Le `PATH` utilisateur contient désormais Flutter, `platform-tools` et
  `cmdline-tools\latest\bin`. Une application déjà ouverte avant la modification
  doit être redémarrée pour voir ce nouveau `PATH`.
- Non installés ou non validés à ce stade : Gradle global, Kotlin global, pnpm,
  Yarn, Bun, Expo CLI, EAS CLI et React Native CLI.
- Xcode n'est pas disponible sur Windows.

### Outils généraux et documentaires utiles

- Git 2.43.0.windows.1 : `C:\Program Files\Git\cmd\git.exe` ; Git Credential
  Manager est configuré par le helper système `manager`.
- Windows PowerShell 5.1 :
  `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`.
- PowerShell 7.6.4 :
  `C:\Program Files\WindowsApps\Microsoft.PowerShell_7.6.4.0_x64__8wekyb3d8bbwe\pwsh.exe`.
- Python 3.12 :
  `C:\Users\Eric\AppData\Local\Programs\Python\Python312\python.exe`.
- pip :
  `C:\Users\Eric\AppData\Local\Programs\Python\Python312\Scripts\pip.exe`.
- uv 0.11.28 :
  `C:\Users\Eric\AppData\Local\Microsoft\WinGet\Packages\astral-sh.uv_Microsoft.Winget.Source_8wekyb3d8bbwe\uv.exe`.
- Pandoc 3.10 :
  `C:\Users\Eric\AppData\Local\Microsoft\WinGet\Packages\JohnMacFarlane.Pandoc_Microsoft.Winget.Source_8wekyb3d8bbwe\pandoc-3.10\pandoc.exe`.
- Typst 0.15.0 :
  `C:\Users\Eric\AppData\Local\Microsoft\WinGet\Packages\Typst.Typst_Microsoft.Winget.Source_8wekyb3d8bbwe\typst-x86_64-pc-windows-msvc\typst.exe`.
- Graphviz 12.2.1 : `C:\Program Files\Graphviz\bin\dot.exe`.
- ImageMagick 7.1.2-27 Q16-HDRI :
  `C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe`.
- Inkscape 1.4.2 : `C:\Program Files\Inkscape\bin\inkscape.exe`.
- FFmpeg 6.0 :
  `C:\Program Files\ffmpeg-6.0-essentials_build\bin\ffmpeg.exe`.
- Poppler 26.05.0 :
  `C:\Users\Eric\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\poppler\Library\bin\pdftoppm.exe`
  et
  `C:\Users\Eric\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\poppler\Library\bin\pdfinfo.exe`.
- Microsoft Word 16.0 :
  `C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE`.
- LibreOffice 26.2.4.2, automatisation :
  `C:\Program Files\LibreOffice\program\soffice.com`.
- 7-Zip 23.01 : `C:\Program Files\7-Zip\7z.exe`.

Les versions générales ci-dessus proviennent de la source transversale contrôlée
le 13 juillet 2026 ; leurs chemins ont été revérifiés le 25 juillet 2026. Une
divergence a été constatée : PowerShell 7.6.3 a été remplacé par 7.6.4. La source
transversale reste en lecture seule pour ce projet ; signaler cette mise à jour à
Eric au lieu de la modifier.

## Utilisation d'intégrations et d'outils externes

- Un serveur applicatif partagé, une session graphique pilotée ou un MCP local ne
  doit être lancé, connecté ou utilisé qu'à la demande explicite d'Eric ou après
  son accord pour la tâche courante.
- Une instance déjà ouverte n'autorise pas sa réutilisation. Vérifier son
  propriétaire et éviter toute concurrence entre projets.
- Ne fermer que les processus lancés ou explicitement confiés à la tâche.
- Épingler les intégrations communautaires, auditer les fonctions sensibles et
  limiter les ponts locaux à `127.0.0.1`.
- Ne pas ajouter de clé API, de télémétrie ou de service externe facultatif sans
  accord.
- Après installation ou mise à jour d'un outil, vérifier le binaire réel et sa
  version, exécuter un test de bout en bout, puis actualiser cet inventaire et le
  journal des changements.

## Critères de fin d'une tâche

- Le résultat demandé existe dans le projet et respecte la portée autorisée.
- Les changements et fichiers temporaires ont été inspectés.
- Les validations réellement possibles ont été exécutées et rapportées sans
  exagération.
- Le journal des changements et, si nécessaire, l'inventaire et la documentation
  utilisateur sont à jour.
- Le statut Git est compris ; seuls les fichiers pertinents sont préparés.
- Toute limite, dépendance absente, action externe non effectuée ou décision
  restant à prendre est indiquée clairement à Eric.
