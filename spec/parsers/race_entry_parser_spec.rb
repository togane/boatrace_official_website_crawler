require 'rails_helper'

describe 'race entry parsing' do
  context 'in version 1707' do
    subject { parser.parse }

    let(:parser_class) { V1707::RaceEntryParser }
    let(:parser) { parser_class.new(File.new(file_path, 'r')) }

    context 'when absent racer does not exist' do
      context 'when trio rates rack' do
        let(:file_path) { "#{Rails.root}/spec/fixtures/files/v1707/race/2015_10_16_08#_2R.html" }
        it 'parses race entries' do
          expect(subject).to eq([
            {
              racer_registration_number:  3224,
              racer_first_name: '繁洋',
              racer_last_name: '栗山',
              racer_rank: 'B1',
              pit_number: 1,
              motor_number: 2,
              quinella_rate_of_motor:  43.2,
              trio_rate_of_motor: nil,
              boat_number: 47,
              quinella_rate_of_boat: 28.9,
              trio_rate_of_boat: nil,
              whole_country_winning_rate: 4.6,
              local_winning_rate: 4.71,
              whole_country_quinella_rate_of_racer: 29.4,
              whole_country_trio_rate_of_racer: 42.3,
              local_quinella_rate_of_racer: 28.5,
              local_trio_rate_of_racer: 57.1,
              is_absent: false,
            },
            {
              racer_registration_number: 4015,
              racer_first_name: '竜一',
              racer_last_name: '前野',
              racer_rank: 'A1',
              pit_number: 2,
              motor_number: 39,
              quinella_rate_of_motor: 35.3,
              trio_rate_of_motor: nil,
              boat_number: 53,
              quinella_rate_of_boat: 35.0,
              trio_rate_of_boat: nil,
              whole_country_quinella_rate_of_racer: 43.8,
              local_winning_rate: 6.41,
              local_quinella_rate_of_racer: 52.9,
              whole_country_trio_rate_of_racer: 60.9,
              local_trio_rate_of_racer: 76.4,
              whole_country_winning_rate: 6.02,
              is_absent: false,
            },
            {
              racer_registration_number: 4037,
              racer_first_name: '正幸',
              racer_last_name: '別府',
              racer_rank: 'A2',
              pit_number: 3,
              motor_number: 9,
              quinella_rate_of_motor: 28.3,
              trio_rate_of_motor: nil,
              boat_number: 63,
              quinella_rate_of_boat: 53.7,
              trio_rate_of_boat: nil,
              whole_country_winning_rate: 5.31,
              local_winning_rate: 7.14,
              whole_country_quinella_rate_of_racer: 34.6,
              local_quinella_rate_of_racer: 59.0,
              whole_country_trio_rate_of_racer: 54.0,
              local_trio_rate_of_racer: 77.2,
              is_absent: false,
            },
            {
              racer_registration_number: 4114,
              racer_first_name: '達徳',
              racer_last_name: '深澤',
              racer_rank: 'B1',
              pit_number: 4,
              motor_number: 59,
              quinella_rate_of_motor: 47.2,
              trio_rate_of_motor: nil,
              boat_number: 34,
              quinella_rate_of_boat: 28.3,
              trio_rate_of_boat: nil,
              whole_country_winning_rate: 5.63,
              local_winning_rate: 5.74,
              whole_country_quinella_rate_of_racer: 39.1,
              local_quinella_rate_of_racer: 39.1,
              whole_country_trio_rate_of_racer: 54.3,
              local_trio_rate_of_racer: 52.1,
              is_absent: false,
            },
            {
              racer_registration_number: 4799,
              racer_first_name: '大我',
              racer_last_name: '大山',
              racer_rank: 'B2',
              pit_number: 5,
              motor_number: 53,
              quinella_rate_of_motor: 27.1,
              trio_rate_of_motor: nil,
              boat_number: 75,
              quinella_rate_of_boat: 23.8,
              trio_rate_of_boat: nil,
              whole_country_winning_rate: 2.31,
              local_winning_rate: 1.75,
              whole_country_quinella_rate_of_racer: 2.0,
              local_quinella_rate_of_racer: 0.0,
              whole_country_trio_rate_of_racer: 8.1,
              local_trio_rate_of_racer: 8.3,
              is_absent: false,
            },
            {
              racer_registration_number: 3591,
              racer_first_name: '孝義',
              racer_last_name: '後藤',
              racer_rank: 'A2',
              pit_number: 6,
              motor_number: 43,
              quinella_rate_of_motor: 32.8,
              trio_rate_of_motor: nil,
              boat_number: 31,
              quinella_rate_of_boat: 16.6,
              trio_rate_of_boat: nil,
              whole_country_winning_rate: 5.82,
              local_winning_rate: 5.21,
              whole_country_quinella_rate_of_racer: 36.9,
              local_quinella_rate_of_racer: 30.9,
              whole_country_trio_rate_of_racer: 60.3,
              local_trio_rate_of_racer: 54.7,
              is_absent: false,
            }
          ])
        end

        context 'when trio rates do not rack' do
          let(:file_path) { "#{Rails.root}/spec/fixtures/files/v1707/race/2018_03_01_07#_8R.html" }
          it 'parses race entries which include trio rates of motor and boat' do
            expect(subject.map{|hash| hash.extract!(:racer_registration_number, :trio_rate_of_motor, :trio_rate_of_boat) }).to eq [
              { racer_registration_number: 4190, trio_rate_of_motor: 51.90, trio_rate_of_boat: 57.22 },
              { racer_registration_number: 4240, trio_rate_of_motor: 51, trio_rate_of_boat: 55.29 },
              { racer_registration_number: 4419, trio_rate_of_motor: 51.49, trio_rate_of_boat: 54.79 },
              { racer_registration_number: 3175, trio_rate_of_motor: 55.61, trio_rate_of_boat: 45.51 },
              { racer_registration_number: 3254, trio_rate_of_motor: 46.72, trio_rate_of_boat: 50.86 },
              { racer_registration_number: 4843, trio_rate_of_motor: 49.49, trio_rate_of_boat: 45.35 }
            ]
          end
        end
      end
    end

    context 'when absent racer exists' do
      let(:file_path) { "#{Rails.root}/spec/fixtures/files/v1707/race/2015_11_16_03#_11R.html" }

      it 'parses race entries which include absent racers' do
        expect(subject.map{|hash| hash.extract!(:racer_registration_number, :pit_number, :is_absent) }).to eq [
          { racer_registration_number: 3872, pit_number: 1, is_absent: true, },
          { racer_registration_number: 3880, pit_number: 2, is_absent: false, },
          { racer_registration_number: 3793, pit_number: 3, is_absent: false, },
          { racer_registration_number: 4357, pit_number: 4, is_absent: false, },
          { racer_registration_number: 4037, pit_number: 5, is_absent: false, },
          { racer_registration_number: 3797, pit_number: 6, is_absent: false, }
        ]
      end
    end
  end
end
