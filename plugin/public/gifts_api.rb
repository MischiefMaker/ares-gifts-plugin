module AresMUSH
  module Gifts

    def self.get_gifts_for_web_viewing(char, viewer)
        (char.gifts || {}).map { |name, desc| {
        name: name,
        desc: Website.format_markdown_for_html(desc)
        }}
    end

    def self.get_gifts_for_web_editing(char)
        (char.gifts || {}).map { |name, desc| {
        name: name,
        desc: Website.format_input_for_html(desc)
        }}
    end

    def self.save_gifts_from_chargen(char, chargen_data)
      gifts = chargen_data[:custom] || {}
      gifts.each do |name, desc|
        gifts[name.titlecase] = Website.format_input_for_mush(desc)
      end
      char.update(gifts: gifts)
      return []
    end

    def self.get_blurb_for_web()
     blurb = Global.read_config('gifts')["gifts_blurb"]
     Website.format_input_for_html(blurb)
    end

    def self.check_gifts_for_chargen(char)
      gifts = char.gifts || {}
      if (gifts.empty?())
        msg = t('chargen.oops_missing', :missing => "Gifts")
      else
        msg = t('chargen.ok')
      end

      return Chargen.format_review_status "Checking gifts are set.", msg
    end

  end
end
