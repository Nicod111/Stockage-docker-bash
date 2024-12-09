## **Automatisation du script TOIP**

Ce document explique comment configurer et exécuter un script pour le traitement des fichiers TOIP dans un environnement Docker, en utilisant un volume spécifique. Le script est également automatisé via crontab pour s'exécuter quotidiennement à 23h45.

## 1. Localisation du répertoire TOIP

Le répertoire TOIP se trouve dans le volume Docker suivant :

Pour trouver ce chemin, vous pouvez utiliser la commande suivante 

 - **docker inspect <nom_du_conteneur>**
Remplacez <nom_du_conteneur> par le nom ou l'ID de votre conteneur Docker.

Dans la catégorie "Mounts" il suffira de trouver "Source" qui nous montrera le chemin d'accès.

> **Mounts": [
            {
                "Type": "volume",
                "Name": "ba998589602fba3399cb51e4d4501103740e364e96a3c2642d3c42f48ec6040a",
                "Source": "/var/lib/docker/volumes/ba998589602fba3399cb51e4d4501103740e364e96a3c2642d3c42f48ec6040a/_data"**

Ce qui nous donne le chemin suivant pour notre fichier TOIP

> **/var/lib/docker/volumes/6294b4fcb4708da7980db564c478738eee8b2a0b4b291b8f77ed81c2a54110f1/_data/data/user/files/TOIP/**

## **2. Configuration des permissions**

Afin d'assurer l'exécution correcte du script, appliquez les permissions suivantes :

> **chmod 777 /var/lib/docker/volumes/6294b4fcb4708da7980db564c478738eee8b2a0b4b291b8f77ed81c2a54110f1/_data/data/user/files/TOIP/script.sh
chmod +x /var/lib/docker/volumes/6294b4fcb4708da7980db564c478738eee8b2a0b4b291b8f77ed81c2a54110f1/_data/data/user/files/TOIP/script.sh**


chmod 777 : Donne tous les droits (lecture, écriture, exécution) à tous les utilisateurs.

chmod +x : Rend le fichier exécutable.

## **3. Exécution manuelle du script**

Pour lancer le script manuellement, exécutez la commande suivante 

> **./script.sh**

Assurez-vous d'être dans le répertoire contenant le script avant d'exécuter cette commande.

## **4. Automatisation avec Crontab**

Pour automatiser l'exécution du script tous les jours à 23h45, ajoutez la ligne suivante au fichier crontab :

> **45 23 * * * /var/lib/docker/volumes/6294b4fcb4708da7980db564c478738eee8b2a0b4b291b8f77ed81c2a54110f1/_data/data/user/files/TOIP/script.sh**

Étapes pour éditer le fichier crontab :

Ouvrez le fichier crontab avec la commande :

> **crontab -e**

Ajoutez la ligne mentionnée ci-dessus.

Sauvegardez et fermez le fichier.

Le script sera alors exécuté automatiquement chaque jour à 23h45.
