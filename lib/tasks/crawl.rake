namespace :crawl do
  def official_web_site_version
    (ENV['USE_VERSION'].presence || Rails.application.config.x.official_website_proxy.latest_official_website_version).to_i
  end

  def race_params
    {
      date: (ENV['DATE'].presence || Time.zone.today).to_date,
      stadium_tel_code: ENV['STADIUM_TEL_CODE'].to_i,
      race_number: ENV['RACE_NUMBER'].to_i,
    }
  end

  desc 'Crawl event in specified year and month'
  task events: :environment do
    year = (ENV['YEAR'].presence || Time.zone.today.year).to_i
    month = (ENV['MONTH'].presence || Time.zone.today.month).to_i
    date = Date.new(year, month)
    # NOTE:
    # 公式サイトの仕様変更で何ヶ月先取れるかは変わるはず
    # リニューアルされた時点で要修正
    if 2.month.since.beginning_of_month.to_date <= date
      raise StandardError.new('Cannot fetch schedules in which 2 months ahead')
    end
    CrawlEventScheduleService.call(version: official_web_site_version, year: date.year, month: date.month)
  end

  desc 'Crawl event entries on specified date'
  task event_entries: :environment do
    date = (ENV['DATE'].presence || Time.zone.today).to_date
    if Time.zone.tomorrow < date
      raise StandardError.new('Cannot fetch event entries on which after the day after tomorrow')
    end
    FundamentalDataRepository.fetch_events(min_starts_on: date, max_starts_on: date).each do |attribute|
      CrawlEventEntryService.call(version: official_web_site_version,
                                  stadium_tel_code: attribute.fetch('stadium_tel_code'),
                                  event_starts_on: date)
    end
  end

  desc 'Crawl entries on specified race'
  task race_entries: :environment do
    CrawlRaceEntryService.call(version: official_web_site_version, **race_params)
  end

  desc 'Crawl racer conditions on specified race'
  task racer_conditions: :environment do
    CrawlRacerConditionService.call(version: official_web_site_version, **race_params)
  end
end