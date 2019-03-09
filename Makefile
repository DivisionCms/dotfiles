.PHONY: install installi3 installdev help
.DEFAULT_GOAL = help
stow = cd config && stow -v -t ~

help: ## Affiche cette aide
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-10s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

install: ## Installe les dépendances du fichier packages/packages.list
	xargs -d '\n' -a packages/packages.list yay --noconfirm --needed -S

installi3: install ## Installe les dépendances du fichier packages/packages.list + l'environment de bureau i3 packages/i3.list
	xargs -d '\n' -a packages/i3.list yay --noconfirm --needed -S

installdev: ## Installe les dépendances de dévéloppement packages/dev.list
	xargs -d '\n' -a packages/dev.list yay --noconfirm --needed -S

i3: ## Indique à stow ou trouver les configurations du linux
	xrdb ~/.Xresources
	$(stow) fish
	$(stow) i3
	$(stow) polybar
	$(stow) compton
	$(stow) keyboard
	$(stow) rofi
	$(stow) vim

xfce: ## Indique à stow ou trouver la configuration pour l'environnement xfce
	$(stow) xfce4