import 'package:flutter/foundation.dart';

abstract class ConstString{
  static String get ucolis => "UColis";
  static String get welcomeOnDash => "Bonjour Yanne, bienvenue sur votre platforme multiserices";
  static String get shippingTextOnDash => "Profitzez de nos livraisons express de colis";
  static String get shippingTextOnDash2 => "Effectuez vos déplacements en toute simplicité et sécurité";
  static String get colis => "Colis";
  static String get transport => "Transport";
  static String get wallet  => "Votre portefeuille";
  static String get drawBHistory  => "Historique de Courses";
  static String get drawBWallet  => "Mon portefeuille";
  static String get drawBCode  => "Code Promo";
  static String get drawBSupport  => "Support Technique";
  static String get drawBLogout  => "Se deconnecter";
  static String get changeLanguage  => "Changer de langue";
  static String get notifications  => "Notifications";
  static String get receiNotifications  => "Recevoir les notifications";
  static String get delAccount  => "Effacer mon compte";
  static String get changeAccount  => "Changer de type de compte";
  static String get deliver  => "Coursier";
  static String get paidMethod  => "Paiement";
  static String get reportProblem  => "Réporter un prolème";
  static String get deliverSince  => "Coursier depuis";
  static String get typeVehicle  => "Type de véhicule";
  static String get number  => "Numéro de matricule";
  static String get code  => "Numéro de code";

  static String get boilPromoMgs => "Messan a utilisé 2 manèges avec 30% de réduction pour les courses";
  static String get addProCode => "Ajouter un code";
  static String get send => "Envoyer";

  static String get faq => "Questions Fréquentes";
  static String get supportTicket => "Votre ticket pour le support";
  static String get contactUs => "Nous contacter";

  static String get faqUnlockAcc => "Débloquer mon compte";
  static String get faqPhoneNumber => "Changer mon numéro";
  static String get faqCGG => "Politique de confidentialité";

  static String get faqPaidM => "Moyen de paiement";
  static String get faqPrice => "Estimation de prix";
  static String get faqDeliveryPrice => "Frais d'annulation de course";
  static String get faqHurdlePrice => "Frais de panne";

  static String get gain => "Solde disponible";
  static String get cash => "Paiement par cash";
  static String get card => "Paiement par compte";
  static String get delivery => "Livraison de colis";
  static String get chooseChargeM => "Choisir le mode rechargement";
  static String get enterSum => "Veillez entrer le montant";
  static String get chargeWCard => "Recharge par carte bancaire";
  static String  chargeMM(String operator) => "Recharge $operator";


  static List<String> get mobileRechargeInstruction => [
    "<p>Générez un OTP pour le paiement en composant le code ci-dessous sur votre téléphone : <b>*144*4*6*5000#</b></p>",
  "<p>Après avoir reçu le OTP, entrez ci-dessous les informations et confirmez votre paiement.</p>"
  ];

  static List<String> get cardRechargeInstruction => [
  "<p>Entrez ci-dessous les informations et confirmez votre paiement.</p>"
  ];

  static String get confirmRecharge => "Confirmer le rechargement";


  static List<String> get mobileMoneyField => [
    "Entrez votre numéro mobile money",
    "Entrez le code otp pour confirmer",
  ];

  static List<String> get cardPaidField => [
    "Entrez votre numéro de carte (12 chiffres)",
    "Entrez le nom du propriétaire",
    "Entrez la date d’expiration",
    "Entrez le code CCV (03 chiffres)",
  ] ;

  static String get next => "Suivant";
  static String get reserve => "Reserver une livraison";
  static String get addAddress => "Ajouter une autre destination";

  static String get endTime => "Temps d'arrivé estimé";
  static String get reservePaidMode => "Moyen de paiement";


  static String get going => "En chemin";
  static String get arrived => "Arrivé";
  static String get halfWay => "En cours de route";
  static String get tip => "Pourboires";
  static String get postNotice => "Poster un avis";


  static String get deliverSearching => "Recherche d'un coursier";
  static String get notice => "Avis";
  static String get tips => "Tips";

  static String get deliverArrived => "Votre Coursier est arrivé";

  static String get tipAreWelcome => "Les pourboires sont les bienvenus, mais pas obligatoires. Le montant dépend toujours de vous.";

  static String noticeInLetter({@required int note}){
    switch(note){
      case 0:
        return "Mauvaise";
        break;   case 1:
        return "Médiocre";
        break;
      case 2:
        return "Passable";
        break;
      case 3:
        return "Bon";
        break;
      case 4:
        return "Très Bien";
        break;
      case 5:
        return "Excellent";
        break;
      default:
        return "";
        break;
    }
  }

  static String get sendTips => "Envoyer votre avis";

  static String get packageArrived => "Votre Colis est arrivé\nà destination";

  static String get account => "Mon compte";

  static String get whyCancelDelivery => "Choisir la raison pour laquelle vous annulé la course";

  static String get dontWantSpeak => "Je ne veux pas en parler";
  static String get cantCallDeliver => "Impossible de contacter le coursier";
  static String get deliverLate => "Le coursier est en retard";
  static String get highPrice => "Le prix est trop";
  static String get incorrectAddress => "Adresse n est pas correct";

  static String get moveWithCar => "Voulez-vous vous déplayer seul ou en couple ? Cette offre est adaptée";

  static String get nearFromDelivery => "Vous êtes le plus proche de la nouvelle course \nVoulez-vous la commencer ?";
  static String get details => "Details";
  static String get cancel => "Cancel";

  static List<String> get cancelReasonList => [
    dontWantSpeak,
    cantCallDeliver,
    deliverLate,
    highPrice,
    incorrectAddress,
  ];

}