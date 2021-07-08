module.exports = {
	printWidth: 80,
	semi: true,
	singleQuote: true,
	useTabs: true,
	bracketSpacing: true,
	trailingComma: 'none',
	overrides: [
		{
			files: ['*.yml', '*.yaml'],
			options: {
				singleQuote: false
			}
		}
	]
};
