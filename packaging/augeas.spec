Name:           augeas
Version:        1.3.0
Release:        0
Summary:        A library for changing configuration files
License:        GPL-3.0+ or LGPL-2.1+
Group:          System/Libraries
Url:            http://augeas.net/
Source0:        http://augeas.net/download/augeas-%{version}.tar.gz
Source1:        baselibs.conf
Source1001: 	augeas.manifest
BuildRequires:  glib2-devel
BuildRequires:  libxml2-devel
BuildRequires:  readline-devel

%description
A library for programmatically editing configuration files. Augeas
parses configuration files into a tree structure, which it exposes
through its public API. Changes made through the API are written back
to the initially read files.

The transformation works very hard to preserve comments and formatting
details. It is controlled by ``lens'' definitions that describe the
file format and the transformation into a tree.

%define __shrlibname lib%{name}

%package        devel
Summary:        A library for changing configuration files
Group:          System/Development
Requires:       %{__shrlibname} = %{version}

%description    devel
A library for programmatically editing configuration files. Augeas
parses configuration files into a tree structure, which it exposes
through its public API. Changes made through the API are written back
to the initially read files.

The transformation works very hard to preserve comments and formatting
details. It is controlled by ``lens'' definitions that describe the
file format and the transformation into a tree.

%package        -n %{__shrlibname}
Summary:        A library for changing configuration files
Group:          System/Libraries
Recommends:     %{name}-lenses = %{version}

%description    -n %{__shrlibname}
A library for programmatically editing configuration files. Augeas
parses configuration files into a tree structure, which it exposes
through its public API. Changes made through the API are written back
to the initially read files.

The transformation works very hard to preserve comments and formatting
details. It is controlled by ``lens'' definitions that describe the
file format and the transformation into a tree.

%package        lenses
Summary:        Official set of lenses for use by %{__shrlibname}
Group:          System/Libraries
Requires:       %{__shrlibname} = %{version}

%description    lenses
Augeas parses configuration files described in lenses into a tree
structure, which it exposes through its public API. Lenses are the
building blocks of the file <-> tree transformation. The transformation
is controlled by ``lens'' definitions that describe the file format and
mapping of its contents into a tree. This package includes the official
set of lenses.

%package        lense-tests
Summary:        Set of tests for official Augeas lenses
Group:          System/Testing
Requires:       %{name}-lenses = %{version}

%description    lense-tests
Set of tests for official Augeas lenses. These can be used when
modifying the official lenses, or when creating new ones.

%prep
%setup -q
cp %{SOURCE1001} .

%build
export CFLAGS="-Wno-error $RPM_OPT_FLAGS"
%configure --disable-static
make %{?_smp_mflags}

%install
%make_install
# move vim files to the right location
mv $RPM_BUILD_ROOT/%{_datadir}/vim/vimfiles $RPM_BUILD_ROOT/%{_datadir}/vim/site

%post -n %{__shrlibname} -p /sbin/ldconfig

%postun -n %{__shrlibname} -p /sbin/ldconfig


%docs_package
%files
%manifest %{name}.manifest
%defattr(-,root,root,-)
%{_bindir}/augtool
%{_bindir}/augparse
%{_bindir}/fadot
%license COPYING

%files -n %{__shrlibname}
%manifest %{name}.manifest
%defattr(-,root,root,-)
%{_libdir}/*.so.*

%files devel
%manifest %{name}.manifest
%defattr(-,root,root,-)
%{_includedir}/*
%{_libdir}/*.so
%{_libdir}/pkgconfig/augeas.pc
# vim support files
%dir %{_datadir}/vim
%dir %{_datadir}/vim/site
%dir %{_datadir}/vim/site/ftdetect
%{_datadir}/vim/site/ftdetect/augeas.vim
%dir %{_datadir}/vim/site/syntax
%{_datadir}/vim/site/syntax/augeas.vim

%files lenses
%manifest %{name}.manifest
%defattr(-,root,root,-)
%dir %{_datadir}/%{name}
%dir %{_datadir}/%{name}/lenses
%dir %{_datadir}/%{name}/lenses/dist
%{_datadir}/%{name}/lenses/dist/*.aug

%files lense-tests
%manifest %{name}.manifest
%defattr(-,root,root,-)
%dir %{_datadir}/%{name}/lenses/dist/tests
%{_datadir}/%{name}/lenses/dist/tests/*.aug

%changelog
