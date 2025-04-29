local Translations = {
    notify = {
        already_showing = "You're already showing a card.",
        no_nearby_players = "No nearby players.",
        dont_have_item = "You don't have %{type} item.",
        card_type_invalid = "Card type is invalid. (%{type}).",
        not_enough_money = "You don't have enough money.",
        bought = "You bought %{amount}x %{item}.",
        cannot_be_left_empty = "Class name or weapon name can't be left empty.",
        dont_have_req_item = "You don't have required item."
    },
    general = {
        choose_weapon_class_header = "Choose Weapon Class",
        select_type_of_weapon = "Select the type of weapon licence you wish to issue",
        select_weapon = "Select the weapon of the licence you want to issue",
        choose_weapon_header = "Choose Weapon",
        choose_license_type_header = "Choose License Type",
        choose_license_type_description = "Choose the license type you want to create",
        class_label_header = "Create %{class} %{license_type} License",
        class_label2_header = "Create Weapon License",
        choose_player = "Choose the player that you want to give %{class} %{label} weapon for $%{price}",
        confirm_create_license = "You sure you want to create weapon license to %{name}?",
        confirm = "Confirm",
        decline = "Decline",
        male = "Male",
        female = "Female",
        default_nationality = "Los Santos",
        default_nationality_shortened = "LS-",
        driver_license_types = "A/B/C",
        license_type_default = "Weapon License",
        license_type_hunting = "Hunting License"
    },
    ui = {
        buy = "Buy",
        identity_card = "IDENTITY CARD",
        nationality = "NATIONALITY",
        driver_license = "DRIVER LICENSE",
        class = "CLASS",
        citizenship = "CITIZENSHIP",
        lspd_badge = "LSPD BADGE",
        lsms_badge = "LSMS BADGE",
        job = "JOB",
        grade = "GRADE",
        weapon_license = "WEAPON LICENSE",
        weapon = "WEAPON",
        hunting_license = "HUNTING LICENSE",
        class = "CLASS"
    },
    command = {
        description = "Give card to player",
        arg1 = 'Target ID',
        arg2 = 'The card type you want to give'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})