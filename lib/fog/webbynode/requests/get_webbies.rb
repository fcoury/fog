module Fog
  module Webbynode
    class Real

      require 'fog/webbynode/parsers/get_webbies'

      # Get list of Webbies
      #
      # ==== Returns
      # * response<~Excon::Response>:
      #   * body<~Array>:
      #     * 'plan'<~String> - Plan
      #     * 'status'<~String> - Current status of the Webby
      #     * 'ip'<~String> - Ip addresses for the Webby
      #     * 'name'<~String> - Name of the Webby
      #     * 'notes'<~String> - Notes for the Webby
      #     * 'id'<~Integer> - Id of the slice
      #     * 'image-id'<~Integer> - Id of image Webby was booted from
      def get_webbies
        request(
          :expects  => 200,
          :method   => 'POST',
          :parser   => Fog::Parsers::Webbynode::GetWebbies.new,
          :path     => 'webbies'
        )
      end

    end

    class Mock

      def get_slices
        raise MockNotImplemented.new("Contributions welcome!")
      end

    end
  end
end
