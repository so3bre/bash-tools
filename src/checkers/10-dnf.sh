lic() {
    local args=()
    for arg in "$@"; do
        if [[ "$arg" =~ ^(sudo|dnf|install|update|reinstall|search|info|-y|--assumeyes)$ ]]; then
            continue
        fi
        args+=("$arg")
    done

    check_package() {
        local pkg=$1

        is_installed=""
        if rpm -q "$pkg" &>/dev/null; then
            is_installed=" \033[1;32m(installed)\033[0m"
        fi

        echo -e "\nChecking: \033[1m$pkg\033[0m$is_installed"

        lic_string=$(dnf info "$pkg" 2>/dev/null | grep -i "License" | cut -d ":" -f 2- | xargs)

        if [ -z "$lic_string" ]; then
            echo -e "Package not found or License field is empty."
            return
        fi

        IFS=' ' read -r -a lic_array <<< "$lic_string"

        for part in "${lic_array[@]}"; do
            clean_lic=$(echo "$part" | tr -d '(),' | sed 's/LicenseRef-Callaway-//g')

            if [[ "$clean_lic" =~ ^(AND|OR|WITH|and|or|with)$ ]]; then continue; fi

            if [[ "$clean_lic" =~ $NON_FREE ]]; then
                echo -e "  └── $clean_lic — \033[34mNON-FREE (Proprietary)\033[0m"
            elif [[ "$clean_lic" =~ $FOSS_LIST ]]; then
                echo -e "  └── $clean_lic — \033[32mFOSS\033[0m"
            else
                echo -e "  └── $clean_lic — \033[33mUNKNOWN (Check manually)\033[0m"
            fi
        done
    }

    for p in "${args[@]}"; do
        check_package "$p"
    done
}
