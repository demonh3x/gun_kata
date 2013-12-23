require './Gun.rb'

describe Gun, "#is_loaded?" do
	reload_time = 10
	before(:each) do
		@gun = Gun.new(reload_time)
	end
	describe 'Before firing the gun' do
		it 'should be loaded' do
			@gun.is_loaded?.should be true
		end
	end
	describe 'After firing the gun' do
		before(:each) do
			@gun.fire
		end
		it 'should not be loaded' do 
			@gun.is_loaded?.should be false
		end
		describe 'and reload time passed' do
			it 'should be loaded again' do
				Time.fast_forward(reload_time)
				@gun.is_loaded?.should be true
			end
		end
		describe 'and less than reload time passed' do
			it 'should not be loaded' do
				Time.fast_forward(reload_time -1)
				@gun.is_loaded?.should be false
			end
		end
	end
end

require './Countdown.rb'

class Time
	@now = Time.utc(2013)
	def self.now
		@now
	end
	def self.fast_forward (seconds)
		@now += seconds
	end
end

describe Countdown, '#finished?' do
	def create (seconds)
		Countdown.new(seconds)
	end

	describe 'When creating with 0 seconds' do
		it 'should not be finished' do
			create(0).is_finished?.should be false
		end
		describe 'and starting it' do
			it 'should be finished' do
				create(0).start.is_finished?.should be true
			end
		end
	end

	describe 'When creating a started countdown with 2 seconds' do
		before(:each) do
			@countdown = create(2).start
		end

		it 'should not be finished' do
			@countdown.is_finished?.should be false
		end

		describe 'and decreasing 2 seconds' do
			it 'should be finished' do
				@countdown.decrease(2).is_finished?.should be true
			end
		end
		describe 'and decreasing 1 second' do
			it 'should not be finished' do
				@countdown.decrease(1).is_finished?.should be false
			end
		end
		describe 'and 2 seconds passed' do
			it 'should be finished' do
				Time.fast_forward(2)
				@countdown.is_finished?.should be true
			end
		end
		describe 'and 1 second passed' do
			before(:each) do
				Time.fast_forward(1)
			end
			it 'should not be finished' do
				@countdown.is_finished?.should be false
			end
			describe 'and decreasing 1 second' do
				it 'should be finished' do
					@countdown.decrease(1).is_finished?.should be true
				end
			end
		end
	end
end
