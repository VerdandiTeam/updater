%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Name:       verdandiupdater-sfos
Summary:    VerdandiTeam SailfishOS updater
Version:    0.1
Release:    1
Group:      Qt/Qt
License:    LICENSE
URL:        http://verdanditeam.com/
Source0:    %{name}-%{version}.tar.bz2
Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
Short description of my Sailfish OS Application

%prep
%setup -q -n %{name}-%{version}

%build
%qtc_qmake5 

%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

%files
%defattr(4755,root,root,4755)
%{_bindir}/%{name}
%defattr(-,root,root,-)
%{_datadir}/%{name}
%{_datadir}/jolla-settings/entries/
%{_datadir}/jolla-settings/pages/verdandiupdater/
%{_datadir}/translations
%{_datadir}/dbus-1/services/com.verdanditeam.updater.service
