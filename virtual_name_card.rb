# frozen_string_literal: true

require 'mini_magick'

class VirtualNameCard
  BASE_IMAGE_PATH = './base_image.png'
  GENERATED_FILE_PATH = "./generated_file.png"

  class << self
    def write(name_kanji:, name_romaji:, role:, twitter_account: nil)
      base_image_path =
        if twitter_account
          "./base_images/with_twitter.jpg"
        else
          "./base_images/without_twitter.jpg"
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
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Medium.otf"
        config.gravity "west"
        config.pointsize 100
        config.draw "text 170,-90 '#{text}'"
        config.fill "#000000"
      end
    end

    private def name_romaji_combine(text)
      @image.combine_options do |config|
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 50
        config.draw "text 170,22 '#{text}'"
        config.fill "#000000"
      end
    end

    private def role_combine(text)
      @image.combine_options do |config|
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 45
        config.draw "text 170,105 '#{text}'"
        config.fill "#000000"
      end
    end

    private def twitter_account_combine(text)
      @image.combine_options do |config|
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Medium.otf"
        config.gravity "west"
        config.pointsize 45
        config.draw "text 175,433 '#{text}'"
        config.fill "#593535"
      end
    end
  end
end

VirtualNameCard.write(
  name_kanji: ARGV[0],
  name_romaji: ARGV[1],
  role: ARGV[2],
  twitter_account: ARGV[3],
)
