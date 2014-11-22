# -*- coding: utf-8 -*-
require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'rack/test'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe "test pagina registro y home" do

	it "se abre pagina de Registro?" do
		get '/'
		expect(last_response).to be_ok
	end

	it "registrar un nuevo usuario" do
		post '/' , :text => "usuario"
		expect(last_response).to be_ok
	end


end
