require 'mini_magick'

module VirtualNameCard
  class Generator
    GENERATED_FILE_PATH = File.expand_path("../../generated_file.png", __dir__)

    class << self
      def generate(name_kanji:, name_romaji:, role:, twitter_account: nil)
        base_image_path =
          if twitter_account
            File.expand_path("../../base_images/with_twitter.jpg", __dir__)
          else
            File.expand_path("../../base_images/without_twitter.jpg", __dir__)
          end

        @image = MiniMagick::Image.open(base_image_path)

        name_kanji_combine(name_kanji)
        name_romaji_combine(name_romaji)
        role_combine(role)

        if twitter_account
          twitter_account_combine(twitter_account)
        end

        @image.write GENERATED_FILE_PATH
      end

      private def name_kanji_combine(text)
        @image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Medium.otf", __dir__)
          config.gravity "west"
          config.pointsize 100
          config.draw "text 170,-90 '#{text}'"
          config.fill "#000000"
        end
      end

      private def name_romaji_combine(text)
        @image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Regular.otf", __dir__)
          config.gravity "west"
          config.pointsize 50
          config.draw "text 170,22 '#{text}'"
          config.fill "#000000"
        end
      end

      private def role_combine(text)
        @image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Regular.otf", __dir__)
          config.gravity "west"
          config.pointsize 45
          config.draw "text 170,105 '#{text}'"
          config.fill "#000000"
        end
      end

      private def twitter_account_combine(text)
        @image.combine_options do |config|
          config.font File.expand_path("../../fonts/Noto_Sans_JP/NotoSansJP-Medium.otf", __dir__)
          config.gravity "west"
          config.pointsize 45
          config.draw "text 175,433 '#{text}'"
          config.fill "#593535"
        end
      end
    end
  end
end