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

	it "Acceso a actualizar usuarios" do
		get '/update/usuarios'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "cerrar sesion" do
		get '/salir'
		expect(last_response.body).to eq("")
	end

	it "Acceso a send" do
		get '/send'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "Acceso a update" do
		get '/update'
		expect(last_response.body).to eq("Not an ajax request")
	end

end
