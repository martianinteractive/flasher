module Flasher
  module Concerns
    module Controllers
      module Flashing

        def self.included(base)
          base.after_filter :flash_to_cookie
        end

        def flash_to_cookie
          return unless flash.any?
          cookie_flash = []
          if cookies['flash']
            cookie_flash = JSON.parse(cookies['flash']) rescue nil
            cookie_flash=[] unless cookie_flash.is_a? Array
          end

          cookie_flash += flash.to_a
          cookies[:flash] = {:value => cookie_flash.to_json, :domain => :all}
          flash.discard
        end
      end
    end
  end
end
