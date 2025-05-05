# Samba AD Lab - Infrastructure as Code

Ce projet permet de déployer un lab complet avec un domaine Active Directory basé sur **Samba**, incluant :

* Un **contrôleur de domaine (DC)** sous Ubuntu
* Un **client Linux** (Ubuntu)
* Un **client Windows**

Le tout provisionné automatiquement via **Vagrant** et **Ansible**.

## Prérequis

Ce lab est conçu pour être lancé sur un hôte Linux (Ubuntu recommandé).

### Logiciels requis :

* VirtualBox
* Vagrant (version officielle HashiCorp)
* Ansible
* Make

## Installation automatique des dépendances

Lance simplement :

```bash
./setup.sh
```

Ce script installe :

* VirtualBox
* Ansible
* Make
* Ruby & outils de compilation
* Vagrant (version 2.3.7 depuis HashiCorp)
* Plugin `vagrant-winrm`

## Dossier du projet

```bash
samba-ad-lab/
├── Vagrantfile
├── Makefile
├── setup.sh
├── ansible/
│   ├── inventory
│   └── playbooks/
│       ├── samba.yml
│       ├── linux-client.yml
│       ├── windows-client.yml
│       └── test-connectivity.yml
```


## Utilisation

Lance les commandes suivantes depuis le dossier `samba-ad-lab` :

### Déploiement

```bash
make up           # Créer les VM
make test         # Tester la connectivité Ansible
make provision    # Provisionner le DC + clients
```

### Réinitialisation / nettoyage

```bash
make destroy      # Supprimer toutes les VMs
make reset        # Supprimer puis recréer le lab complet
```

## Contenu du lab

* Le DC Samba est provisionné selon les bonnes pratiques de [samba.org](https://wiki.samba.org/index.php/Setting_up_Samba_as_an_Active_Directory_Domain_Controller).
* Le client Linux utilise Winbind pour joindre le domaine.
* Le client Windows est joint automatiquement via WinRM (Vagrant + Ansible).

## Remarques importantes

* Le client Windows utilise l'image Vagrant : `peru/windows-10-enterprise-x64-eval`. Elle est lourde (≅6-8 Go).
* WinRM doit être fonctionnel pour qu'Ansible puisse le provisionner.
* Si tu veux tester rapidement le DC + Linux uniquement, commente temporairement le bloc `windows-client` dans le `Vagrantfile`.

## Licence

Ce projet est distribué sous licence MIT.
