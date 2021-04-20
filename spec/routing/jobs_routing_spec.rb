require 'rails_helper'

RSpec.describe JobsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'companies/1/jobs').to route_to('jobs#index', company_id: '1')
    end

    it 'routes to #new' do
      expect(get: 'companies/1/jobs/new').to route_to('jobs#new', company_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'companies/1/jobs/1').to route_to('jobs#show', company_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'companies/1/jobs/1/edit').to route_to('jobs#edit', company_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'companies/1/jobs').to route_to('jobs#create', company_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'companies/1/jobs/1').to route_to('jobs#update', company_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'companies/1/jobs/1').to route_to('jobs#update', company_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'companies/1/jobs/1').to route_to('jobs#destroy', company_id: '1', id: '1')
    end
  end
end
