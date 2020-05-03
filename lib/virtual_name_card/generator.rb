require 'mini_magick'
require "rqrcode"
require "chunky_png"

module VirtualNameCard
  class Generator
    GENERATED_FILE_PATH = File.expand_path("../../generated_file.png", __dir__)

    class << self
      # @param [String] name_kanji
      # @param [String] name_romaji
      # @param [String, nil] role
      # @param [String, nil] email
      # @param [String, nil] twitter_account
      # @param [String, nil] url
      # @return [VirtualNameCard::Image]
      def build(name_kanji:, name_romaji:, role: nil, email: nil, twitter_account: nil, url: nil)
        base_image_path =
          if twitter_account
            File.expand_path("../../base_images/with_twitter.jpg", __dir__)
          else
            File.expand_path("../../base_images/without_twitter.jpg", __dir__)
          end

        image = MiniMagick::Image.open(base_image_path)

        name_kanji_combine(image: image, text: name_kanji)
        name_romaji_combine(image: image, text: name_romaji)

        if role
          role_combine(image: image, text: role)
        end

        if email
          email_combine(image: image, text: email)
        end

        if twitter_account
          twitter_account_combine(image: image, text: twitter_account)
        end

        if url
          image = url_combine(image: image, url: url)
        end

        VirtualNameCard::Image.new(mini_magick_image: image)
      end

      # @param [String] name_kanji
      # @param [String] name_romaji
      # @param [String, nil] role
      # @param [String, nil] email
      # @param [String, nil] twitter_account
      # @param [String, nil] url
      def generate(name_kanji:, name_romaji:, role: nil, email: nil, twitter_account: nil, url: nil)
        image = build(
          name_kanji: name_kanji,
          name_romaji: name_romaji,
          role: role,
          email: email,
          twitter_account: twitter_account,
          url: url,
        )
        image.mini_magick_image.write GENERATED_FILE_PATH
      end

      private def name_kanji_combine(image:, text:)
        image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Medium.otf", __dir__)
          config.gravity "west"
          config.pointsize 100
          config.draw "text 170,-90 '#{text}'"
          config.fill "#000000"
        end
      end

      private def name_romaji_combine(image:, text:)
        image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Regular.otf", __dir__)
          config.gravity "west"
          config.pointsize 50
          config.draw "text 170,22 '#{text}'"
          config.fill "#000000"
        end
      end

      private def role_combine(image:, text:)
        image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Regular.otf", __dir__)
          config.gravity "west"
          config.pointsize 45
          config.draw "text 170,105 '#{text}'"
          config.fill "#000000"
        end
      end

      private def email_combine(image:, text:)
        image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Regular.otf", __dir__)
          config.gravity "west"
          config.pointsize 45
          config.draw "text 170,217 '#{text}'"
          config.fill "#000000"
        end
      end

      private def twitter_account_combine(image:, text:)
        image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Medium.otf", __dir__)
          config.gravity "west"
          config.pointsize 45
          config.draw "text 175,433 '#{text}'"
          config.fill "#593535"
        end
      end

      private def url_combine(image:, url:)
        qr_image = RQRCode::QRCode.new(url).as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: 'black',
          file: nil,
          fill: 'white',
          module_px_size: 6,
          resize_exactly_to: false,
          resize_gte_to: false,
          size: 240,
        ).yield_self do |png|
          MiniMagick::Image.read(png.to_s)
        end

        image.composite(qr_image) do |config|
          config.compose "Over"
          config.gravity "east"
          config.geometry "+110+345"
        end
      end
    end
  end
end