class Countdown
	def initialize (seconds)
		@seconds = seconds
		@started = false
	end
	def is_finished?
		is_started? && time_to_finish <= 0
	end
	def decrease (seconds)
		decreased_countdown = Countdown.new(@seconds - seconds)
		decreased_countdown.started_at(@started_moment) if is_started?
	end
	def start
		Countdown.new(@seconds).started_at(now)
	end
	
	protected
	def is_started?
		@started
	end
	def started_at (moment)
		@started = true
		@started_moment = moment
		self
	end

	private 
	def now
		Time.now
	end
	def finished_moment
		@started_moment + @seconds
	end
	def time_to_finish
		finished_moment - now
	end
end
