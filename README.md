# Recipe Front-end

## Mise en place de l'environnement de développement

> * Cloner le repository GitHub suivant : https://github.com/Nicolas-Chambon/mspr_recipe_front

Pour l'environnement local, utiliser le fichier `docker-compose.yml` :

```yml
version: '3'
services:
  client:
    container_name: mspr-recipe-frontend
    build:
      context: .
      dockerfile: dockerfiles/local/Dockerfile
    volumes:
      - ./:/usr/app
      - /usr/app/node_modules
    ports:
      - 4200:4200
```

> Ce fichier **docker-compose** permet de :
>
> * Pour le service `backend`
>   * Construire un conteneur appelé `mspr-recipe-frontend` à partir du **Dockerfile** présent à la racine du projet`
>   * Utiliser la racine du répertoire local comme **volumes** et le lier au source du container
>   * Rediriger le port **4200** du container vers le **4200** de la machine parent



* Pour construire le container et le déployer en local

```bash
docker-compose up --build -d
```

* L'Application est disponible à l'URL suivant : 

```html
http://localhost:4200
```

> **NB :** Les sources local sont liées à celle présente dans le container, du coup pas besoin de build de nouveau à chaque changement dans le code.

## Githooks avec Husky

> Un hook est un script qui s’exécute automatiquement lorsqu’un événement particulier se produit dans un dépôt git. Les scripts se trouves dans le fichier `package.json`

- #### pre-commit (Ce hook se déclenche en premier avant même de saisir le message du commit)

  ```sh
    npm run format && npm run lint
  ```

  > Formate le code à l'aide de prettier puis lance un linter sur le code afin de vérifier toute erreur potentiel avant de valider le commit

- #### pre-push (Ce hook se déclenche avant l’exécution de la commande git push)

  ```sh
     npm run test && npm run build
  ```

  > Lance les tests utitaires puis une compilation du projet et vérifie que les deux réussissent avec d'autoriser le push

- #### Contourner les hooks

  Si besoin il est possible de contourner l’utilisation des hooks via l’option `--no-verify`

  **NB : Cette option n'est à utiliser que lorsque cela est nécessaire.**


## Projet

### Dépendances

| Dépendance | Version | Commentaire                                                  |
| :--------- | ------: | ------------------------------------------------------------ |
| Angular    |      11 | Framework typescript                                         |
| rxjs       |   6.6.0 | librairie permettant de faciliter la gestion des évènements asynchrones |
| tslib      |   2.0.0 | Il s'agit d'une bibliothèque d'exécution pour TypeScript qui contient toutes les fonctions d'assistance TypeScript. |
| jest       |  26.6.3 | Framework de test javascript                                 |
| prettier   |   2.2.1 | Permet de formaté le code d'un projet selon des règles spécifiques |
| tslint     |   6.1.0 | TSLint est un outil d'analyse statique extensible qui vérifie le code TypeScript pour la lisibilité, la maintenabilité et les erreurs de fonctionnalité |
| husky      |   4.3.8 | Husky est une librairie permettant de faciliter la création et le partage des hooks au sein d’un projet |
| typescript |   4.0.2 | TypeScript est un langage de programmation libre et open source développé par Microsoft |

### Commande utiles

- Commande pour lancer l'application en local sur la machine hôte

```sh
npm run start
```

- Commande pour lancer l'application dans le conteneur docker de developement afin que la redirection du container vers l'hôte fontionne

```sh
npm run start:dev
```

- Commande pour compiler les sources du projet pour l'environement de dev

```sh
npm run build
```

- Commande pour compiler les sources du projet pour la production

```sh
npm run build:prod
```

### Tests Unitaires

- Commande pour lancer les tests unitaires en local

```sh
npm run test
```

- Commande permettant d'executer les tests unitaires dans la pipeline d'intégration continue et de générer un rapport de test au format `juint` ainsi qu'un rapport de coverage au format `jacoco`, qui vont ensuite être interprêtés par l'outil d'analyse de qualité du code.

```sh
npm run test:ci
```

- Commande permettant de relancer automatique, pendant le developement, les tests sur un fichier qui vient d'être modifié

```sh
npm run test:watch
```

- Commande permettant de lancer des tests end to end avec [Protractor](https://www.protractortest.org/#/)

```sh
npm run e2e
```

### Outils de qualité du code

- Commande pour formatter le code en utilisant le module Prettier et la configuration dans le fivhier `.prettierrc` 

```sh
npm run format
```

- Commande permettant de valider que toutes les régles de formattage de code et bonnes pratiques définies dans le fichier `tslint.json` soient bien respectée et d'afficher les potentiels erreurs.

```sh
npm run lint
```

- Commande pour lancer l'analyse de qualité du code en local, la configuration se trouve dans le fichier `sonar-projet.properties`

```sh
npm run sonar
```
