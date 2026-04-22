# Digital Vision

Site vitrine Ruby on Rails pour une agence de marketing digital spécialisée en contenu réseaux sociaux, web/mobile, automatisation IA et formations IA.

Guide de mise en ligne Render :
[DEPLOY_RENDER.md](/Users/aurelien/digital_vision/DEPLOY_RENDER.md)

## Stack

- Ruby on Rails 8.1.3
- PostgreSQL
- Tailwind CSS via `tailwindcss-rails`
- Hotwire/Turbo et Stimulus
- Devise pour l'authentification admin
- Synchronisation admin par polling Turbo, compatible Render avec une seule base PostgreSQL
- Architecture MVC avec partials ERB pour les sections UI

## Commandes de génération utilisées

```bash
gem install rails -v 8.1.3
rails _8.1.3_ new digital_vision --database=postgresql --css=tailwind
cd digital_vision
bundle install
bin/rails generate model Contact full_name:string email:string service_type:string message:text read:boolean
bin/rails generate controller Pages home
bin/rails generate controller Contacts create
rbenv exec bundle add devise
rbenv exec ruby bin/rails generate devise:install
rbenv exec ruby bin/rails generate devise AdminUser
rbenv exec ruby bin/rails generate migration AddStatusToContacts status:integer
```

Les routes générées inutiles ont ensuite été remplacées par `root "pages#home"` et `resources :contacts, only: :create`.

## Installation

```bash
cd /Users/aurelien/digital_vision
rbenv exec bundle install
rbenv exec ruby bin/rails db:create
rbenv exec ruby bin/rails db:migrate
rbenv exec ruby bin/rails tailwindcss:build
rbenv exec ruby bin/rails server
```

Créez ensuite un compte administrateur :

```bash
rbenv exec ruby bin/rails console
```

```ruby
AdminUser.create!(
  email: "admin@digitalvision.fr",
  password: "changez-ce-mot-de-passe",
  password_confirmation: "changez-ce-mot-de-passe"
)
```

En développement avec compilation Tailwind automatique :

```bash
gem install foreman
rbenv exec ruby bin/dev
```

L'application utilise PostgreSQL. Vérifiez que le service PostgreSQL est lancé avant `db:create`.

## Structure

- `app/models/contact.rb` : modèle de demande de contact, validations et scope `unread` prêt pour un futur dashboard admin.
- `app/models/admin_user.rb` : compte administrateur Devise.
- `app/models/homepage_content.rb` : contenus éditables de la page d'accueil, notamment services, solutions IA et formations.
- `app/controllers/pages_controller.rb` : prépare la home et instancie `@contact`.
- `app/controllers/contacts_controller.rb` : reçoit le formulaire, applique les Strong Parameters, répond en Turbo Stream ou HTML.
- `app/controllers/admin/base_controller.rb` : sécurise le namespace admin avec `authenticate_admin_user!`.
- `app/controllers/admin/contacts_controller.rb` : affiche les leads par statut, met à jour le Kanban et sert la synchro Turbo du dashboard.
- `app/views/layouts/application.html.erb` : layout global avec Google Fonts, Tailwind, Navbar, Flash et Footer.
- `app/views/layouts/admin.html.erb` : layout admin avec sidebar fixe.
- `app/views/layouts/_navbar.html.erb` : navigation desktop/mobile pilotée par Stimulus.
- `app/views/layouts/_footer.html.erb` : pied de page.
- `app/views/pages/home.html.erb` : assemble les sections de la page.
- `app/views/pages/partials/` : partials `_hero`, `_services`, `_ai_solutions`, `_formations`, `_contact_form`.
- `app/views/admin/contacts/index.html.erb` : Kanban des leads.
- `app/views/admin/contacts/_board.html.erb` : contenu réutilisable du tableau admin pour le rafraîchissement automatique.
- `app/views/admin/contacts/_contact.html.erb` : carte individuelle d'un lead.
- `app/javascript/controllers/contacts_sync_controller.js` : actualise automatiquement le dashboard admin sans Action Cable.
- `app/javascript/controllers/navigation_controller.js` : ouverture/fermeture du menu mobile.
- `app/javascript/controllers/status_controller.js` : soumet le changement de statut sans bouton.
- `app/assets/tailwind/application.css` : classes composant `glass`, `gradient-text`, `blob` et styles de formulaire.

## Modifier les services

Ouvrez `app/models/homepage_content.rb`, puis modifiez le tableau retourné par `services`.

Chaque service accepte :

- `title`
- `description`
- `theme` : `:indigo`, `:purple` ou `:pink`
- `icon_path` : chemin SVG utilisé dans la carte
- `featured` : optionnel, ajoute le badge "Nouveau"

Après ajout de nouvelles classes Tailwind dans les vues, relancez :

```bash
rbenv exec ruby bin/rails tailwindcss:build
```

## Ajouter une formation

Dans `app/models/homepage_content.rb`, ajoutez une entrée dans `formations` :

```ruby
{
  title: "IA pour équipes commerciales",
  duration: "1 journée",
  description: "Structurer la prospection et le suivi avec des workflows IA."
}
```

La section `app/views/pages/partials/_formations.html.erb` affichera automatiquement la nouvelle carte.

## Espace administrateur

L'admin est disponible sur :

```text
/admin
```

Les inscriptions publiques Devise sont désactivées. Les comptes admin doivent être créés en console Rails ou via une tâche interne.

Le modèle `Contact` contient :

- `status`, enum : `en_attente`, `repondu`, `valide`, `perdu`
- `read`, conservé pour une future logique lu/non lu
- un index sur `status`
- un index sur `read`

Le Kanban affiche quatre colonnes et permet de changer le statut d'un lead via le menu déroulant de chaque carte.

## Synchronisation des leads

Le formulaire public enregistre toujours la demande immédiatement dans la base principale PostgreSQL.

Pour l'administration, le projet n'utilise plus Action Cable ni Solid Cable. Le dashboard `/admin` interroge périodiquement le serveur via Turbo Stream grâce au contrôleur Stimulus `contacts_sync_controller.js`.

Ce choix permet :

- une seule base PostgreSQL
- aucun service Redis
- aucune base dédiée à Cable, Queue ou Cache
- un comportement simple et compatible avec Render à faible coût

Flux fonctionnel :

1. Le visiteur soumet le formulaire.
2. `ContactsController#create` enregistre un `Contact`.
3. Le dashboard admin recharge automatiquement son tableau toutes les 5 secondes.
4. Le nouveau lead apparaît dans la colonne `En attente`.

Pour vérifier la synchronisation en local :

1. Lancez le serveur Rails.
2. Connectez-vous à `/admin` dans un onglet.
3. Ouvrez la vitrine dans un second onglet.
4. Envoyez une demande depuis le formulaire de contact.
5. La carte apparaît automatiquement dans la colonne `En attente` après le prochain rafraîchissement du dashboard.

## Production Render

Le projet est désormais pensé pour un déploiement Render simple :

- un seul Web Service
- une seule base PostgreSQL
- aucune base secondaire
- aucun service complémentaire Redis / Key Value

Configuration attendue :

```text
DATABASE_URL
RAILS_MASTER_KEY
```

La configuration de production utilise :

- `config.cache_store = :memory_store`
- `config.active_job.queue_adapter = :async`
- une seule base PostgreSQL dans `config/database.yml`

Le tableau admin reste synchronisé grâce au polling Turbo, ce qui évite toute dépendance aux WebSockets pour ce besoin métier.

## Tests

```bash
rbenv exec ruby bin/rails test
```
