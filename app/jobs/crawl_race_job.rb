class CrawlRaceJob < ApplicationJob
  include FileReloadable
  queue_as :high_priority

  def perform(version:, stadium_tel_code:, date:, race_number:)
    CrawlRaceService.call(version: version, stadium_tel_code: stadium_tel_code, date: date, race_number: race_number, no_cache: no_cache)
  end
end