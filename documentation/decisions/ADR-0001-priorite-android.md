# ADR-0001 — Priorité Android pour les premiers essais

- Statut : accepté
- Date : 25 juillet 2026

## Contexte

Eric dispose actuellement d'un smartphone Android. Le projet doit pouvoir
envisager une version iPhone ou d'autres plateformes, mais aucun appareil ni
environnement de test iOS n'est disponible localement.

Des services macOS distants peuvent compiler une application iOS depuis le dépôt
GitHub. Cela ne remplace toutefois pas complètement les essais interactifs sur un
simulateur ou un appareil Apple.

## Décision

- Commencer par des prototypes et essais sous Android.
- Installer et tester les versions de développement sur le smartphone physique
  d'Eric dès que la chaîne Android sera opérationnelle.
- Continuer à évaluer la portabilité vers iPhone lors du choix du framework, sans
  configurer immédiatement une chaîne de build ou de publication iOS.
- Conserver GitHub Actions sur runner macOS comme première option future pour
  compiler iOS, le dépôt étant public.
- Conserver Codemagic comme solution spécialisée de repli si la configuration,
  la signature ou la publication Flutter deviennent plus simples par ce service.
- Reporter la création du compte de distribution, des certificats et des secrets
  Apple jusqu'à ce qu'une version iOS soit réellement envisagée.

## Conséquences

- La prochaine installation d'outils concernera uniquement Android et le
  framework qui sera retenu.
- Les validations initiales porteront sur Android, en émulateur si utile et sur
  le téléphone physique.
- Une fonctionnalité ne sera pas déclarée compatible iOS sans compilation et
  tests réels sur cette plateforme.
- La stratégie iOS sera réévaluée après un prototype Android fonctionnel ou plus
  tôt si Eric le demande.

## Références

- [Livraison continue avec Flutter](https://docs.flutter.dev/deployment/cd)
- [Facturation de GitHub Actions](https://docs.github.com/en/billing/concepts/product-billing/github-actions)
- [Tarifs Codemagic](https://docs.codemagic.io/billing/pricing/)
- [Adhésion Apple Developer](https://developer.apple.com/support/compare-memberships/)
