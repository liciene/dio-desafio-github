#!/bin/bash

echo "Creating directories..."

mkdir /public
mkdir /adm
mkdir /ven
mkdir /sec

echo "Creating user groups..."

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Creating users..."

useradd salomao -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_ADM
useradd liciene -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_ADM
useradd juniara -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_ADM

useradd amanda -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_VEN
useradd victoria -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_VEN
useradd maressa -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_VEN

useradd norma -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_SEC
useradd angelica -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_SEC
useradd fabio -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G GRP_SEC

echo "Specifying directory permissions..."

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /public

echo "End..."