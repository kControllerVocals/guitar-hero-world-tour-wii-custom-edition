gh_songlist = [
	rebelyell
	jamsession
	DrumStreamTest
	synctest
	synctestplaytoaudio
	synctestaudioandvisual
	synctestmuting
	tenseconddebug
	elevenseconddebug
	twelveseconddebug
	testtones
	Tut_Bass_OpenNote
	Tut_Demo
	Tut_Drum_Activ
	Tut_Drum_Beat1
	Tut_Drum_Beat2
	Tut_Drum_Beat3
	Tut_Drum_Break
	Tut_Drum_Combos
	Tut_Drum_Free
	Tut_Drum_Kick
	Tut_Drum_OneHand
	Tut_Drum_TwoHands
	Tut_Gtr_Chords
	Tut_Gtr_Combos
	Tut_Gtr_DiffNotes
	Tut_Gtr_ExtSus
	Tut_Gtr_HamOn
	Tut_Gtr_LongNotes
	Tut_Gtr_PlayNotes
	Tut_Gtr_PullOff
	Tut_Gtr_Slide
	Tut_Gtr_Tilt
	Tut_Gtr_Wham
	Tut_Vox_Activ
	Tut_Vox_Combos
	Tut_Vox_Freeform
	Tut_Vox_HitNotes
	Tut_Vox_Hype
	Tut_Vox_Spoken
	Tut_VS_BattPow
	Tut_VS_MultAttck
	Tut_VS_Recov
	Tut_VS_Tilt
	PlaceHolderSong
]
final_credits_song = PullMeUnder
download_songlist = [
]
download_songlist_props = {
}
gh_songlist_props = {
	$download_songlist_props
	$permanent_songlist_props
	$jamsession_songlist_props
}
artist_text_by = qs("BY")
artist_text_from = qs("FROM")
artist_text_as_made_famous_by = qs("AS MADE FAMOUS BY")
jamsession_songlist_props = {
	jamsession = {
		checksum = jamsession
		name = 'jamsession'
		title = qs("\LJam Session")
		year = qs("\L, 2008")
		year_num = 2008
		artist_text = $artist_text_by
		original_artist = 1
		leaderboard = 1
		singer = Male
		genre = Rock
		countoff = 'hihat01'
		saved_in_globaltags = 0
	}
}
permanent_songlist_props = {

}

script get_song_original_artist \{song = invalid}
	return
endscript

script get_song_title \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_title = ($gh_songlist_props.<song>.title)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_prefix \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_prefix = ($gh_songlist_props.<song>.name)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_name \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_name = ($gh_songlist_props.<song>.name)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_artist \{song = invalid
	return
endscript

script get_song_artist_text \{song = invalid}
	return
endscript
Perf2_Settings = [
	{
		song = stillborn
		mode = p1_career
		char_type = vocalist
		char_id = ZakkWylde
	}
	{
		song = Today
		mode = p1_career
		char_type = vocalist
		char_id = Billy
	}
	{
		song = DemolitionMan
		mode = p1_career
		char_type = vocalist
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p1_career
		char_type = Bass
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p2_career
		char_type = vocalist
		char_id = ZakkWylde
	}
	{
		song = Today
		mode = p2_career
		char_type = vocalist
		char_id = Billy
	}
	{
		song = DemolitionMan
		mode = p2_career
		char_type = vocalist
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p2_career
		char_type = Bass
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p3_career
		char_type = vocalist
		char_id = ZakkWylde
	}
	{
		song = Today
		mode = p3_career
		char_type = vocalist
		char_id = Billy
	}
	{
		song = DemolitionMan
		mode = p3_career
		char_type = vocalist
		char_id = RandomCharacter
	}
	{
		song = stillborn
		mode = p3_career
		char_type = Bass
		char_id = RandomCharacter
	}
]

script get_song_performance 
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) performance
			if ($gh_songlist_props.<song>.performance = 1)
				performance = 0
				get_band_name song = <song>
				singing_guitarist = false
				if has_singing_guitarist Band = <Band>
					singing_guitarist = true
				elseif has_singing_bassist Band = <Band>
					singing_guitarist = true
				endif
				if (<singing_guitarist> = true)
					if (($<Band>.vocalist = Jimi) && ($current_num_players = 1))
						performance = 1
					else
						if NOT is_any_player_on_part \{part = Vocals}
							performance = 1
						endif
					endif
				endif
				printf channel = Band qs("\Lusing performance %a") a = (<performance> + 1)
				return song_performance = <performance>
			else
				return song_performance = ($gh_songlist_props.<song>.performance - 1)
			endif
		else
			return \{song_performance = 0}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script is_any_player_on_part 
	GameMode_GetNumPlayersShown
	player = 1
	begin
	FormatText checksumname = player_status 'player%i_status' i = <player> AddToStringLookup
	if ($<player_status>.part = <part>)
		return \{true}
	endif
	player = (<player> + 1)
	repeat <num_players_shown>
	return \{false}
