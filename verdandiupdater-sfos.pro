TARGET = verdandiupdater-sfos

CONFIG += sailfishapp

SOURCES += src/verdandiupdater-sfos.cpp \
    src/core.cpp

DISTFILES += qml/verdandiupdater-sfos.qml \
    qml/cover/CoverPage.qml \
    qml/pages/Main.qml \
    qml/pages/Update.qml \
    rpm/verdandiupdater-sfos.spec \
    translations/*.ts \
    verdandiupdater-sfos.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

RESOURCES += qml/resources/resources.qrc

CONFIG += sailfishapp_i18n

HEADERS += \
    src/core.h
