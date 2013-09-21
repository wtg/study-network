# Configure CAS client 

require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
  cas_base_url: "https://cas-auth.rpi.edu/cas",
  login_url: "https://cas-auth.rpi.edu/cas/login",
  username_session_key: :cas_user,
  extra_attributes_session_key: :cas_extra_attributes
)