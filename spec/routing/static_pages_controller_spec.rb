require 'spec_helper'

describe 'Routing to StaticPagesController' do

  it 'routes GET / to #home' do
    {get: '/'}.should route_to('static_pages#home')
  end

  it 'routes GET /help to #help' do
    {get: 'help'}.should route_to('static_pages#help')
  end

end