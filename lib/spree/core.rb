require 'rails/all'
require 'active_merchant'
require 'acts_as_list'
require 'awesome_nested_set'
require 'cancan'
require 'friendly_id'
require 'font-awesome-rails'
require 'kaminari'
require 'mail'
require 'monetize'
require 'paperclip'
require 'paranoia'
require 'premailer/rails'
require 'ransack'
require 'responders'
require 'state_machines-activerecord'

# This is required because ActiveModel::Validations#invalid? conflicts with the
# invalid state of a Payment. In the future this should be removed.
StateMachines::Machine.ignore_method_conflicts = true

module Spree

  mattr_accessor :user_class

  def self.user_class
    if @@user_class.is_a?(Class)
      raise "Spree.user_class MUST be a String or Symbol object, not a Class object."
    elsif @@user_class.is_a?(String) || @@user_class.is_a?(Symbol)
      @@user_class.to_s.constantize
    end
  end

  def self.admin_path
    Spree::Config[:admin_path]
  end

  # Used to configure admin_path for Spree
  #
  # Example:
  #
  # write the following line in `config/initializers/spree.rb`
  #   Spree.admin_path = '/custom-path'

  def self.admin_path=(path)
    Spree::Config[:admin_path] = path
  end

  # Used to configure Spree.
  #
  # Example:
  #
  #   Spree.config do |config|
  #     config.track_inventory_levels = false
  #   end
  #
  # This method is defined within the core gem on purpose.
  # Some people may only wish to use the Core part of Spree.
  def self.config(&block)
    yield(Spree::Config)
  end

  module Core
    autoload :ProductFilters, "spree/core/product_filters"
    autoload :GreetingFilters, "spree/core/greeting_filters"
    autoload :TokenGenerator, "spree/core/token_generator"

    class GatewayError < RuntimeError; end
    class DestroyWithOrdersError < StandardError; end
  end
end

require 'spree/core/version'

require 'spree/core/environment_extension'
require 'spree/core/environment/calculators'
require 'spree/core/environment'
require 'spree/core/number_generator'
require 'spree/promo/environment'
require 'spree/migrations'
require 'spree/core/engine'

require 'spree/i18n'
require 'spree/localized_number'
require 'spree/money'
require 'spree/permitted_attributes'

require 'spree/core/delegate_belongs_to'
require 'spree/core/importer'
require 'spree/core/product_duplicator'
require 'spree/core/greeting_duplicator'
require 'spree/core/controller_helpers/auth'
require 'spree/core/controller_helpers/common'
require 'spree/core/controller_helpers/order'
require 'spree/core/controller_helpers/respond_with'
require 'spree/core/controller_helpers/search'
require 'spree/core/controller_helpers/store'
require 'spree/core/controller_helpers/strong_parameters'
