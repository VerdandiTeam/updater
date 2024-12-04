TARGET = verdandiupdater-sfos

CONFIG += sailfishapp

SOURCES += src/verdandiupdater-sfos.cpp \
    src/core.cpp

DISTFILES += qml/verdandiupdater-sfos.qml \
    qml/cover/CoverPage.qml \
    qml/pages/Main.qml \
    rpm/verdandiupdater-sfos.spec \
    translations/*.ts

RESOURCES += qml/resources/resources.qrc

CONFIG += sailfishapp_i18n

TRANSLATIONS += \
    translations/verdandiupdater-sfos.ts

HEADERS += \
    src/core.h

dbus.files = com.verdanditeam.updater.service
dbus.path = /usr/share/dbus-1/services/

INSTALLS += dbus
