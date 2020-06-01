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
    src/apihelper.cpp \
    src/core.cpp \
    src/checker.cpp \
    vendor/curlpp/src/curlpp/cURLpp.cpp \
    vendor/curlpp/src/curlpp/Easy.cpp \
    vendor/curlpp/src/curlpp/Exception.cpp \
    vendor/curlpp/src/curlpp/Form.cpp \
    vendor/curlpp/src/curlpp/Info.cpp \
    vendor/curlpp/src/curlpp/Multi.cpp \
    vendor/curlpp/src/curlpp/OptionBase.cpp \
    vendor/curlpp/src/curlpp/Options.cpp \
    vendor/curlpp/src/curlpp/internal/CurlHandle.cpp \
    vendor/curlpp/src/curlpp/internal/OptionList.cpp \
    vendor/curlpp/src/curlpp/internal/OptionSetter.cpp \
    vendor/curlpp/src/curlpp/internal/SList.cpp

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
    src/apihelper.h \
    src/core.h \
    src/checker.h \
    vendor/curlpp/include/curlpp/cURLpp.hpp \
    vendor/curlpp/include/curlpp/Easy.hpp \
    vendor/curlpp/include/curlpp/Exception.hpp \
    vendor/curlpp/include/curlpp/Form.hpp \
    vendor/curlpp/include/curlpp/Info.hpp \
    vendor/curlpp/include/curlpp/Infos.hpp \
    vendor/curlpp/include/curlpp/Multi.hpp \
    vendor/curlpp/include/curlpp/OptionBase.hpp \
    vendor/curlpp/include/curlpp/Option.hpp \
    vendor/curlpp/include/curlpp/Options.hpp \
    vendor/curlpp/include/curlpp/Types.hpp \
    vendor/curlpp/include/curlpp/internal/CurlHandle.hpp \
    vendor/curlpp/include/curlpp/internal/OptionContainer.hpp \
    vendor/curlpp/include/curlpp/internal/OptionContainerType.hpp \
    vendor/curlpp/include/curlpp/internal/OptionList.hpp \
    vendor/curlpp/include/curlpp/internal/OptionSetter.hpp \
    vendor/curlpp/include/curlpp/internal/SList.hpp

INCLUDEPATH += vendor/curlpp/include \
    vendor/jsoncpp/include
