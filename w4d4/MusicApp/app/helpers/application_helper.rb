module ApplicationHelper
  def ugly_lyrics(lyrics)
    lyrics.split("\n").map do |line|
      next if line.blank?
      "♫ #{line}"
    end.join("\n")
  end

  def auth_token
    auth = <<-HTML
    <input type='hidden'
           name='authenticity_token'
           value=#{form_authenticity_token}>
    HTML

    auth.html_safe
  end
end
