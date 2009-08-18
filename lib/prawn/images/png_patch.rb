# Extracts the data from a PNG that is needed for embedding. Uses RMagick to
# separate RGB and A channels.

require 'prawn'
require 'RMagick'

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

        # get only one color value per pixel (Intensity) for grayscale+alpha images
        format = color_type == 4 ? 'I' : 'RGB'

        case bits
        when 8
          img_data      = img.export_pixels_to_str(0, 0, width, height, format)
          alpha_channel = img.export_pixels_to_str(0, 0, width, height, 'A')
        when 16
          # export_pixels_to_str returns little-endian data, but we need big-endian
          # so it's usually more efficient to use export_pixels and pack
          img_data      = img.export_pixels(0, 0, width, height, format).pack('n*')
          alpha_channel = img.export_pixels(0, 0, width, height, 'A').pack('n*')
        else
          raise Errors::UnsupportedImageType, "Can't handle #{img.depth}-bit PNG images"
        end

        @img_data      = Zlib::Deflate.deflate(img_data)
        @alpha_channel = Zlib::Deflate.deflate(alpha_channel)

        # image blob not needed anymore, let GC take care of it
        @prawn_fast_png_data = nil
      end
    end
  end
end

