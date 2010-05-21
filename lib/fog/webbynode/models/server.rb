require 'fog/model'

module Fog
  module Webbynode

    class Server < Fog::Model

      identity :name

      #     * 'plan'<~String> - Plan
      #     * 'status'<~String> - Current status of the Webby
      #     * 'ip'<~String> - Ip addresses for the Webby
      #     * 'name'<~String> - Name of the Webby
      #     * 'notes'<~String> - Notes for the Webby
      #     * 'image-id'<~Integer> - Id of image Webby was booted from

      attribute :ip
      attribute :status
      attribute :image_id, 'image-id'
      attribute :notes

      def destroy
        requires :name
        connection.delete_slice(@name)
        true
      end

      def flavor
        requires :flavor_id
        connection.flavors.get(@flavor_id)
      end

      def image
        requires :image_id
        connection.images.get(@image_id)
      end

      def ready?
        @status == 'on'
      end

      def reboot
        requires :name
        connection.reboot_webby(@name)
        true
      end

      def save
        requires :flavor_id, :image_id, :name
        data = connection.create_webby(@flavor_id, @image_id, @name)
        merge_attributes(data.body)
        true
      end

    end

  end
end
