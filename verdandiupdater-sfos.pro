# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = verdandiupdater-sfos

CONFIG += sailfishapp

SOURCES += src/verdandiupdater-sfos.cpp \
    src/core.cpp \
    src/checker.cpp

DISTFILES += qml/verdandiupdater-sfos.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/verdandiupdater-sfos.changes.in \
    rpm/verdandiupdater-sfos.changes.run.in \
    rpm/verdandiupdater-sfos.spec \
    rpm/verdandiupdater-sfos.yaml \
    translations/*.ts \
    verdandiupdater-sfos.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

RESOURCES += qml/resources/resources.qrc

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
#TRANSLATIONS += translations/verdandiupdater-sfos-de.ts

HEADERS += \
    src/core.h \
    src/checker.h
