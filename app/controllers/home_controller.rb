class HomeController < ApplicationController
  def index
    @prayer_types = PrayerType.active
  end
end
