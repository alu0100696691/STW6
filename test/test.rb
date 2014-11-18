# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'minitest/autorun'
require 'rack/test'
require 'sinatra'
require 'selenium-webdriver'
require 'rubygems'


describe "test selenium pagina registro" do
	before :each do
		@browser = Selenium::WebDriver.for :firefox
		@url = 'localhost:4567/'
		@browser.get(@url)		
	end
	
	it "se abre pagina de Registro?" do
		begin
			element = @browser.find_element(:id,"login")
		ensure
			element = element.text.to_s
			assert_equal(true, element.include?("Sign In"))
			@browser.quit
		end
	end

	it "registrar un nuevo usuario" do
		@browser.find_element(:id,"nombre").send_keys("ana")
		begin
			element = @browser.find_element(:id,"login")
		ensure
			element.click
			assert_equal("http://localhost:4567/index",@browser.current_url)
			@browser.quit
		end

	end
	
	it "el nuevo usuario ya existe" do
                @browser.find_element(:id,"nombre").send_keys("ana")
                begin
                        element = @browser.find_element(:id,"login")
			#flash = @browser.find_element(:id,"aviso")
                ensure
                        element.click
			@browser.navigate.to(@url);
			@browser.find_element(:id,"nombre").send_keys("ana")
			@browser.find_element(:id,"login").click
			flash = @browser.find_element(:id,"aviso")
			flash = flash.text.to_s
			assert_equal(false, flash.include?("Ese nombre ya existe, por favor, prueba con otro nombre."))
			@browser.quit
                end

        end


end	
