if ! [ -x "$(command -v ansible-playbook)" ]; then
  echo 'Ansible is not installed, installing...'
  sudo apt update
  sudo apt install software-properties-common
  sudo apt install ansible
fi

echo 'Ansible ready, starting installation.'
ansible-playbook yggdrasil.yml --ask-become-pass

while true; do
  read -p "Do you want to generate git ssh key? (Y/n) " yn
  case $yn in
    [Yy]* )
      echo 'Using the default values, you can change them in vars/external_vars.yml'
      ansible-galaxy collection install community.crypto
      ansible-playbook gitssh.yml
      break;;
    [Nn]* ) break::
  esac
done

while true; do
  read -p "Installation complete, for changes to take effect rebooting is necessary. Do you want to reboot now? (Y/n) " yn
  case $yn in
    [Yy]* ) sudo reboot; break;;
    [Nn]* ) exit 0;;
  esac
done
