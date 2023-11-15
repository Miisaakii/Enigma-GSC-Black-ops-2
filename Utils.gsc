//Functions GSC

init() 
{
    if( !(getdvar( "mapname" ) == "mp_takeoff")getdvar( "mapname" ) == "mp_takeoff" || getdvar( "mapname" ) == "mp_studio" || getdvar( "mapname" ) == "mp_hydro" || getdvar( "mapname" ) == "mp_magma" || getdvar( "mapname" ) == "mp_uplink" || getdvar( "mapname" ) == "mp_concert" )
	{
		level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
		level._effect["flak20_fire_fx"] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
		level._effect["fx_mp_carrier_signal_lights"] = loadfx( "maps/mp_maps/fx_mp_carrier_signal_lights" );
		level.redlightfx = loadfx( "misc/fx_equip_light_red" );
		level.waypointred = loadfx( "misc/fx_equip_tac_insert_light_red" );
		level.waypointgreen = loadfx( "misc/fx_equip_tac_insert_light_grn" );
		level._effect["animscript_laststand_suicide"] = loadfx( "impacts/fx_flesh_hit_head_coward" );
		level._effect["ChafFx"] = loadfx( "weapon/straferun/fx_straferun_chaf" );
		level._effect["CmKsLelWater"] = loadfx( "system_elements/fx_snow_sm_em" );
		level._effect["koth"] = loadfx( "maps/mp_maps/fx_mp_koth_marker_neutral_1" );
		level.remote_mortar_fx["laserTarget"] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_laser_loop" );
		level._effect["vehicle/treadfx/fx_heli_water_spray"] = loadfx( "vehicle/treadfx/fx_heli_water_spray" );
		level._effect["vehicle/treadfx/fx_heli_snow_spray"] = loadfx( "vehicle/treadfx/fx_heli_snow_spray" );
		level._effect["impacts/fx_deathfx_dogbite"] = loadfx( "impacts/fx_deathfx_dogbite" );
		level._effect["quadrotor_nudge"] = loadfx( "weapon/qr_drone/fx_qr_drone_impact_sparks" );
		level._effect["GlassFx"] = loadfx( "impacts/fx_large_glass" );
		level._effect["LeafFx"] = loadfx( "impacts/fx_small_foliage" );
		level._effect["LeafFx2"] = loadfx( "explosions/fx_exp_equipment_lg" );
		level._effect["LeafFx3"] = loadfx( "weapon/emp/fx_emp_explosion_equip" );
		level._effect["LeafFx4"] = loadfx( "weapon/emp/fx_emp_explosion_equip" );
		level._effect["DaFireFx"] = loadfx( "weapon/talon/fx_muz_talon_rocket_flash_1p" );
		level._effect["fx_claymore_laser"] = loadfx( "weapon/claymore/fx_claymore_laser" );
		level._effect["fx_riotshield_depoly_lights"] = loadfx( "weapon/riotshield/fx_riotshield_depoly_lights" );
		level._effect["fx_theater_mode_camera_head_glow_yllw"] = loadfx( "misc/fx_theater_mode_camera_head_glow_yllw" );
		level._effect["vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm"] = loadfx( "vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm" );
		level._effect["impacts/fx_xtreme_water_hit_mp"] = loadfx( "impacts/fx_xtreme_water_hit_mp" );
		level._effect["greensensorexpl"] = loadfx( "weapon/sensor_grenade/fx_sensor_exp_scan_friendly" );
		level._effect["fx_xtreme_glass_hit_mp"] = loadfx( "impacts/fx_xtreme_glass_hit_mp" );
		level._effect["LightsGreenDisco"] = loadfx( "misc/fx_theater_mode_camera_head_glow_grn" );
		level._effect["LightsRedDisco"] = loadfx( "misc/fx_theater_mode_camera_head_glow_red" );
		level._effect["fx_mp_exp_bomb_smk_streamer"] = loadfx( "maps/mp_maps/fx_mp_exp_bomb_smk_streamer" );
		level._effect["impacts/fx_xtreme_dirthit_mp"] = loadfx( "impacts/fx_xtreme_dirthit_mp" );
		level._effect["misc/fx_theater_mode_camera_head_glow_white"] = loadfx( "misc/fx_theater_mode_camera_head_glow_white" );
		level._effect["impacts/fx_xtreme_mud_mp"] = loadfx( "impacts/fx_xtreme_mud_mp" );
		level._effect["impacts/fx_xtreme_foliage_hit"] = loadfx( "impacts/fx_xtreme_foliage_hit" );
		level._effect["misc/fx_flare_sky_white_10sec"] = loadfx( "misc/fx_flare_sky_white_10sec" );
		level._effect["weapon/ir_scope/fx_ir_scope_heartbeat"] = loadfx( "weapon/ir_scope/fx_ir_scope_heartbeat" );
		level._effect["lens_flares/fx_lf_mp_common_texture_reserve"] = loadfx( "lens_flares/fx_lf_mp_common_texture_reserve" );
	}
	
	precacheshader( "lui_loader_no_offset" );
	precacheshader( "compass_emp" );
	precacheshader( "black" );
	precacheshader( "ui_slider2" );
	precacheshader( "line_horizontal" );
	precacheshader( "hud_mp_vis_ks_dpad_box_back_lit" );
	precacheshader( "hud_mp_vis_ks_dpad_box" );
	precacheshader( "overlay_low_health" );
	precacheshader( "white" );
	precacheshader( "extracam2d" );
	precacheshader( "fullscreen_proximity_vertical0" );
	precacheshader( "fullscreen_proximity_vertical1" );
	precacheshader( "fullscreen_proximity_vertical2" );
	precacheshader( "fullscreen_proximity_horizontal0" );
	precacheshader( "fullscreen_proximity_horizontal1" );
	precacheshader( "net_new_animation" );
	
	if( getdvar( "mapname" ) == "mp_nuketown_2020" )
	{
		precachemodel( "p6_computer_monitor_2020_broken" );
		precachemodel( "p6_computer_base_2020" );
		precachemodel( "nt_2020_streetlight_01" );
		precachemodel( "mlv/nt_2020_vista_ufo_01" );
		precachemodel( "nt_2020_foliage_hedge_boxy_3_set" );
		precachemodel( "mlv/nt_2020_robot_shed" );
		precachemodel( "mp_nuketown_2020_vista_bldg_01" );
		precachemodel( "nt_nuketown_sign_topper" );
		precachemodel( "mlv/nt_2020_tour_bus" );
		precachemodel( "p_rus_mountain_desert_b" );
		precachemodel( "mlv/nt_2020_vista_arch" );
		precachemodel( "mlv/nt_concrete_fence_320_tall_dog_02" );
		precachemodel( "mlv/nt_tree_ficus_lrg_01" );
		precachemodel( "nt_nuketown_sign_topper" );
		precachemodel( "veh_t6_nuketown_2020_car02_whole" );
		precachemodel( "veh_t6_nuketown_2020_car01_whole" );
		precachemodel( "mlv/nt_tree_ficus_lrg_01" );
		precachemodel( "p_rus_mountain_desert_b" );
		precachemodel( "c_usa_mp_seal6_sniper_fb" );
		precachemodel( "nt_2020_robot_01" );
		precachemodel( "collision_clip_wall_128x128x10" );
		precachemodel( "mlv/nt_concrete_fence_straight_skinny" );
		precachemodel( "mlv/nt_2020_robot_shed" );
		precachemodel( "mp_nuketown_2020_light_post" );
		precachemodel( "nt_sign_population" );
		precachemodel( "nt_sign_population_vcs" );
		precachemodel( "dest_nt_nuked_male_01_d0" );
		precachemodel( "dest_nt_nuked_female_01_d0" );
		precachemodel( "dest_nt_nuked_male_03_d0" );
		precachemodel( "dest_nt_nuked_female_05_d0" );
		precachemodel( "veh_t6_nuketown_2020_car01_whole" );
		precachemodel( "veh_t6_nuketown_2020_car02_whole" );
		precachemodel( "nt_2020_doorframe_black" );
		
		if( getdvar( "mapname" ) == "mp_nuketown_2020" )
		{
			precachemodel( "dub_rest_vase_alone" );
			precachemodel( "nt_2020_house_02_balcony" );
			precachemodel( "com_water_tank2" );
			precachemodel( "nt_2020_foliage_hedge_boxy01" );
			precachemodel( "nt_nuketown_sign" );
			precachemodel( "p_rus_mountain_desert_b" );
			precachemodel( "nt_nuketown_sign_topper" );
			precachemodel( "mlv/nt_tree_ficus_lrg_01_sway" );
			precachemodel( "mlv/nt_tree_ficus_lrg_01" );
			precachemodel( "nt_2020_glass_table" );
			precachemodel( "nt_2020_mattress_small" );
			precachemodel( "nt_2020_greenhouse_plant_01" );
			precachemodel( "nt_2020_sculpture_01" );
			precachemodel( "nt_concrete_fence_post_tall02" );
			precachemodel( "nt_rag_doll_blond" );
			precachemodel( "nt_2020_globe" );
			precachemodel( "nt_sign_population" );
			precachemodel( "nt_2020_green_chair" );
			precachemodel( "nt_concrete_fence_post_tall02" );
			precachemodel( "nt_2020_wood_table" );
			precachemodel( "nt_2020_swing_set" );
			precachemodel( "nt_2020_bookshelf_03" );
			precachemodel( "veh_t6_nuketown_2020_car02_whole" );
			precachemodel( "veh_t6_nuketown_2020_car01_whole" );
			precachemodel( "nt_2020_robot_01" );
			precachemodel( "p6_computer_monitor_2020_broken" );
			precachemodel( "p6_computer_base_2020" );
			precachemodel( "nt_2020_streetlight_01" );
			precachemodel( "mlv/nt_2020_vista_ufo_01" );
			precachemodel( "nt_2020_foliage_hedge_boxy_3_set" );
			precachemodel( "mlv/nt_2020_robot_shed" );
			precachemodel( "mp_nuketown_2020_vista_bldg_01" );
			precachemodel( "nt_nuketown_sign_topper" );
			precachemodel( "mlv/nt_2020_tour_bus" );
			precachemodel( "p_rus_mountain_desert_b" );
			precachemodel( "mlv/nt_2020_vista_arch" );
			precachemodel( "mlv/nt_concrete_fence_320_tall_dog_02" );
			precachemodel( "mlv/nt_tree_ficus_lrg_01" );
			precachemodel( "nt_nuketown_sign_topper" );
			precachemodel( "veh_t6_nuketown_2020_car02_whole" );
			precachemodel( "veh_t6_nuketown_2020_car01_whole" );
			precachemodel( "mlv/nt_tree_ficus_lrg_01" );
			precachemodel( "p_rus_mountain_desert_b" );
			precachemodel( "c_usa_mp_seal6_sniper_fb" );
			precachemodel( "nt_2020_robot_01" );
			precachemodel( "collision_clip_wall_128x128x10" );
			precachemodel( "mlv/nt_concrete_fence_straight_skinny" );
			precachemodel( "mlv/nt_2020_robot_shed" );
			precachemodel( "mp_nuketown_2020_light_post" );
			precachemodel( "nt_sign_population" );
			precachemodel( "nt_sign_population_vcs" );
			precachemodel( "dest_nt_nuked_male_01_d0" );
			precachemodel( "dest_nt_nuked_female_01_d0" );
			precachemodel( "dest_nt_nuked_male_03_d0" );
			precachemodel( "dest_nt_nuked_female_05_d0" );
			precachemodel( "veh_t6_nuketown_2020_car01_whole" );
			precachemodel( "veh_t6_nuketown_2020_car02_whole" );
			precachemodel( "nt_2020_doorframe_black" );
			precachemodel( "nt_2020_flag_treyarch_01" );
			precachemodel( "dest_nt_nuked_female_02_d0" );
			precachemodel( "dest_nt_nuked_female_02_dO" );
			precachemodel( "dest_nt_nuked_male_02_d0" );
			precachemodel( "dest_nt_nuked_male_02_dO" );
			precachemodel( "mp_nuketown_2020_light_post" );
			precachemodel( "nt_nuketown_sign_topper" );
			precachemodel( "nt_2020_streetligth_01" );
			precachemodel( "nt_2020_grill" );
			precachemodel( "mlv/nt_2020_truck_01" );
		}
		
		if( getdvar( "mapname" ) == "mp_drone" )
		{
			precachemodel( "p6_strangler_fig_tree_no_vines_sway" );
			precachemodel( "p6_tree_angel_oak_moss_no_vines_sway" );
			precachemodel( "t5_foliage_bush06" );
			precachemodel( "p6_door_automatic_mp_drone" );
			precachemodel( "berlin_me_dumpster_close_green" );
			precachemodel( "p6_dockside_container_lrg_orange" );
			precachemodel( "t5_foliage_tree_aquilaria01v2" );
			precachemodel( "mlv/p6_rocks_boulder_02_jungle_nospec_vista" );
			precachemodel( "fxanim_gp_robot_arm_suction_mod" );
			precachemodel( "p6_barrier_pedestrian" );
			precachemodel( "p6_barrel_green" );
			precachemodel( "c_chn_mp_pla_shotgun_fb" );
			precachemodel( "p6_dockside_container_lrg_orange" );
			precachemodel( "p6_door_automatic_mp_drone" );
			precachemodel( "berlin_me_dumpster_close_green" );
			precachemodel( "t5_foliage_treewall_large" );
			precachemodel( "p6_boat_cargo_ship_empty" );
			precachemodel( "t5_foliage_plants_tropic09" );
			precachemodel( "t5_foliage_bush06" );
			precachemodel( "veh_t6_drone_overwatch_light" );
			precachemodel( "veh_t6_drone_tank" );
			precachemodel( "veh_t6_drone_rcxd" );
			precachemodel( "veh_t6_drone_cuav" );
			precachemodel( "veh_t6_drone_uav" );
			precachemodel( "veh_t6_drone_supply" );
			precachemodel( "veh_t6_drone_quad_rotor_mp" );
		}
		
		if( getdvar( "mapname" ) == "mp_socotra" )
		{
			precachemodel( "t6_wpn_supply_drop_ally" );
			precachemodel( "t6_wpn_supply_drop_axis" );
			precachemodel( "t6_wpn_supply_drop_trap" );
			precachemodel( "t5_vehicle_tiara_whole_brown" );
			precachemodel( "p6_street_vendor_goods_table02" );
			precachemodel( "veh_t6_civ_car_compact" );
			precachemodel( "fxanim_gp_cloth_sheet_med03_mod" );
			precachemodel( "veh_t6_civ_car_compact" );
			precachemodel( "fxanim_yemen_cloth_canopy07_lrg_mod" );
			precachemodel( "fxanim_yemen_cloth_canopy08_lrg_mod" );
		}
		
		if( getdvar( "mapname" ) == "mp_express" )
		{
			precachemodel( "p6_bullet_train_car" );
			precachemodel( "p6_bullet_train_engine_rev" );
			precachemodel( "p6_bullet_train_car" );
		}
		
		if( getdvar( "mapname" ) == "mp_la" )
		{
			precachemodel( "veh_t6_police_car_destructible" );
			precachemodel( "veh_iw_civ_firetruck" );
			precachemodel( "veh_iw_civ_ambulance_whole" );
			precachemodel( "veh_iw_civ_suv_whole_red" );
			precachemodel( "veh_iw_civ_suv_whole_black" );
			precachemodel( "veh_iw_civ_suv_whole_beige" );
			precachemodel( "veh_t6_police_car_destructible" );
		}
		
		if( getdvar( "mapname" ) == "mp_village" )
		{
			precachemodel( "veh_t6_civ_van_sprinter_whole" );
			precachemodel( "veh_t6_civ_truck_radiant_white_mp" );
			precachemodel( "veh_t6_civ_van_sprinter_whole" );
			precachemodel( "veh_t6_civ_car_compact_red" );
			precachemodel( "veh_iw_tank_t72_static_body" );
			precachemodel( "veh_t6_civ_sportscar_whole_silver" );
			precachemodel( "veh_t6_civ_sportscar_whole_yellow" );
		}
		
		if( getdvar( "mapname" ) == "mp_overflow" )
		{
			precachemodel( "com_pallet_2" );
			precachemodel( "mlv/p6_building_facade_pak_arch01" );
			precachemodel( "p6_overflow_vista_bldg_single_003" );
			precachemodel( "veh_t6_civ_car_compact_bge_mud_mp" );
			precachemodel( "veh_t6_van_pakistan_mp" );
			precachemodel( "p6_construction_woodplankpile_01" );
			precachemodel( "ch_crate48x64" );
			precachemodel( "p6_building_sign_pakistan01" );
			precachemodel( "p6_building_sign_pakistan02" );
			precachemodel( "p6_building_sign_pakistan06" );
			precachemodel( "p6_chair_damaged_panama" );
			precachemodel( "p_rus_rollup_door_136" );
		}
		
		if( getdvar( "mapname" ) == "mp_hijacked" )
		{
			precachemodel( "collision_clip_wall_128x128x10" );
			precachemodel( "collision_clip_wall_512x512x10" );
			precachemodel( "collision_clip_wall_256x256x10" );
		}
		
		if( getdvar( "mapname" ) == "mp_raid" )
		{
			precachemodel( "collision_clip_wall_128x128x10" );
			precachemodel( "collision_clip_wall_512x512x10" );
			precachemodel( "collision_clip_wall_256x256x10" );
		}
		
		if( getdvar( "mapname" ) == "mp_slums" )
		{
			precachemodel( "collision_clip_wall_128x128x10" );
			precachemodel( "collision_clip_wall_512x512x10" );
			precachemodel( "collision_clip_wall_256x256x10" );
		}
		
		if( getdvar( "mapname" ) == "mp_dockside" )
		{
			precachemodel( "p6_dock_cargo_crane_vista" );
			precachemodel( "p6_dock_cargo_crane_vista_up" );
			precachemodel( "p6_boat_cargo_ship_empty" );
			precachemodel( "p6_crate_crane_top_rails" );
			precachemodel( "p6_gantry_container_crane_vista" );
		}
	}
	
    level thread onplayerconnect();
}

