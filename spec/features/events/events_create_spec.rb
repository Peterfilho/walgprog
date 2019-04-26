require 'rails_helper'

describe 'Event:create', type: :feature do
  let(:admin) { create(:admin) }
  let!(:event) { create(:event) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit new_admins_event_path
  end

  after(:each) do
    Event.delete_all
  end

  context 'when event is valid', js: true do
    it 'create event' do
      attributes = attributes_for(:event)
      fill_in 'event_name', with: attributes[:name]
      fill_in 'event_initials', with: attributes[:initials]
      fill_in 'event_color', with: attributes[:color]
      fill_in 'event_local', with: attributes[:local]
      fill_in 'event_address', with: Event.count

      sleep 1.seconds

      fill_in 'event_beginning_date', with: I18n.l(attributes[:beginning_date] + 1.year, format: :short_hour)
      fill_in 'event_end_date', with: I18n.l(attributes[:end_date] + 1.year, format: :short_hour)

      find('input[name="commit"]').click

      expect(page).to have_current_path admins_events_path
      success_message = I18n.t('events.success.new')
      expect(page).to have_flash(:success, text: success_message)
      expect(page).to have_message(attributes[:name], in: 'table tbody')
    end
  end

  context 'when event is not valid', js: true do
    it 'show errors' do
      find('input[name="commit"]').click
      expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

      message_blank_error = I18n.t('errors.messages.blank')
      expect(page).to have_message(message_blank_error, in: 'div.event_name')
      expect(page).to have_message(message_blank_error, in: 'div.event_local')
      expect(page).to have_message(message_blank_error, in: 'div.event_color')
      expect(page).to have_message(message_blank_error, in: 'div.event_address')
      expect(page).to have_message(message_blank_error, in: 'div.event_initials')
    end
  end
end
