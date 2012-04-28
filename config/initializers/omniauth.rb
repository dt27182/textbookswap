Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "221830811263277", "0fc5906ee1962cf96eadf07608b9661e"
end
