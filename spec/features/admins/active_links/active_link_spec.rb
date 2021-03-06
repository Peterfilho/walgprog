require 'rails_helper'

RSpec.describe 'Admins::Active_link', type: :feature do
  let(:admin) { create(:admin) }
  let(:active_class) { 'list-group-item list-group-item-action active' }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  it 'have a dashboard active' do
    visit admins_root_path
    expect(page).to have_link(I18n.t('helpers.home'), class: active_class)
  end

  context 'when visit contacts' do
    let!(:contact) { create(:contact) }

    it 'index active' do
      visit admins_contacts_path
      expect(page).to have_link(I18n.t('contacts.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_contact_path
      expect(page).to have_link(I18n.t('contacts.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_contact_path(contact)
      expect(page).to have_link(I18n.t('contacts.index'), class: active_class)
    end

    it 'show active' do
      visit admins_contact_path(contact)
      expect(page).to have_link(I18n.t('contacts.index'), class: active_class)
    end
  end

  context 'when visit institutions' do
    let!(:institution) { create(:institution) }

    it 'index active' do
      visit admins_institutions_path
      expect(page).to have_link(I18n.t('institutions.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_institution_path
      expect(page).to have_link(I18n.t('institutions.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_institution_path(institution)
      expect(page).to have_link(I18n.t('institutions.index'), class: active_class)
    end
  end

  context 'when visit events' do
    let!(:event) { create(:event) }

    it 'index active' do
      visit admins_events_path
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end

    it 'new active' do
      visit new_admins_event_path
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end

    it 'edit active' do
      visit edit_admins_event_path(event)
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end

    it 'show active' do
      visit admins_event_path(event)
      expect(page).to have_link(I18n.t('events.index'), class: active_class)
    end
  end
end
