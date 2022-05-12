class Api::RobotController < ApplicationController
	def orders
		place = params[:commands][0].split(" ")
		position = place[1].split(",")
		x = position[0].strip.to_i
		y = position[1].strip.to_i
		direction = position[2]
		move_shifts = params[:commands].drop(1)

		if x < 0 || y < 0 || x > 4 || y > 4
			return render json: {messsage: "Invalid starting position."}
		end
		move_shifts.each do |cmd|
			case direction
			when "NORTH"
				case cmd
				when "MOVE"
					y = y + 1 unless (y+1 < 0) || (y+1 > 4)
				when "LEFT"
					direction = "WEST"
				when "RIGHT"
					direction = "EAST"
				else
					return render json: {messsage: "Invalid command passed!"}
				end
			when "SOUTH"
				case cmd
				when "MOVE"
					y = y - 1  unless (y-1 < 0) || (y-1 > 4)
				when "LEFT"
					direction = "EAST"
				when "RIGHT"
					direction = "WEST"
				else
					return render json: {messsage: "Invalid command passed!"}
				end
			when "EAST"
				case cmd
				when "MOVE"
					x = x + 1  unless (x+1 < 0) || (x+1 > 4)
				when "LEFT"
					direction = "NORTH"
				when "RIGHT"
					direction = "SOUTH"
				else
					return render json: {messsage: "Invalid command passed!"}
				end
			when "WEST"
				case cmd
				when "MOVE"
					x = x - 1  unless (x-1 < 0) || (x-1 > 4)
				when "LEFT"
					direction = "SOUTH"
				when "RIGHT"
					direction = "NORTH"
				else
					return render json: {messsage: "Invalid command passed!"}
				end
			else
				return render json: {messsage: "Invalid direction passed in command!"}
			end
		end

		render json: {location: [x,y,direction]}
		
	end
end
