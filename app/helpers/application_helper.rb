# frozen_string_literal: true

module ApplicationHelper
  def streams_data_html(data)
    "<strong>#{data.month}/#{data.year}</strong> </br>Listeners: #{data.listeners} </br> Streams: #{data.streams} </br> Followers: #{data.followers} </br></br>"
  end
end
