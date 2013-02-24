class FileOpsController < ApplicationController

	def index
		
	end

	def new
		@file_op_type = params[:fileOpType]
	end

	#Triggers file scan with given paramters from "new" and displays a 
	#sorted list of all files matching file scan parameters from "file_scan"
	def file_scan
		@extensions = params[:selected_extensions]
		scan_days = params[:scan_days]
		@log_lines = FileOp.file_scan_20(scan_days, @extensions)
	end

	#Catches the selected files from "selected_files_log" and saves a simple text log into 
	#/media/compensato_client/Compensato then isolates and sorts them for display
	def selected_files_log
		@selected_paths = params[:selected_paths]
		@extensions = params[:extensions].split
		FileOp.create_final_scan_log(@selected_paths, @extensions)
	end

	def copy_user_data
		source_directory = params[:source_directory]
		@destination_directory = params[:destination_directory]

		FileOp.copy_data(source_directory, @destination_directory)
		@source_directory_size = FileOp.get_directory_size(source_directory)
		@source_directory_files = FileOp.get_number_of_files(source_directory)
	end

	def file_copy_progress
		@source_directory_size = params[:source_directory_size]
		@destination_directory_size = FileOp.get_directory_size("/home/jasbur/tmp/test")
		@destination_directory_files = FileOp.get_number_of_files("/home/jasbur/tmp/test")
		render :layout => false
	end

	def kill_copy
		FileOp.kill_background_process("cp")
	end

end
