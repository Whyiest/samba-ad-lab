#!/bin/bash

set -e

VAGRANT_VERSION="2.3.7"
VAGRANT_DEB="vagrant_${VAGRANT_VERSION}-1_amd64.deb"

echo "🔧 [1/6] Mise à jour des paquets..."
sudo apt update && sudo apt upgrade -y

echo "📦 [2/6] Installation des dépendances système..."
sudo apt install -y virtualbox ansible make ruby ruby-dev build-essential wget curl

echo "🧹 [3/6] Suppression de la version APT de Vagrant si installée..."
sudo apt remove -y vagrant || true

echo "⬇️ [4/6] Téléchargement et installation de Vagrant $VAGRANT_VERSION depuis HashiCorp..."
wget https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/${VAGRANT_DEB} -O /tmp/${VAGRANT_DEB}
sudo dpkg -i /tmp/${VAGRANT_DEB}
rm /tmp/${VAGRANT_DEB}

echo "🔌 [5/6] Installation des plugins Vagrant nécessaires..."
vagrant plugin install vagrant-winrm

echo "✅ [6/6] Vérification des versions installées :"
vagrant --version
virtualbox --help | grep version || echo "VirtualBox OK"
ansible --version | head -n1
make --version | head -n1

echo "📁 Tout est prêt ! Tu peux maintenant lancer le lab avec :"
echo "    make up         # Crée les machines"
echo "    make test       # Vérifie la connectivité"
echo "    make provision  # Déploie Samba AD et les clients"
echo "    make destroy    # Supprime le lab complet"
