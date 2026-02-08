***Étape 1 : L'État Stable (La Paix)***



***Ta table contient les données de 11h00.***



***Sur S3 : Tu as un fichier data\_1100.parquet.***



***Dans le JSON (v1.json) : Il est écrit files: \["data\_1100.parquet"].***



***Résultat du SELECT : Tout va bien, on voit les données de 11h.***



***Étape 2 : Le Duel des Jobs (Le Chaos)***



***Deux jobs se lancent en même temps (ou se chevauchent).***



***Le Job "Lent" (Batch de 12h00) :***



***Il écrit data\_1200.parquet sur S3.***



***Il prend du temps à cause du réseau...***



***Le Job "Rapide" (Batch de 13h00) :***



***Il écrit data\_1300.parquet sur S3.***



***Il finit avant le job de 12h.***



***Il met à jour le catalogue et crée le v2.json.***



***Contenu du v2.json : files: \["data\_1100.parquet", "data\_1300.parquet"].***



***Étape 3 : Le Conflit Silencieux (Le Crime)***



***Le Job de 12h00 essaie enfin de valider son travail.***



***Il voit que le v2.json existe déjà.***



***Le système (Iceberg/Delta) lui dit : "Erreur de conflit ! Quelqu'un a écrit avant toi !".***



***L'échec technique : Le Job de 12h s'arrête. Il ne met jamais à jour le JSON.***



***L'orchestrateur (naïf) : Il voit une erreur, il fait un "Retry" ou il passe au suivant.***



***Étape 4 : Le "Trou" est créé***



***Si tu fais un SELECT maintenant, que se passe-t-il ?***



***Le moteur SQL lit le v2.json.***



***Il voit les données de 11h et de 13h.***



***Le trou : Les données de 12h sont physiquement sur S3 (le fichier data\_1200.parquet est bien là), mais elles sont invisibles pour le monde entier.***



***Étape 5 : L'intervention de la "Sentinelle" (Ton Projet)***



***C'est ici que ton code de Batch Tracker entre en scène. Il ne fait pas de SQL, il fait de l'inspection de fichiers.***



***Le script de ton projet fait ceci :***



***Scan Physique (S3) :***

***files\_on\_disk = \["data\_1100.parquet", "data\_1200.parquet", "data\_1300.parquet"]***



***Scan Logique (JSON) :***

***files\_in\_catalog = \["data\_1100.parquet", "data\_1300.parquet"]***



***La Comparaison "Nasty" :***



***code***

***Python***

***download***

***content\_copy***

***expand\_less***

***ghost\_files = set(files\_on\_disk) - set(files\_in\_catalog)***

***# Résultat : \["data\_1200.parquet"]***



***Le verdict de ton outil :***



***🚨 ALERTE : J'ai trouvé un fichier orphelin (data\_1200.parquet). Ce fichier contient des données qui devraient être dans la table mais qui n'y sont pas. Votre pipeline a "sauté" le batch de 12h00 à cause d'un conflit de métadonnées.***



## 

