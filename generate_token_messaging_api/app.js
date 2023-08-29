var { google } = require('googleapis');
var MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
var SCOPES = [MESSAGING_SCOPE];

function getAccessToken() {
      return new Promise(function (resolve, reject) {
            var key = require("./service-account.json");
            var jwtClient = new google.auth.JWT(
                  key.client_email,
                  null,
                  key.private_key,
                  SCOPES,
                  null
            );
            jwtClient.authorize(function (err, tokens) {
                  if (err) {
                        reject(err);
                        return;
                  }
                  resolve(tokens.access_token);
            });
      });
}

getAccessToken().then(function (access_token) {
      console.log(access_token);
});