echo "Building whatsapp dependencies..."
git clone https://github.com/allegro/php-protobuf.git
cd ./php-protobuf && phpize &&  ./configure --prefix=/usr/lib/php5/20131226 && make && make install
echo "extension=protobuf.so" > /etc/php5/mods-available/protobuf.ini
ln -s /etc/php5/mods-available/protobuf.ini /etc/php5/cli/conf.d/20-protobuf.ini
git clone https://github.com/mgp25/curve25519-php.git
cd ./curve25519-php && phpize &&  ./configure --prefix=/usr/lib/php5/20131226 && make && make install
echo "extension=curve25519.so" > /etc/php5/mods-available/curve25519.ini
ln -s /etc/php5/mods-available/curve25519.ini /etc/php5/cli/conf.d/20-curve25519.ini
pecl install crypto-0.2.2
echo "extension=crypto.so" > /etc/php5/mods-available/crypto.ini
ln -s /etc/php5/mods-available/crypto.ini /etc/php5/cli/conf.d/20-crypto.ini