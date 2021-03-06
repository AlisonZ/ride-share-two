require_relative 'spec_helper'
require_relative '../lib/driver.rb'


describe "Driver" do
    describe "initialize method" do
        it "Driver.new must be an instance of a driver" do
            @my_driver = RideShare::Driver.new(16, "Travis Bickle", "WBWSS52P9NEYLVDE9")
            @my_driver.must_be_instance_of RideShare::Driver
        end

        it "takes an id, name and vin " do
            id = 16
            name = "Travis Bickle"
            vin = "WBWSS52P9NEYLVDE9"
            driver = RideShare::Driver.new(id, name, vin)
            driver.must_respond_to :id
            driver.id.must_equal id

            driver.must_respond_to :name
            driver.name.must_equal name

            driver.must_respond_to :vin
            driver.vin.must_equal vin
        end

        it "Raises and error if the vin number is not the correct length" do
            proc { @my_driver = RideShare::Driver.new(16, "Travis Bickle", "WBWSS52P9NEYLVD") }.must_raise ArgumentError

            proc { @my_driver = RideShare::Driver.new(16, "Travis Bickle", "WBWSS52P9NEYLVDE")}.must_raise ArgumentError

        end
    end

    describe "Self.all method" do
        #change this to a let
        before do
            @drivers = RideShare::Driver.all
        end

        it "Must read in csv and create an array of drivers" do
            @drivers.must_be_instance_of Array
        end

        it "Everything in the array is an instance of Driver" do
            @drivers.each do |driver|
                driver.must_be_instance_of RideShare::Driver
            end
        end

        it "The number of drivers is correct" do
            @drivers.length.must_equal 100
        end

        it "The first and last elements in the array match the csv file first and last elements" do
            @drivers[0].id.must_equal 1
            @drivers[0].name.must_equal "Bernardo Prosacco"
            @drivers[0].vin.must_equal "WBWSS52P9NEYLVDE9"

            @drivers[-1].id.must_equal 100
            @drivers[-1].name.must_equal "Minnie Dach"
            @drivers[-1].vin.must_equal "XF9Z0ST7X18WD41HT"
        end



        it "All elements in the Driver instance match the data in the CSV file" do
            @drivers[11].id.must_equal 12
            @drivers[11].name.must_equal "Ms. Llewellyn Marquardt"
            @drivers[11].vin.must_equal "TAMX2B609RPZY1XHT"
        end

    end

    describe "self.find method" do

        it "Returns a driver that exists" do
            @driver = RideShare::Driver.find(32)
            @driver.must_be_instance_of RideShare::Driver
            @driver.name.must_equal "Belle Rohan"
        end

        it "Raises an Error for an incorrect " do
            proc { RideShare::Driver.find(116) }.must_raise ArgumentError
        end

    end


    describe "find_trips method" do
        before do
            @my_driver = RideShare::Driver.new(16, "Travis Bickle", "WBWSS52P9NEYLVDE9")
            @trips = @my_driver.find_trips
        end

        it "Returns an array of trips" do
            @trips.must_be_instance_of Array
        end


        it "Every element in array is a rider object" do
            @trips.each do |trip|
                trip.must_be_instance_of RideShare::Trip
            end

        end

        # it "Returns the correct number of trips" do
            #how to even test this?
        # end


    end

    describe "Ratings Average" do
        before do
            @my_driver = RideShare::Driver.new(16, "Travis Bickle", "WBWSS52P9NEYLVDE9")
        end

        it "Returns a Float" do
            @my_driver.average_rating.must_be_instance_of Float
        end

    end



end
