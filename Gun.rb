require './Countdown.rb'

class Gun 
	def initialize (reload_time)
		@reloading = Countdown.new(0).start
		@reload_time = reload_time
	end
	def is_loaded?
		@reloading.is_finished?
	end
	def fire
		if is_loaded? 
			start_reloading
		end
	end
	
	private
	def start_reloading
		@reloading = Countdown.new(@reload_time).start
	end
end
