firefox --CreateProfile desktop

(
    cd /home/$USERNAME/.mozilla/firefox/*desktop

    mkdir chrome
    echo "#nav-bar, #identity-box, #tabbrowser-tabs, #TabsToolbar {
        visibility: collapse !important;
    }" > chrome/userChrome.css
    echo "
        user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);
        user_pref(\"security.sandbox.warn_unprivileged_namespaces\", false);
    " >> prefs.js
)

firefox -p desktop localhost:48723
