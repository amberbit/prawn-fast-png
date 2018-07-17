# Extracts the data from a PNG that is needed for embedding. Uses RMagick to
# separate RGB and A channels.

unless Object.const_defined?(:Prawn)
  raise %q{Prawn not loaded yet. Make sure you "require 'prawn'" or "require 'prawn/core'" before "require 'prawn/fast_png'"}
end

require 'rmagick'

module Prawn
  module Images
    class PNG
      alias_method :prawn_fast_png_old_initialize, :initialize

      def initialize(data) #:nodoc:
        @prawn_fast_png_data = data
        prawn_fast_png_old_initialize(data)
      end

      private

      def unfilter_image_data
        img = Magick::Image.from_blob(@prawn_fast_png_data).first
        # image blob not needed anymore, let GC take care of it
        @prawn_fast_png_data = nil

        # get only one color value per pixel (Intensity) for grayscale+alpha images
        format = color_type == 4 ? 'I' : 'RGB'

        case bits
        when 8
          img_data      = img.export_pixels_to_str(0, 0, width, height, format)
          alpha_channel = img.export_pixels_to_str(0, 0, width, height, 'A')
        when 16
          # export_pixels_to_str returns little-endian data, but we need big-endian
          # so it's usually more efficient to use export_pixels and pack
          img_data   = img.export_pixels(0, 0, width, height, format).pack('n*')
          alpha_data = img.export_pixels(0, 0, width, height, 'A')
          alpha_bits = respond_to?(:alpha_channel_bits) ? alpha_channel_bits : 16
          alpha_channel =
            case alpha_bits
            when 8
              # downsample 16-bit alpha channel to 8 bits for Adobe Reader support
              alpha_data.map { |byte| byte >> 8 }.pack('c*')
            when 16
              alpha_data.pack('n*')
            else
              raise Errors::UnsupportedImageType, "Can't create #{alpha_channel_bits}-bit alpha channel"
            end
        else
          raise Errors::UnsupportedImageType, "Can't handle #{bits}-bit PNG images"
        end

        @img_data      = Zlib::Deflate.deflate(img_data)
        @alpha_channel = Zlib::Deflate.deflate(alpha_channel)
      end
    end
  end
end

