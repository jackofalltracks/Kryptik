class UsersController < Clearance::UsersController
  skip_before_filter :authorize, :only => [:create, :new]
  before_filter :avoid_sign_in, :only => [:create, :new], :if => :signed_in?

 def edit
	@user = User.find_by_id(params[:id])
	@continents = continents_array
    @bands = @user.bands
	@sex = %w{ Male Female Transgender }
	render template: 'users/edit'
 end

 def update
	@user = User.find(params[:id])
    @bands = @user.bands
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
	if @user.update_password password_reset_params
		sign_in @user
		@user.update_attributes(params[:user])
        redirect_to edit_user_path, notice: 'User was successfully updated.'
	else
		flash_failure_after_update
		render template:'users/edit'
	end
 end

 def new
    @user = user_from_params
    @plan = params[:plan]
    render :template => 'users/new'
 end

 def create
    @user = user_from_params
    @plan = params[:plan]
    @user.add_role @plan  
    @user.save
    sign_in @user
    redirect_to edit_user_path(current_user.id), notice: 'User was successfully created!'
  end

  def password_reset_params
	if params.has_key? :user
  		ActiveSupport::Deprecation.warn %{Since locales functionality was added, accessing params[:user] is no longer supported.}
  		params[:user][:password]
	else
  		params[:password_reset][:password]
	end
  end

  def find_user_by_id_and_confirmation_token
    Clearance.configuration.user_model.
      find_by_id_and_confirmation_token params[:user_id], params[:token].to_s
  end

  def find_user_for_create
    Clearance.configuration.user_model.
      find_by_normalized_email params[:password][:email]
  end

  def find_user_for_edit
    find_user_by_id_and_confirmation_token
  end

  def find_user_for_update
    find_user_by_id_and_confirmation_token
  end

  def flash_failure_when_forbidden
    flash.now[:notice] = translate(:forbidden,
      :scope => [:clearance, :controllers, :passwords],
      :default => t('flashes.failure_when_forbidden'))
  end

  def flash_failure_after_update
    flash.now[:notice] = translate(:blank_password,
      :scope => [:clearance, :controllers, :passwords],
      :default => t('flashes.failure_after_update'))
  end

  def forbid_missing_token
    if params[:token].to_s.blank?
      flash_failure_when_forbidden
      render :template => 'passwords/new'
    end
  end

  def forbid_non_existent_user
    unless find_user_by_id_and_confirmation_token
      flash_failure_when_forbidden
      render :template => 'passwords/new'
    end
  end

  def url_after_create
    '/users/#{current_user.id}/edit'
  end

  def url_after_update
    Clearance.configuration.redirect_url
  end

  # Clean this shit up
  def continents_array
  	["Afghanistan", "Åland Islands", "Albania", "Algeria", "American Samoa", "Andorra", "Angola",
    "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia",  "Aruba", "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia, Plurinational State of",
    "Bonaire, Sint Eustatius and Saba",
    "Bosnia and Herzegovina",
    "Botswana",
    "Bouvet Island",
    "Brazil",
    "British Indian Ocean Territory",
    "Brunei Darussalam",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia"]
  end

end

    # "cm" => "Cameroon",
    # "ca" => "Canada",
    # "cv" => "Cape Verde",
    # "ky" => "Cayman Islands",
    # "cf" => "Central African Republic",
    # "td" => "Chad",
    # "cl" => "Chile",
    # "cn" => "China",
    # "cx" => "Christmas Island",
    # "cc" => "Cocos (Keeling) Islands",
    # "co" => "Colombia",
    # "km" => "Comoros",
    # "cg" => "Congo",
    # "cd" => "Congo, the Democratic Republic of the",
    # "ck" => "Cook Islands",
    # "cr" => "Costa Rica",
    # "ci" => "Côte d'Ivoire",
    # "hr" => "Croatia",
    # "cu" => "Cuba",
    # "cw" => "Curaçao",
    # "cy" => "Cyprus",
    # "cz" => "Czech Republic",
    # "dk" => "Denmark",
    # "dj" => "Djibouti",
    # "dm" => "Dominica",
    # "do" => "Dominican Republic",
    # "ec" => "Ecuador",
    # "eg" => "Egypt",
    # "sv" => "El Salvador",
    # "gq" => "Equatorial Guinea",
    # "er" => "Eritrea",
    # "ee" => "Estonia",
    # "et" => "Ethiopia",
    # "fk" => "Falkland Islands (Malvinas)",
    # "fo" => "Faroe Islands",
    # "fj" => "Fiji",
    # "fi" => "Finland",
    # "fr" => "France",
    # "gf" => "French Guiana",
    # "pf" => "French Polynesia",
    # "tf" => "French Southern Territories",
    # "ga" => "Gabon",
    # "gm" => "Gambia",
    # "ge" => "Georgia",
    # "de" => "Germany",
    # "gh" => "Ghana",
    # "gi" => "Gibraltar",
    # "gr" => "Greece",
    # "gl" => "Greenland",
    # "gd" => "Grenada",
    # "gp" => "Guadeloupe",
    # "gu" => "Guam",
    # "gt" => "Guatemala",
    # "gg" => "Guernsey",
    # "gn" => "Guinea",
    # "gw" => "Guinea-Bissau",
    # "gy" => "Guyana",
    # "ht" => "Haiti",
    # "hm" => "Heard Island and McDonald Islands",
    # "va" => "Holy See (Vatican City State)",
    # "hn" => "Honduras",
    # "hk" => "Hong Kong",
    # "hu" => "Hungary",
    # "is" => "Iceland",
    # "in" => "India",
    # "id" => "Indonesia",
    # "ir" => "Iran, Islamic Republic of",
    # "iq" => "Iraq",
    # "ie" => "Ireland",
    # "im" => "Isle of Man",
    # "il" => "Israel",
    # "it" => "Italy",
    # "jm" => "Jamaica",
    # "jp" => "Japan",
    # "je" => "Jersey",
    # "jo" => "Jordan",
    # "kz" => "Kazakhstan",
    # "ke" => "Kenya",
    # "ki" => "Kiribati",
    # "kp" => "Korea, Democratic People's Republic of",
    # "kr" => "Korea, Republic of",
    # "kw" => "Kuwait",
    # "kg" => "Kyrgyzstan",
    # "la" => "Lao People's Democratic Republic",
    # "lv" => "Latvia",
    # "lb" => "Lebanon",
    # "ls" => "Lesotho",
    # "lr" => "Liberia",
    # "ly" => "Libya",
    # "li" => "Liechtenstein",
    # "lt" => "Lithuania",
    # "lu" => "Luxembourg",
    # "mo" => "Macao",
    # "mk" => "Macedonia, the former Yugoslav Republic of",
    # "mg" => "Madagascar",
    # "mw" => "Malawi",
    # "my" => "Malaysia",
    # "mv" => "Maldives",
    # "ml" => "Mali",
    # "mt" => "Malta",
    # "mh" => "Marshall Islands",
    # "mq" => "Martinique",
    # "mr" => "Mauritania",
    # "mu" => "Mauritius",
    # "yt" => "Mayotte",
    # "mx" => "Mexico",
    # "fm" => "Micronesia, Federated States of",
    # "md" => "Moldova, Republic of",
    # "mc" => "Monaco",
    # "mn" => "Mongolia",
    # "me" => "Montenegro",
    # "ms" => "Montserrat",
    # "ma" => "Morocco",
    # "mz" => "Mozambique",
    # "mm" => "Myanmar",
    # "na" => "Namibia",
    # "nr" => "Nauru",
    # "np" => "Nepal",
    # "nl" => "Netherlands",
    # "nc" => "New Caledonia",
    # "nz" => "New Zealand",
    # "ni" => "Nicaragua",
    # "ne" => "Niger",
    # "ng" => "Nigeria",
    # "nu" => "Niue",
    # "nf" => "Norfolk Island",
    # "mp" => "Northern Mariana Islands",
    # "no" => "Norway",
    # "om" => "Oman",
    # "pk" => "Pakistan",
    # "pw" => "Palau",
    # "ps" => "Palestine, State of",
    # "pa" => "Panama",
    # "pg" => "Papua New Guinea",
    # "py" => "Paraguay",
    # "pe" => "Peru",
    # "ph" => "Philippines",
    # "pn" => "Pitcairn",
    # "pl" => "Poland",
    # "pt" => "Portugal",
    # "pr" => "Puerto Rico",
    # "qa" => "Qatar",
    # "re" => "Réunion",
    # "ro" => "Romania",
    # "ru" => "Russian Federation",
    # "rw" => "Rwanda",
    # "bl" => "Saint Barthélemy",
    # "sh" => "Saint Helena, Ascension and Tristan da Cunha",
    # "kn" => "Saint Kitts and Nevis",
    # "lc" => "Saint Lucia",
    # "mf" => "Saint Martin (French part)",
    # "pm" => "Saint Pierre and Miquelon",
    # "vc" => "Saint Vincent and the Grenadines",
    # "ws" => "Samoa",
    # "sm" => "San Marino",
    # "st" => "Sao Tome and Principe",
    # "sa" => "Saudi Arabia",
    # "sn" => "Senegal",
    # "rs" => "Serbia",
    # "sc" => "Seychelles",
    # "sl" => "Sierra Leone",
    # "sg" => "Singapore",
    # "sx" => "Sint Maarten (Dutch part)",
    # "sk" => "Slovakia",
    # "si" => "Slovenia",
    # "sb" => "Solomon Islands",
    # "so" => "Somalia",
    # "za" => "South Africa",
    # "gs" => "South Georgia and the South Sandwich Islands",
    # "ss" => "South Sudan",
    # "es" => "Spain",
    # "lk" => "Sri Lanka",
    # "sd" => "Sudan",
    # "sr" => "Suriname",
    # "sj" => "Svalbard and Jan Mayen",
    # "sz" => "Swaziland",
    # "se" => "Sweden",
    # "ch" => "Switzerland",
    # "sy" => "Syrian Arab Republic",
    # "tw" => "Taiwan, Province of China",
    # "tj" => "Tajikistan",
    # "tz" => "Tanzania, United Republic of",
    # "th" => "Thailand",
    # "tl" => "Timor-Leste",
    # "tg" => "Togo",
    # "tk" => "Tokelau",
    # "to" => "Tonga",
    # "tt" => "Trinidad and Tobago",
    # "tn" => "Tunisia",
    # "tr" => "Turkey",
    # "tm" => "Turkmenistan",
    # "tc" => "Turks and Caicos Islands",
    # "tv" => "Tuvalu",
    # "ug" => "Uganda",
    # "ua" => "Ukraine",
    # "ae" => "United Arab Emirates",
    # "gb" => "United Kingdom",
    # "us" => "United States",
    # "um" => "United States Minor Outlying Islands",
    # "uy" => "Uruguay",
    # "uz" => "Uzbekistan",
    # "vu" => "Vanuatu",
    # "ve" => "Venezuela, Bolivarian Republic of",
    # "vn" => "Viet Nam",
    # "vg" => "Virgin Islands, British",
    # "vi" => "Virgin Islands, U.S.",
    # "wf" => "Wallis and Futuna",
    # "eh" => "Western Sahara",
    # "ye" => "Yemen",
    # "zm" => "Zambia"	