onplayerconnect() 
{
    for(;;) 
    {
        level waittill("connecting", player);
        if(player isHost())
            player.status = "Host";
        else
            player.status = "Unverified";

        player thread onplayerspawned();
    }
}

onplayerspawned() 
{
    self endon("disconnect");
    level endon("game_ended");

    self.MenuInit = false;

    for(;;) {
        self waittill("spawned_player");
        if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified") 
        {
            if(!self.MenuInit) 
            {
                self.MenuInit = true;
                self thread MenuInit();
                self thread closeMenuOnDeath();
                notifyData = spawnstruct();
                notifyData.titleText = "^1Hello ^5" + level.hostname + " ^6Welcome to ^1Enigma v1.0";
                notifyData.notifyText = "^7Your Status : " + verificationToColor(self.status);
                self iprintln("");
                self iprintln("");
                notifyData.glowColor = (0.36, 0.14, 1);
                notifyData.duration = 11;
                notifyData.font = "hudbig";
                notifyData.hideWhenInMenu = false;
                self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
                self freezecontrols(false);
                self iprintln("Welcome to ^1Enigma");
                self iprintln("Version ^1V1.2");
                self iprintln("Menu made by ^1AimMisaki");
                self iprintln("aim + knife to open the menu.");
            }
        }
    }
}





