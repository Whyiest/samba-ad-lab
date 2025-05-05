# Lancer les VM avec Vagrant
up:
	vagrant up

# Arrêter les VM
halt:
	vagrant halt

# Supprimer toutes les VM
destroy:
	vagrant destroy -f

# Tester la connectivité Ansible
test:
	ansible-playbook -i ansible/inventory ansible/playbooks/test-connectivity.yml

# Provisionner le DC, puis les clients
provision:
	ansible-playbook -i ansible/inventory ansible/playbooks/samba.yml
	ansible-playbook -i ansible/inventory ansible/playbooks/linux-client.yml
	ansible-playbook -i ansible/inventory ansible/playbooks/windows-client.yml

# Réinitialiser complètement le lab (⚠️ tout sera perdu)
reset: destroy up provision
