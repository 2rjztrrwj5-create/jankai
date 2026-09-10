class HomesController < ApplicationController
  allow_unauthenticated_access only: %i[ top ]

  def top
  end
end