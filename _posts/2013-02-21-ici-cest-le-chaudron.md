---
layout: post
title: "Ici c'est le chaudron"
description: "Petite blague en famille!"
category: French
tags: [Security,French]
---
{% include JB/setup %}
Les frères de Delph', originaires de Lyon, sont de grands fans de l'OL. Bien naturellement, elle a choisi de se déclarer supportrice de Saint-Étienne (parce que ...) et s'est engagée dans une guerre de longue date, qui atteint son apogée chaque année au moment de Noël. Il y a quelques années, elle leur a offert des drapeaux de Saint-Étienne. En représaille, ils l'ont fait couché des draps OL. L'année suivante, elle a donc décoré leurs chambre tout en vert. Et pour prendre leur revanche, ils lui ont acheté une action de l'OL. Cette dernière prouesse a eu le mérite de calmer les hostilités pour quelques années.

Cette année, elle m'a demandé de l'aide pour enfin trouver une réponse. Inspiré par [cette page]("http://www.ex-parrot.com/pete/upside-down-ternet.html"), et parce que j'avais un vieux [Fonera]("http://www.fon.com") avec dd-wrt qui prenait la poussière, nous nous sommes mis a chercher une idée. L'idée de base était évidemment de pervertir leur connexion à internet. Tout ce que nous avions besoin de faire était de brancher notre routeur à leur modem ADSL (une livebox), couper le réseau wifi de cette dernière (heureusement, personne ne change les mots de passe admin par défaut) et créer un autre réseau avec le même nom et la même clé. Une fois le changement effectué, tout le traffic internet non-chiffré passe entre nos mains, et ils n'y voient que du feu.

La question était alors de savoir ce que nous en ferions après. L'idée de départ était seulement d'utiliser le petit routeur. Mais un serveur proxy était bien trop lourd pour une si petite machine. Et quand bien même elle aurait été capable de le faire tourner, je n'avais pas envie de commencer à mettre en place toute une chaîne de compilation, et je n'ai trouvé aucune image précompilée. Du coup je me suis orienté vers l'idée d'un serveur DNS qui redirigerait toute requête vers le site de l'AS Saint-Étienne, mais c'était un peu trop basique.

On a donc fini par ajouter un maillon à la chaîne. Toutes les requêtes allaient être dirigées vers mon petit serveur domestique (un mac mini G4 de récup' qui tourne sous Linux et est particulièrement silencieux) qui lui est parfaitement capable de tourner n'importe quel service web, dont Squid. Le reste était facile à faire, avec un peu de code puisé [ici]("https://www.funkypenguin.co.nz/tutorial/april-fools-pranks-with-a-squid-proxy-server/").

Après un petit quart d'heure passé à fignoler les branchements sur place la veille de l'opération, voici ce que nos victimes ont découvert en allant sur le site du Monde:
![Le site du monde vandalisé]({{ BASE_PATH }}/assets/images/chaudron/lemonde.png){: .img-responsive }

Ou sur celui du Figaro:
![Le figaro selon proxy]({{BASE_PATH }}/assets/images/chaudron/lefigaro.png){: .img-responsive }

Le plus drôle était que nous n'avons pas été immédiatement soupçonnés! La réaction immédiate des victimes a été de déclarer qu'un virus avait pénétré le téléphone de la première victime, qui s'est mis à chercher sur google comment se débarasser d'un «fils de **** de Stéphanois qui a hacké mon iphone». Mais en découvrant le même phénomène sur tous les autres appareils connectés en wifi, et voyant les deux coupables morts de rire, le pot aux roses fut rapidement découvert.

En tout cas, c'était aussi une bonne façon de rappeller qu'à moins d'utiliser un protocole sécurisé, (le [https](https://en.wikipedia.org/wiki/HTTP_Secure) toutes vos communications sur internet sont visibles par tout le monde (votre FAI, le gouvernement, les autres gouvernements, les constructeurs des équipements réseau, ou le voisin qui a deviné votre clé wifi). Utiliser des extensions comme [https-everywhere](https://www.eff.org/https-everywhere) vous protégera un peu en forçant le https sur les sites qui le permettent. Dans le cas contraire, comme c'était le cas jusqu'à très récemment sur l'AppStore d'Apple, bonne chance!
