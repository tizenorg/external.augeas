
Name:       augeas
Summary:    A library for changing configuration files
Version:    0.8.1
Release:    1
Group:      System/Libraries
License:    LGPLv2+
URL:        http://augeas.net/
Source0:    http://augeas.net/download/%{name}-%{version}.tar.gz
BuildRequires:  readline-devel


%description
A library for programmatically editing configuration files. Augeas parses
configuration files into a tree structure, which it exposes through its
public API. Changes made through the API are written back to the initially
read files.

The transformation works very hard to preserve comments and formatting
details. It is controlled by ``lens'' definitions that describe the file
format and the transformation into a tree.



%package libs
Summary:    Libraries for %{name}
Group:      System/Libraries
Requires(post): /sbin/ldconfig
Requires(postun): /sbin/ldconfig

%description libs
The libraries for %{name}.

%package devel
Summary:    Development files for %{name}
Group:      Development/Libraries
Requires:   %{name} = %{version}-%{release}

%description devel
The %{name}-devel package contains libraries and header files for
developing applications that use %{name}.



%prep
%setup -q -n %{name}-%{version}


%build

%configure --disable-static
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
%make_install
mkdir -p %{buildroot}/usr/share/license
cp %{_builddir}/%{name}-%{version}/COPYING  %{buildroot}/usr/share/license/%{name}

find $RPM_BUILD_ROOT -name '*.la' -exec rm -f {} ';'








%post libs -p /sbin/ldconfig

%postun libs -p /sbin/ldconfig


%docs_package


%files
/usr/share/license/%{name}
%{_bindir}/augtool
%{_bindir}/augparse
%{_bindir}/fadot
%{_datadir}/vim/vimfiles/syntax/augeas.vim
%{_datadir}/vim/vimfiles/ftdetect/augeas.vim


%files libs
%{_datadir}/augeas
%{_libdir}/*.so.*

%files devel
%defattr(-,root,root,-)
%{_includedir}/*
%{_libdir}/*.so
%{_libdir}/pkgconfig/augeas.pc

