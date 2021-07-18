const data = [
  //TAB 0 = fr
  //TAB 1 = en
  //TAB 2 = dioula
  //TAB 3 = more (Vide car nous n'avons rien encore)
  //AU TOTAL 40

  //AUDIO 0 : Bienvenue sur wassa - Si vous voulez utiliser la commande vocale...
  {
    'fr': [
      'audio/fr/1.mp3', //Les deux phrases sont combinées (Bienvenue sur wassa & Si vous voulez utiliser la commande vocale...)
    ],
    'en': [
      'audio/en/51.mp3', //Welcome to wassa
      'audio/en/40.mp3', //If you want to use the command voice...
    ],
    'dioula': [
      'audio/dioula/1.mp3', //Welcome to wassa
      'audio/dioula/2.ogg', //If you want to use the command voice...
    ],
    'more': [
      '',
    ],
  },

  //Maintenant je crois que tu as compris le principe...

  //AUDIO 1 : Pour continuer en Français dites « un » ou tapez 1
  {
    'fr': [
      'audio/fr/2.mp3',
      //MORE
      'audio/dioula/3.ogg',
      'audio/en/41.mp3',
    ],
    'en': [
      'audio/fr/2.mp3',
      //MORE
      'audio/dioula/3.ogg',
      'audio/en/41.mp3', //To continue in English...
    ],
    'dioula': [
      'audio/fr/2.mp3',
      //MORE
      'audio/dioula/3.ogg',
      'audio/en/41.mp3', //To continue in Dioula
    ],
    'more': [
      'audio/fr/2.mp3',
      //MORE
      'audio/dioula/3.ogg',
      'audio/en/41.mp3',
    ],
  },

  //AUDIO 2 : Avez-vous déjà un compte? - Si « oui » appuyer sur le bouton vert pour vous connecter - Si « Non », appuyer sur le bouton Rouge pour vous inscrire
  {
    'fr': [
      'audio/fr/2re.mp3',
    ],
    'en': [
      'audio/en/42.mp3',
      'audio/en/43.mp3',
      'audio/en/44.mp3',
    ],
    'dioula': [
      'audio/dioula/4.ogg',
      'audio/dioula/5.ogg',
      'audio/dioula/6.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 3 : Veuillez importer une copie de votre carte nationale d’identité ou de votre passeport
  {
    'fr': [
      'audio/fr/3.mp3',
      'audio/fr/4.mp3',
      'audio/fr/5.mp3',
      'audio/fr/6.mp3',
      'audio/fr/7.mp3',
    ],
    'en': [
      'audio/en/45.mp3',
      'audio/en/46.mp3',
      'audio/en/47.mp3',
      'audio/en/48.mp3',
      'audio/en/49.mp3',
    ],
    'dioula': [
      'audio/dioula/7.ogg',
      'audio/dioula/8.ogg',
      'audio/dioula/9.ogg',
      'audio/dioula/10.ogg',
      'audio/dioula/11.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 4 : Vos informations ont été bien reçues. Vous recevrez un email pour validation dans  quelques instants.
  {
    'fr': [
      'audio/fr/8.mp3',
    ],
    'en': [
      'audio/en/50.mp3',
    ],
    'dioula': [
      'audio/dioula/12.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 5 : Bienvenue sur Wassa-Wassa - Pour commander une livraison de Colis, dites « un » ou tapez 1 - Pour vous déplacer en toute sécurité, dites « deux » ou tapez 2 - Pour consulter le solde de votre compte bancaire, dites « trois » ou tapez 3
  {
    'fr': [
      'audio/fr/9.mp3',
      'audio/fr/10.mp3',
      'audio/fr/11.mp3',
      'audio/fr/12.mp3',
    ],
    'en': [
      'audio/en/51.mp3',
      'audio/en/52.mp3',
      'audio/en/53.mp3',
      'audio/en/54.mp3',
    ],
    'dioula': [
      'audio/dioula/1.mp3',
      'audio/dioula/13.ogg',
      'audio/dioula/14.ogg',
      'audio/dioula/15.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 6 : Voulez-vous approvisionner  votre compte? - Si ‘Oui’ Dites « un » ou tapez 1 - Si ‘Non’, dites « deux » ou tapez 2

  {
    'fr': [
      'audio/fr/13.mp3',
    ],
    'en': [
      'audio/en/55.mp3',
    ],
    'dioula': [
      'audio/dioula/16.ogg',
      'audio/dioula/17.ogg',
      'audio/dioula/18.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 7 : Vous voulez recharger votre portefeuille - Pour Orange Money dites « un » ou tapez Pour Mobicash dites « deux » ou tapez 2 - Pour carte bancaire dites « trois » ou tapez 3
  {
    'fr': [
      'audio/fr/14.mp3',
    ],
    'en': [
      'audio/en/56.mp3',
    ],
    'dioula': [
      'audio/dioula/19.m4a',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 8 : Veuillez entrer le montant de la recharge et valider.
  {
    'fr': [
      'audio/fr/15.mp3',
    ],
    'en': [
      'audio/en/57.mp3',
    ],
    'dioula': [
      'audio/dioula/20.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 9 : Veuillez indiquer l’adresse de départ - destination
  {
    'fr': [
      'audio/fr/16.mp3',
      'audio/fr/17.mp3',
      'audio/fr/18.mp3',
    ],
    'en': [
      'audio/en/58.mp3',
      'audio/en/59.mp3',
      'audio/en/60.mp3',
    ],
    'dioula': [
      'audio/dioula/21.ogg',
      'audio/dioula/22.ogg',
      'audio/dioula/23.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 10 : Veuillez indiquer le type de colis
  {
    'fr': [
      'audio/fr/19.mp3',
    ],
    'en': [
      'audio/en/61.mp3',
      'audio/en/62.mp3',
    ],
    'dioula': [
      'audio/dioula/25.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 11 : Veuillez indiquer l’adresse de départ - destination
  {
    'fr': [
      'audio/fr/26.mp3',
      'audio/fr/27.mp3',
    ],
    'en': [
      'audio/en/69.mp3',
      'audio/en/70.mp3',
    ],
    'dioula': [
      'audio/dioula/32.ogg',
      'audio/dioula/33.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 12 : Veuillez indiquer le type de véhicule
  {
    'fr': [
      'audio/fr/28.mp3',
    ],
    'en': [
      'audio/en/71.mp3',
    ],
    'dioula': [
      'audio/dioula/34.ogg',
    ],
    'more': [
      '',
    ],
  },

//LAST AUDIO
  //AUDIO 13 : Vérifiez une dernière fois vos informations puis valider
  {
    'fr': [
      'audio/fr/20.mp3',
    ],
    'en': [
      'audio/en/63.mp3',
    ],
    'dioula': [
      'audio/dioula/26.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 16 : Recherche du coursier le plus proche
  {
    'fr': [
      'audio/fr/21.mp3',
    ],
    'en': [
      'audio/en/64.mp3',
    ],
    'dioula': [
      'audio/dioula/27.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 17 : Désolé, Il n’y a aucun coursier de disponible pour l’instant
  {
    'fr': [
      'audio/fr/22.mp3',
    ],
    'en': [
      'audio/en/65.mp3',
    ],
    'dioula': [
      'audio/dioula/28.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 18 : Votre coursier est en chemin
  {
    'fr': [
      'audio/fr/23.mp3',
    ],
    'en': [
      'audio/en/66.mp3',
    ],
    'dioula': [
      'audio/dioula/29.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 19 : Votre coursier est arrivé
  {
    'fr': [
      'audio/fr/24.mp3',
    ],
    'en': [
      'audio/en/67.mp3',
    ],
    'dioula': [
      'audio/dioula/30.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 20 : Votre colis est arrivé à destination
  {
    'fr': [
      'audio/fr/25.mp3',
    ],
    'en': [
      'audio/en/68.mp3',
    ],
    'dioula': [
      'audio/dioula/31.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 21 : Recherche du chauffeur le plus proche
  {
    'fr': [
      'audio/fr/30.mp3',
    ],
    'en': [
      'audio/en/73.mp3',
    ],
    'dioula': [
      'audio/dioula/36.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 22 : Désolé, Il n’y a aucun chauffeur de disponible pour l’instant
  {
    'fr': [
      'audio/fr/31.mp3',
    ],
    'en': [
      'audio/en/74.mp3',
    ],
    'dioula': [
      'audio/dioula/37.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 23 : Votre chauffeur est en chemin
  {
    'fr': [
      'audio/fr/32.mp3',
    ],
    'en': [
      'audio/en/75.mp3',
    ],
    'dioula': [
      'audio/dioula/38.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 24 : Votre chauffeur est arrivé
  {
    'fr': [
      'audio/fr/33.mp3',
    ],
    'en': [
      'audio/en/76.mp3',
    ],
    'dioula': [
      'audio/dioula/39.ogg',
    ],
    'more': [
      '',
    ],
  },

  //AUDIO 25 : Vous êtes arrivé à destination
  {
    'fr': [
      'audio/fr/34.mp3',
    ],
    'en': [
      'audio/en/77.mp3',
    ],
    'dioula': [
      'audio/dioula/40.ogg',
    ],
    'more': [
      '',
    ],
  },
];
