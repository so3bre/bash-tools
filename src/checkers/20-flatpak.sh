flic() {
    for arg in "$@"; do
        if [[ "$arg" =~ ^(sudo|flatpak|install|update|search|info|-y)$ ]]; then
            continue
        fi

        full_id=$(flatpak search "$arg" --columns=application | head -n 1 | xargs)

        if [ -z "$full_id" ]; then
            echo -e "\nChecking: \033[1m$arg\033[0m — \033[33mNot found in Flatpak\033[0m"
            continue
        fi

        is_installed=""
        if flatpak list --columns=application | grep -q "^$full_id$"; then
            is_installed=" \033[1;32m(installed)\033[0m"
        fi

        echo -e "\nID: \033[1m$full_id\033[0m$is_installed"

        lic_string=$(flatpak remote-info flathub "$full_id" 2>/dev/null | grep -i "License:" | cut -d ":" -f 2- | xargs)

        if [ -z "$lic_string" ]; then
            echo -e "License field not found in remote repository."
            continue
        fi

        IFS='; ' read -r -a lic_array <<< "$lic_string"
        for part in "${lic_array[@]}"; do
            clean_lic=$(echo "$part" | tr -d '(),' | xargs)
            if [ -z "$clean_lic" ]; then continue; fi

            if [[ "$clean_lic" =~ $NON_FREE ]]; then
                echo -e "  └── $clean_lic — \033[34mNON-FREE (Proprietary)\033[0m"
            elif [[ "$clean_lic" =~ $FOSS_LIST ]]; then
                echo -e "  └── $clean_lic — \033[32mFOSS\033[0m"
            else
                echo -e "  └── $clean_lic — \033[33mUNKNOWN (Check manually)\033[0m"
            fi
        done
    done
}
