module Fog
  module Webbynode
    class Real

      require 'fog/webbynode/parsers/get_job'

      # Reboot Webby
      # ==== Parameters
      # * slice_id<~Integer> - Id of server to reboot
      #
      # ==== Returns
      # * response<~Excon::Response>:
      #   * body<~Hash>:
      #     * 'job-id'<~String> - Id of the rebooting job
      def reboot_webby(webby_id)
        request(
          :expects  => 200,
          :method   => 'POST',
          :parser   => Fog::Parsers::Webbynode::GetJob.new,
          :path     => "webby/#{webby_id}/reboot"
        )
      end

    end

    class Mock

      def reboot_webby(id)
        raise MockNotImplemented.new("Contributions welcome!")
      end

    end
  end
end
