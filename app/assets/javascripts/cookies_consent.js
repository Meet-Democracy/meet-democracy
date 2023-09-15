(function() {
  "use strict";
  App.CookiesConsent = {
    initialize: function() {
      $(document).on("cookies-eu-acknowledged", function() {
        var current_user_id = $("html").data("current-user-id");
        if (current_user_id) {
          $.ajax({
            url: "/users/" + current_user_id + "/cookies_consent",
            type: "GET"
          });
        }
      });
    }
  };
}).call(this);
