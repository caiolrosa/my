if !command -v ansible-playbook &> /dev/null; then
  echo 'Ansible is not installed, installing...'
  sudo pacman -S ansible
fi

echo 'Ansible ready, starting installation.'
ansible-playbook yggdrasil.yml --ask-become-pass

echo 'Do you want to generate git ssh key?'
select permit in "Yes" "No"; do
  case $permit in
    Yes )
      echo 'Using the default values, you can change them in vars/external_vars.yml'
      ansible-galaxy collection install community.crypto
      ansible-playbook gitssh.yml
      break;;
    No ) break;;
  esac
done

echo 'Installation complete, for changes to take effect rebooting is necessary. Do you want to reboot now?'
select permit in "Yes" "No"; do
  case $permit in
    Yes ) sudo reboot; break;;
    No  ) exit;;
  esac
done
