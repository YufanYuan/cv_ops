package content

import (
	D "yufan.resume/design"
	L "yufan.resume/locale"
)

// Base template for all documents
#DocBase: {
	_locale: "en" | "zh"

	// Automatically mount design / locale information:
	// Retrieve design.en / design.zh based on locale
	design: D[_locale]
	locale: L[_locale]
	cv: {...}
}
