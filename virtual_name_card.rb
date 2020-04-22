# frozen_string_literal: true

require 'mini_magick'

class VirtualNameCard
  BASE_IMAGE_PATH = './base_image.png'
  GENERATED_FILE_PATH = "./generated_file.png"

  class << self
    def write(name_kanji:, name_romaji:, role:, twitter_account: nil)
      @image = MiniMagick::Image.open(BASE_IMAGE_PATH)

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
        config.pointsize 80
        config.draw "text 90,-90 '#{text}'"
      end
    end

    private def name_romaji_combine(text)
      @image.combine_options do |config|
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 40
        config.draw "text 90,0 '#{text}'"
      end
    end

    private def role_combine(text)
      @image.combine_options do |config|
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 40
        config.draw "text 90,70 '#{text}'"
      end
    end

    private def twitter_account_combine(text)
      @image.combine_options do |config|
        config.font "./fonts/Noto_Sans_JP/NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 40
        config.draw "text 90,400 '#{text}'"
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
