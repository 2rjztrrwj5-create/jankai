class Admin::BaseController < ApplicationController
  allow_unauthenticated_access
  include AdminAuthentication
end