endscript

script get_song_struct \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		return song_struct = ($gh_songlist_props.<song>)
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_songlist_size 
	GetArraySize \{$gh_songlist}
	size = (<array_size>)
	if GlobalExists \{name = GH4_download_songlist
			type = array}
		GetArraySize \{$GH4_download_songlist}
		size = (<array_size> + <size>)
	endif
	return array_size = <size>
endscript

script get_songlist_checksum 
	GetArraySize \{$gh_songlist}
	if (<index> < <array_size>)
		return song_checksum = ($gh_songlist [<index>])
	else
		return song_checksum = ($GH4_download_songlist [(<index> - <array_size>)])
	endif
endscript

script is_song_downloaded \{song_checksum = schoolsout}
	if StructureContains Structure = ($download_songlist_props) <song_checksum>
		FormatText TextName = filename 'a%s_song.pak' s = (($download_songlist_props.<song_checksum>).name)
		GetContentFolderIndexFromFile <filename>
		if (<device> = content)
			return \{download = 1
				true}
		else
			return \{download = 1
				false}
		endif
	else
		return \{download = 0
			true}
	endif
endscript

script get_song_rhythm_track \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) rhythm_track
			return rhythm_track = ($gh_songlist_props.<song>.rhythm_track)
		else
			return \{rhythm_track = 0}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_saved_in_globaltags \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) saved_in_globaltags
			return saved_in_globaltags = ($gh_songlist_props.<song>.saved_in_globaltags)
		else
			return \{saved_in_globaltags = 1}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript

script get_song_allowed_in_quickplay \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) allowed_in_quickplay
			return allowed_in_quickplay = ($gh_songlist_props.<song>.allowed_in_quickplay)
		else
			return \{allowed_in_quickplay = 1}
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
current_song_version = gh4

script get_song_version \{song = invalid}
	if StructureContains Structure = $gh_songlist_props <song>
		if StructureContains Structure = ($gh_songlist_props.<song>) version
			return song_version = ($gh_songlist_props.<song>.version)
		else
			return song_version = ($current_song_version)
		endif
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
drum_kit_types = {
	heavyrock = 0
	classicrock = 1
}

script get_song_drum_kit_index \{song = invalid}
	if ($current_song = jamsession)
		return drum_kit_type = ($drum_kits [0].string_id) drum_kit_index = 0
	endif
	if StructureContains Structure = $gh_songlist_props <song>
		drum_kit_type = ($gh_songlist_props.<song>.drum_kit)
		GetArraySize ($drum_kits)
		drum_kit_index = 0
		begin
		if (<drum_kit_type> = $drum_kits [<drum_kit_index>].string_id)
			break
		endif
		drum_kit_index = (<drum_kit_index> + 1)
		repeat <array_size>
		if (<drum_kit_index> >= <array_size>)
			printscriptinfo \{qs("get_song_drum_kit_index")}
			ScriptAssert \{qs("\LDrum Kit Type not found")}
		endif
		return drum_kit_type = <drum_kit_type> drum_kit_index = <drum_kit_index>
	endif
	printstruct <...>
	ScriptAssert \{qs("\LSong not found")}
endscript
