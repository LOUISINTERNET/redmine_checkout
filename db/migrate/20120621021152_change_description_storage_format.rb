class ChangeDescriptionStorageFormat < ActiveRecord::Migration
  class Repository < ActiveRecord::Base
    serialize :checkout_settings, Hash

    # disable single table inheritance
    def self.inheritance_column() nil end
    # to fix some strange error where the type did return the class...
    def type() attributes["type"] end
  end

  def self.up
    ## First migrate the individual repositories
    Repository.all.each do |r|
      next unless !r.checkout_settings.empty?
      
      r.checkout_settings['checkout_description'].force_encoding("UTF-8") if r.checkout_settings['checkout_description'].respond_to?(:force_encoding)
      r.save!
    end

    ## Then the global settings
    settings = Setting.plugin_redmine_checkout

    settings["description_Abstract"].force_encoding("UTF-8") if settings["description_Abstract"].respond_to?(:force_encoding)
    Setting.plugin_redmine_checkout = settings
  end

  def self.down
  end
end
