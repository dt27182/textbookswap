Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "232172730217805", "45ef905d0d32a97c0956ffa245c8c83c"
end
