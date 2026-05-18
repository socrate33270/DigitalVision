# Page Offres

La page `offres` a ete ajoutee comme page publique dediee, accessible via `/offres`.

## Architecture

- `app/controllers/offers_controller.rb`
  Gere l'action `index` et injecte le catalogue d'offres dans la vue.

- `app/models/offer_catalog.rb`
  Centralise tout le contenu de la page :
  - navigation locale
  - packs community management
  - offres sites web
  - combos
  - lignes du tableau comparatif
  - notes editoriales

- `app/models/offer_plan.rb`
  Modele Ruby non persistant pour toutes les cartes d'offres unitaires. Il gere les variantes `recurring`, `one_time` et `quote`.

- `app/models/offer_bundle.rb`
  Modele Ruby non persistant pour les offres combinees.

- `app/models/offer_comparison_row.rb`
  Modele Ruby non persistant pour les lignes du tableau comparatif.

- `app/models/offer_comparison_value.rb`
  Encapsule les valeurs de comparaison avec trois etats explicites : `yes`, `no` et `text`.

- `app/helpers/offers_helper.rb`
  Regroupe la logique de presentation reutilisable :
  - palette Tailwind par theme de carte
  - styles des cellules du tableau comparatif

- `app/views/offers/`
  La page est decoupee en partiels :
  - `_hero`
  - `_subnav`
  - `_community_management`
  - `_websites`
  - `_bundles`
  - `_comparison`
  - `_plan_card`

## Choix de conception

- Pas de migration ni de table supplementaire : les offres sont statiques et editorialisees.
- Les donnees sont sorties des vues pour garder les templates courts et lisibles.
- Une seule carte reutilisable sert pour les packs CM et les offres web.
- La page reprend le langage visuel du site :
  - fond sombre
  - surfaces `glass`
  - accents indigo, orange, rose et verts
  - typographie et espacements alignes avec la home

## Extension

Pour ajouter une nouvelle offre :

1. Ajouter l'entree dans `OfferCatalog`.
2. Choisir un `theme` compatible dans `OffersHelper`.
3. Si besoin, ajuster le rendu dans `_plan_card` uniquement si un nouveau type de pricing apparait.
