black_highway = 0
black_background = 0
no_fail = 0
is_custom_mode = 0
enable_debug = 0

script create_main_menu_elements 
	if NOT ($invite_controller = -1)
		return
	endif
	base_menu_pos = (730.0, 125.0)
	main_menu_font = fontgrid_title_a1
	DestroyViewportMenuTexture
	if ($is_demo_mode = 1)
		demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
	else
		demo_mode_disable = {}
	endif
	if ($is_demo_mode = 0)
		if ($is_multiplayer_beta = 1)
			demo_mode_disable = {rgba = [128 128 128 255] not_focusable}
		else
			demo_mode_disable = {}
		endif
	endif
	CreateScreenElement \{type = VMenu
		parent = root_window
		id = current_menu
		dims = (1280.0, 720.0)
		just = [
			left
			top
		]
		pos = (0.0, 0.0)
		scale = (1.0, 0.8)
		internal_just = [
			center
			bottom
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
		]
		position_children = false}
	container_pos = (850.0, 148.0)
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = qs("QUICKPLAY")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_quickplay
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = qs("HEAD TO HEAD")
			<demo_mode_disable>
		}
		choose_script = main_menu_select_multiplayer
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	if isXenon
		online_text = qs("Xbox LIVE")
	else
		if IsNgc
			online_text = qs(0xc076c88d)
		else
			online_text = qs("ONLINE")
		endif
	endif
	if ($disable_wifi = 1)
		<wifi_enable_props> = {not_focusable}
		<color_props> = {rgba = [64 64 64 250]}
	else
		<wifi_enable_props> = {}
		<color_props> = {}
	endif
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = <online_text>
			<demo_mode_disable>
		}
		choose_script = main_menu_select_online
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<wifi_enable_props>
		}
		text_params = {
			text = qs("MUSIC STUDIO")
			<color_props>
		}
		choose_script = main_menu_select_jam
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = $wii_rock_star_creator
			<demo_mode_disable>
		}
		choose_script = main_menu_select_cas
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
			<demo_mode_disable>
		}
		text_params = {
			text = $wii_freestyle
			<demo_mode_disable>
		}
		choose_script = main_menu_select_freestyle
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	add_mainmenu_item {
		parent = current_menu
		container_params = {
			pos = <container_pos>
		}
		text_params = {
			text = qs("OPTIONS")
		}
		choose_script = main_menu_select_options
	}
	container_pos = (<container_pos> + (0.0, 48.0))
	show_debug_menus = 0
	if ($enable_button_cheats = 1)
		<show_debug_menus> = 1
		if ($enable_debug_menus = 0)
			<show_debug_menus> = 0
		endif
	endif
	if (<show_debug_menus>)
		if ($is_multiplayer_beta = 0)
			add_mainmenu_item {
				parent = current_menu
				container_params = {
					pos = <container_pos>
				}
				text_params = {
					text = qs("\LDEBUG MENU")
				}
				choose_script = main_menu_select_debug
			}
		endif
	endif
endscript

script ui_create_options 
	change \{rich_presence_context = presence_menus}
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	make_menu_frontend \{screen = Guitarist
		title = qs("OPTIONS")
		spacing_between = 0
		item_scale = 1.1
		title_pos = (-25.0, 40.0)
		pos = (-30.0, -40.0)}
	add_menu_frontend_item \{text = $wii_DLC_visit_RA
		pad_choose_script = main_menu_select_rock_archive}
	add_menu_frontend_item \{text = qs("SETTINGS")
		choose_state = uistate_options_settings}
	add_menu_frontend_item \{text = qs("BAND INFO")
		choose_state = uistate_band_name_logo
		choose_state_data = {
			skip_destroy
		}}
	add_menu_frontend_item \{text = $wii_friend_roster
		pad_choose_script = launch_offline_friends_list}
	add_menu_frontend_item \{text = qs("LEADERBOARDS")
		choose_state = UIstate_top_rockers_mode}
	add_menu_frontend_item \{text = qs("CALIBRATE LAG")
		choose_state = UIstate_options_calibrate_lag}
	if NOT current_band_has_band_name
		<item_id> :SE_SetProps not_focusable text_rgba = [64 64 64 255]
	endif
	add_menu_frontend_item \{text = qs("SAVE / LOAD")
		choose_state = uistate_options_data}
	add_menu_frontend_item \{text = qs("VIDEOS")
		choose_state = uistate_bonus_videos}
	add_menu_frontend_item \{text = qs("CHEATS")
		choose_state = uistate_options_cheats}
	add_menu_frontend_item \{text = $mod_menu_text
		pad_choose_script = main_menu_select_downloads}
	menu_finish
