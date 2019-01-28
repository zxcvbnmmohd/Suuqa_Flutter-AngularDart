class Card {
  String cardID, customerID, sourceID, brand, cvcCheck, lastFour;
  int expMonth, expYear;

  Card transform({String key, Map map}) {
    Card c = new Card();

    c.sourceID = key;
    c.cardID = map['id'];
    c.customerID = map['customer'];
    c.brand = map['brand'];
    c.cvcCheck = map['cvc_check'];
    c.expMonth = map['exp_month'];
    c.expYear = map['exp_year'];
    c.lastFour = map['last4'];

    return c;
  }
}