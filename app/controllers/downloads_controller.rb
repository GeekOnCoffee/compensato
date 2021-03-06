class DownloadsController < ApplicationController

	#Main index for the "downloads" controller. Also generates download links to be selected in index view
	def index
		@online_status = true

		if SystemInfo.get_system_stats[:ip_address].nil?
			@online_status = false
		end

		if @online_status == true
			combofix_url = Download.get_combofix_url

			@file_links = {
				"Full Compensato Suite (Chrome, MSSE, Flash, Java, Malwarebytes, Adobe Reader)" => "http://ninite.com/chrome-essentials-flash-flashie-java-malwarebytes-reader/ninite.exe",
				"TDSSKiller" => "http://support.kaspersky.com/downloads/utils/tdsskiller.exe",
				"Malwarebytes" => "http://ninite.com/malwarebytes/ninite.exe",
				"ComboFix" => combofix_url,
				"Google Chrome" => "http://ninite.com/chrome/ninite.exe",
				"Microsoft Security Essentials" => "http://ninite.com/essentials/ninite.exe",
				"Adobe Flash" => "http://ninite.com/flash-flashie/ninite.exe",
				"Java" => "http://ninite.com/java/ninite.exe"
			}

		end
	end

	#Process the selected downloads from /downloads/index
	def fetch_downloads
		pre_hash_download_links = params[:download_links]
		download_links = Hash.new

		pre_hash_download_links.each{|pre_hash_download_link|
			pair = pre_hash_download_link.split("|")
			download_links[pair[0]] = pair[1]
		}

		Download.download_files_to_client(download_links)
	end

end
