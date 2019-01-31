import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as algoliaSearch from "algoliasearch";

admin.initializeApp();

const config = functions.config();
const algoliaClient = algoliaSearch(
  config.algolia.appid,
  config.algolia.apikey
);
const productsIndex = algoliaClient.initIndex("products");
const usersIndex = algoliaClient.initIndex("users");

exports.createProduct = functions.firestore
  .document("products-selling/{pID}")
  .onCreate((snap, context) => {
    const objectID = snap.id;
    const data = snap.data();
    const title = data.title;
    const _geoloc = {
      lat: data.address.geoPoint._latitude,
      lng: data.address.geoPoint._longitude
    };

    return productsIndex.addObject({
      objectID,
      title,
      _geoloc
    });
  });

exports.deleteProduct = functions.firestore
  .document("products-selling/{pID}")
  .onDelete((snap, context) => {
    const objectID = snap.id;

    return productsIndex.deleteObject(objectID);
  });

exports.createUser = functions.firestore
  .document("users/{uID}")
  .onCreate((snap, context) => {
    const objectID = snap.id;
    const data = snap.data();
    const _geoloc = { lat: 1.0, lng: 1.0 };

    return usersIndex.addObject({ objectID, data });
  });

exports.deleteUser = functions.firestore
  .document("users/{uID}")
  .onDelete((snap, context) => {
    const objectID = snap.id;

    return usersIndex.deleteObject(objectID);
  });
