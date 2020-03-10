Name:	Redis
Version: 5.0.7
Release: 5
Summary: RedisDB
Group: DB
License: OPEN
BuildRequires: gcc

%description
Redis db

%prep
%setup -c -T
wget http://download.redis.io/releases/redis-5.0.7.tar.gz |
gunzip redis-5.* | tar -xvf redis-5.* - --strip 1

%build
./configure && make

%install
make install

%clean
rm -rf $RM_BUILD_ROOT

%files
/usr/local/etc/redis