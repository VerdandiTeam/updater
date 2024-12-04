TEMPLATE = aux

entries.path = /usr/share/jolla-settings/entries
entries.files = verdandiupdater-settings.json

pages.path = /usr/share/jolla-settings/pages/verdandiupdater
pages.files = mainpage.qml

translations.path = /usr/share/translations
translations.files = i18n/*.qm

system(lrelease -idbased $$PWD/i18n/*.ts)

OTHER_FILES += \
    verdandiupdater-settings.json \
    mainpage.qml \
    i18n/*.ts

TRANSLATIONS += i18n/*.ts

INSTALLS = entries pages translations
