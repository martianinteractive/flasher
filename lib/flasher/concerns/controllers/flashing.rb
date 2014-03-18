module Flasher
  module Concerns
    module Controllers
      module Flashing

        def self.included(base)
          base.after_filter :flash_to_cookie
        end

        def flash_to_cookie
          return unless flash.any?
          cookies[:flash] = {:value => flash.to_json}
          flash.discard
        end
      end
    end
  end
end
