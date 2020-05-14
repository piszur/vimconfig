## piszur's vim config
* Clone
    * git clone https://github.com/piszur/vimconfig.git ~/.vim/
    * cd ~/.vim/
    * git submodule init
    * git submodule update
    * sudo apt-get install exuberant-ctags
* Refresh submodules
    * git pull --recurse-submodules
* Add submodule
    * git clone <github-web-url> bundle/<dir>
    * git submodule add <github-web-url> bundle/<dir>
* Remove submodule
    * Delete the relevant section from the .gitmodules file.
    * Stage the .gitmodules changes git add .gitmodules
    * Delete the relevant section from .git/config.
    * Run git rm --cached path_to_submodule (no trailing slash).
    * Run rm -rf .git/modules/path_to_submodule (no trailing slash).
    * Commit git commit -m "Removed submodule "
    * Delete the now untracked submodule files rm -rf path_to_submodule
