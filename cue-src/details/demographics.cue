package details

import S "yufan.resume/schema"

demographics: S.#Demographics & {
	name:   "Alex Chen"
	gender: "Male"
	age:    29
	contact: {
		email: "alex.chen@example.com"
		phone: "+14155551234"
	}
	social_networks: [
		{
			network:  "LinkedIn"
			username: "alexchen-dev"
			url:      "https://linkedin.com/in/alexchen-dev"
		},
		{
			network:  "GitHub"
			username: "alexcode"
			url:      "https://github.com/alexcode"
		}
	]
	website: "https://alexchen.io"
	location: "San Francisco, CA"
}
