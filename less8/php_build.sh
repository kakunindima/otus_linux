#!/bin/bash
#Otus-linux hometask
#BUILD RPM php5 script
#packages for build
    sudo yum install -y rpmdevtools && sudo yum install -y yum-utils && sudo yum install -y epel-release
#make folders tree
    sudo rpmdev-setuptree
#get php5 sources
    cd rpmbuild
    sudo yumdownloader -y --enablerepo=epel-source --source php
#unpack 
    rpm -ivh php-5.*
#builddep
    sudo yum-builddep -y php-5.4.16-46.1.el7_7.src.rpm
#build from spec
    cd SPEC/ && sudo rpmbuild -ba php.spec