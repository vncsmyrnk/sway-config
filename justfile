os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-dependencies:
  #!/usr/bin/env bash
  if [ "{{os}}" = "Arch Linux" ]; then
    yay -S --needed - < packages/pacman.txt
  fi

config:
  mkdir -p "{{home_dir()}}/.config/sway" "{{home_dir()}}/.config/waybar" /etc/greetd
  sudo stow -t /usr/local/bin bin --no-folding
  sudo stow -t /etc/greetd greetd --no-folding
  stow -t "{{home_dir()}}/.config/sway" -d config sway --no-folding
  stow -t "{{home_dir()}}/.config/waybar" -d config waybar --no-folding

unset-config:
  sudo stow -D -t /usr/local/bin bin
  sudo stow -D -t /etc/greetd greetd
  stow -D -t "{{home_dir()}}/.config/sway" -d config sway
  stow -D -t "{{home_dir()}}/.config/waybar" -d config sway
