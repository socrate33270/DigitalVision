# Deploiement Render

Ce guide deploie l'application sur Render avec :

- un seul `Web Service`
- une seule base PostgreSQL
- aucune base secondaire
- aucun service Redis / Key Value

Le dashboard admin se synchronise automatiquement par polling Turbo. Aucune configuration Action Cable n'est necessaire.

## 1. Verifications locales

Depuis la racine du projet :

```bash
rbenv exec bundle install
rbenv exec ruby bin/rails db:migrate
rbenv exec ruby bin/rails test
```

Si tout passe, le projet est pret a etre pousse.

## 2. Creer le depot GitHub

Si le depot GitHub n'existe pas encore :

1. Va sur GitHub.
2. Cree un nouveau depot vide, par exemple `digital_vision`.
3. Ne coche ni `README`, ni `.gitignore`, ni licence.

Ensuite dans le terminal, depuis `/Users/aurelien/digital_vision` :

```bash
git status
git add .
git commit -m "Prepare project for Render deployment"
git branch -M main
git remote add origin git@github.com:TON-USER/TON-DEPOT.git
git push -u origin main
```

Si tu utilises HTTPS au lieu de SSH :

```bash
git remote add origin https://github.com/TON-USER/TON-DEPOT.git
git push -u origin main
```

## 3. Creer la base PostgreSQL sur Render

1. Connecte-toi a Render.
2. Clique sur `New +`.
3. Choisis `PostgreSQL`.
4. Choisis :
   - la meme region que ton futur service web
   - un nom explicite, par exemple `digital-vision-db`
   - un plan adapte a ton test
5. Attends que la base soit prete.

Render generera une variable `DATABASE_URL` exploitable par l'application.

## 4. Creer le Web Service sur Render

1. Clique sur `New +`.
2. Choisis `Web Service`.
3. Connecte ton compte GitHub si necessaire.
4. Selectionne le depot `digital_vision`.
5. Configure :

   - **Environment** : `Ruby`
   - **Build Command** : `./bin/render-build.sh`
   - **Start Command** : `bundle exec puma -C config/puma.rb`

6. Choisis la meme region que la base.
7. Cree le service.

## 5. Variables d'environnement Render

Dans l'onglet `Environment`, ajoute ou verifie :

```text
DATABASE_URL               # fournie par Render depuis la base PostgreSQL
RAILS_MASTER_KEY           # contenu de config/master.key, sans espaces superflus
APP_HOST                   # ex: ton-service.onrender.com
DEVISE_MAILER_SENDER       # ex: no-reply@ton-domaine.fr
ADMIN_EMAIL                # ex: admin@digitalvision.fr
ADMIN_PASSWORD             # mot de passe admin initial
RAILS_LOG_LEVEL            # optionnel, ex: info
WEB_CONCURRENCY            # optionnel, ex: 2
```

Notes :

- `RAILS_MASTER_KEY` est obligatoire.
- `ADMIN_EMAIL` et `ADMIN_PASSWORD` permettent de creer ou mettre a jour automatiquement le premier compte admin au deploy via `db:seed`.
- `APP_HOST` sert aux URLs generees en production.

## 6. Premier deploiement

Une fois les variables renseignees :

1. Lance le deploiement.
2. Render executera :
   - `bundle install`
   - `assets:precompile`
   - `assets:clean`
   - `db:migrate`
   - `db:seed`

Quand le deploy est termine :

1. Ouvre l'URL publique Render.
2. Verifie la page d'accueil.
3. Ouvre `/admin_users/sign_in`.
4. Connecte-toi avec `ADMIN_EMAIL` / `ADMIN_PASSWORD`.

## 7. Test fonctionnel en ligne

Pour verifier le flux complet :

1. Connecte-toi a l'admin.
2. Ouvre la vitrine dans un second onglet.
3. Envoie une demande depuis le formulaire de contact.
4. Reviens sur l'admin.
5. Le lead apparait automatiquement dans la colonne `En attente` apres le prochain rafraichissement du dashboard.

Le polling est configure pour recharger le tableau toutes les 5 secondes.

## 8. Points de controle apres mise en ligne

Verifie :

- la connexion admin fonctionne
- la creation d'un contact fonctionne
- le lead apparait bien dans `/admin`
- le changement de statut fonctionne
- l'app redemarre correctement apres un redeploy

## 9. Commandes utiles pour les mises a jour

Pour deployer une nouvelle version :

```bash
git add .
git commit -m "Update application"
git push
```

Render redeploiera automatiquement si l'auto-deploy GitHub est active.