endscript

script ui_create_downloads 
	change \{respond_to_signin_changed = 1}
	change \{respond_to_signin_changed_func = none}
	menu_music_on
	make_menu_frontend \{screen = bassist
		title = $mod_menu_text}
	add_menu_frontend_item \{text = $modifier_text
		choose_state = uistate_atom_unlock}	
	add_menu_frontend_item \{text = $unlock_all_text
		pad_choose_script = playday_unlockall}
	add_menu_frontend_item \{text = $show_fps_text
		pad_choose_script = show_wii_fps}
	<item_id> :SE_SetProps {
		event_handlers = [
			{focus retail_menu_focus params = {id = <id>}}
			{unfocus retail_menu_unfocus params = {id = <id>}}
		]
	}
	menu_finish
endscript

script ui_create_atom_unlock 
	make_generic_menu \{title = $modifier_text}
	add_generic_menu_text_item \{text = $no_fail_text
		pad_choose_script = ui_no_fail_toggle}
	add_generic_menu_text_item \{text = $black_background_text
		pad_choose_script = ui_black_background_toggle}
	add_generic_menu_text_item \{text = $allowcontroller_text
		pad_choose_script = toggle_allowcontroller}
	add_generic_menu_text_item \{text = $debug_mode_text
		pad_choose_script = ui_debug_mode_toggle}
	menu_finish
endscript

script show_wii_fps
	if ($fps_hidden = 1)
		Change fps_hidden = 0
	elseif ($fps_hidden = 0)
		Change fps_hidden = 1
	endif
endscript

script ui_no_fail_toggle
	if ($no_fail = 0)
		Change no_fail = 1
		change \{debug_forcescore = good}
		SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change no_fail = 0
		change \{debug_forcescore = off}
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script ui_black_highway_toggle
	if ($black_highway = 0)
		Change black_highway = 1
		Change highway_normal = [0 0 0 255]
		Change highway_starpower = [0 0 0 255]
	 	SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change black_highway = 0
		Change highway_normal = [255 255 255 255]
		Change highway_starpower = [64 255 255 255]
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script ui_debug_mode_toggle
	if ($enable_button_cheats = 0)
		Change enable_button_cheats = 1
		SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change enable_button_cheats = 0
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script ui_black_background_toggle
	if ($black_background = 0)
		Change black_background = 1
		SoundEvent \{Event = CheckBox_Check_SFX}
	else
		Change black_background = 0
		SoundEvent \{Event = CheckBox_SFX}
	endif
endscript

script toggle_allowcontroller 
	if ($allow_controller_for_all_instruments = 1)
		change \{allow_controller_for_all_instruments = 0}
		SoundEvent \{Event = CheckBox_SFX}
	else
		change \{allow_controller_for_all_instruments = 1}
		SoundEvent \{Event = CheckBox_Check_SFX}
	endif
	toggle_allowcontroller_setprop
endscript

ui_motd_camera = {
	params = {
		pos = (-28.0003, -0.28645402, 3.453506)
		Quat = (-0.00375, 0.9962319, 0.064155)
	}
	time = 0.35000002
	TransitionDOF = $DOF_CloseUp02_tod_manager
	dof = $DOF_UIblur_tod_manager
}

script ui_destroy_downloads 
	generic_ui_destroy
endscript