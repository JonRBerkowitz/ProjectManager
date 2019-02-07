Rails.application.config.middleware.use OmniAuth::Builder do
	provider :github, 'd727de17cb226133a99b', '2ea62dce6ae95c3c7e0e8085ec7ae89c52840505'
end