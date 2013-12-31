printl("versus single");

// need refactoring. use MutationState etc..

DEBUG_MODE <- false;

function debug_print(msg, chat = true)
{
	if (DEBUG_MODE) {
		if (chat) {
			Say(null, msg, false);
		} else {
			printl(msg);
		}
	}
}
function debug_print_table(table)
{
	if (DEBUG_MODE) {
		DeepPrintTable(table);
	}
}

DirectorOptions <-
{
	ActiveChallenge = 1
	cm_ShouldHurry = true
	SpecialInfectedAssault = 1
	cm_AggressiveSpecials = 1
	cm_DominatorLimit = 3
	cm_SpecialRespawnInterval = 1
	SpecialRespawnInterval = 1
	SpecialInitialSpawnDelayMin = 1
	SpecialInitialSpawnDelayMax = 1
	ShouldAllowSpecialsWithTank = true
	ShouldAllowMobsWithTank = false
	FallenSurvivorSpawnChance = 0
	ZombieTankHealth = 2000
	WitchLimit = 0
	BehindSurvivorsSpawnDistance = 500
	
	weaponsToRemove = 
	{
		weapon_defibrillator = 0
		weapon_grenade_launcher = 0
		weapon_upgradepack_incendiary = 0
		weapon_upgradepack_explosive = 0
		weapon_chainsaw = 0
		weapon_propanetank = 0
		weapon_oxygentank = 0
		weapon_rifle_m60 = 0
		upgrade_item = 0
		weapon_pipe_bomb = 0
		weapon_vomitjar = 0
		weapon_molotov = 0
	}
	weaponsToConvert =
	{
		weapon_first_aid_kit 	= "weapon_pain_pills_spawn"
		weapon_autoshotgun	  	= "weapon_pumpshotgun_spawn"
		weapon_shotgun_spas	 	= "weapon_shotgun_chrome_spawn"
		weapon_rifle 			= "weapon_smg_silenced_spawn"
		weapon_rifle_desert	 	= "weapon_smg_silenced_spawn"
		weapon_rifle_sg552		= "weapon_smg_silenced_spawn"
		weapon_rifle_ak47		= "weapon_smg_silenced_spawn"
		weapon_smg_mp5			= "weapon_smg_silenced_spawn"
		weapon_sniper_military	= "weapon_hunting_rifle_spawn"
		weapon_sniper_awp		= "weapon_hunting_rifle_spawn"
		weapon_sniper_scout		= "weapon_hunting_rifle_spawn"
	}
	
	botAvoidItems = 
	{
		// bots take only smg
		weapon_hunting_rifle = true
		weapon_shotgun_chrome = true
		weapon_pumpshotgun = true
	}
	defaultItems =
	[
		"weapon_pistol",
		"weapon_smg",
	]
	
	function ConvertWeaponSpawn( classname )
	{
		if ( classname in weaponsToConvert )
		{
			return weaponsToConvert[classname];
		}
		return 0;
	}
	function ShouldAvoidItem( classname )
	{
		if ( classname in botAvoidItems )
		{
			return true;
		}
		return false;
	}
	function AllowWeaponSpawn( classname )
	{
		if ( classname in weaponsToRemove )
		{
			return false;
		}
		return true;
	}
	function GetDefaultItem( idx )
	{
		if ( idx < defaultItems.len() )
		{
			return defaultItems[idx];
		}
		return 0;
	}
}

function force_set_cvar()
{
	// shit! cvar in mode-file does not apply on developer mode!
	
	Convars.SetValue("sb_open_fire", 0);
	Convars.SetValue("sb_unstick", 1);
	
	Convars.SetValue("sv_pausable", 1);
	Convars.SetValue("mp_autoteambalance", 0);
	Convars.SetValue("sb_all_bot_game", 1);
	Convars.SetValue("allow_all_bot_survivor_team", 1);
	Convars.SetValue("survivor_limit", 4);
	Convars.SetValue("z_max_player_zombies", 4);
	Convars.SetValue("vs_max_team_switches", 99);
	Convars.SetValue("vs_survival_bonus", 25);
	Convars.SetValue("vs_tiebreak_bonus", 25);
	Convars.SetValue("nb_update_frequency", 0.033);
	Convars.SetValue("director_vs_convert_pills", 0);
	Convars.SetValue("director_convert_pills", 0);
	Convars.SetValue("director_convert_pills_critical_health", 0);
	Convars.SetValue("director_convert_pills_to_defib_health", 0);
	Convars.SetValue("versus_force_start_time", 40);
	
	Convars.SetValue("sb_allow_leading", 1);
	Convars.SetValue("sb_allow_shoot_through_survivors", 1);
	Convars.SetValue("sb_sidestep_for_horde", 1);
	Convars.SetValue("sb_friendlyfire", 0);
	Convars.SetValue("sb_close_checkpoint_door_interval", 0.5);
	Convars.SetValue("sb_friend_immobilized_reaction_time_vs", 0.25);
	Convars.SetValue("sb_combat_saccade_speed", 2000);
	Convars.SetValue("sb_normal_saccade_speed", 2000);
	Convars.SetValue("sb_temp_health_consider_factor", 0.6);
	Convars.SetValue("sb_max_team_melee_weapons", 3);
	Convars.SetValue("sb_threat_far_range", 800);
	Convars.SetValue("sb_threat_medium_range", 600);
	Convars.SetValue("sb_separation_range", 300);
	
	
	Convars.SetValue("versus_special_respawn_interval", 33);
	Convars.SetValue("z_mob_spawn_min_size", 25);
	Convars.SetValue("z_mob_spawn_max_size", 25);
	Convars.SetValue("z_fallen_max_count", 0);
	Convars.SetValue("sv_infected_ceda_vomitjar_probability", 0);
	Convars.SetValue("z_mob_spawn_min_interval_normal", 100);
	Convars.SetValue("z_mob_spawn_max_interval_normal", 100);
	Convars.SetValue("z_ghost_delay_min", 1);
	Convars.SetValue("z_ghost_delay_max", 1);
	Convars.SetValue("gascan_spit_time", 2);
	Convars.SetValue("versus_tank_chance_intro", 1);
	Convars.SetValue("versus_tank_chance_finale", 1);
	Convars.SetValue("versus_tank_chance", 1);
	Convars.SetValue("versus_tank_flow_team_variation", 0);
	Convars.SetValue("versus_witch_chance", 0);
	Convars.SetValue("versus_witch_chance_finale", 0);
	Convars.SetValue("versus_witch_chance_intro", 0);
	Convars.SetValue("versus_boss_flow_max", 0.9);
	Convars.SetValue("versus_boss_flow_max_intro", 0.9);
	Convars.SetValue("versus_boss_flow_min", 0.15);
	Convars.SetValue("versus_boss_flow_min_intro", 0.15);
	Convars.SetValue("tank_stuck_time_suicide", 120);
	Convars.SetValue("director_tank_lottery_selection_time", 3);
	Convars.SetValue("versus_boss_padding_min", 0.0);
	Convars.SetValue("versus_boss_padding_max", 0.0);
	Convars.SetValue("z_witch_damage_per_kill_hit", 75);
	Convars.SetValue("z_witch_personal_space", 240);
	Convars.SetValue("z_leap_interval_post_incap", 15);
	Convars.SetValue("z_jockey_control_variance", 0.15);
	Convars.SetValue("z_tank_attack_interval", 2.0);
	Convars.SetValue("z_scrimmage_creep_delay", 0);
	Convars.SetValue("z_scrimmage_creep_rate", 100);
	Convars.SetValue("z_spawn_safety_range", 200);
	Convars.SetValue("z_safe_spawn_range", 200);
	Convars.SetValue("tongue_miss_delay", 3);
	Convars.SetValue("tongue_hit_delay", 15);
	Convars.SetValue("tongue_dropping_to_ground_time", 0.5);
	Convars.SetValue("tongue_los_forgiveness_time", 1.5);
	Convars.SetValue("tongue_no_progress_choke_early_delay", 1.0);
	Convars.SetValue("z_pounce_stumble_radius", 160);
	Convars.SetValue("z_pounce_damage_interrupt", 150);
	Convars.SetValue("z_hunter_limit", 1);
	Convars.SetValue("z_smoker_limit", 1);
	Convars.SetValue("z_max_stagger_duration", 0.9);
	Convars.SetValue("z_ghost_los_expected_progress", 2000);
	Convars.SetValue("tongue_choke_damage_amount", 5);
	Convars.SetValue("tongue_break_from_damage_amount", 300);
}

// charger monitors

g_chargers <- {}
function unset_charge(id)
{
	if (id in g_chargers) {
		g_chargers[id] = false;
	}
}
function set_charge(id)
{
	g_chargers[id] <- true;
}
function is_charging(id)
{
	return ((id in g_chargers) && g_chargers[id]);
}

// game event handlers
ZC_SMOKER <- 1
ZC_BOOMER <- 2
ZC_HUNTER <- 3
ZC_SPITTER <- 4
ZC_JOCKEY <- 5
ZC_CHARGER <- 6
ZC_WITCH <- 7
ZC_TANK <- 8

g_player_survivor <- false
g_player_first_spawn <- false
g_bot_start <- false
g_bot_start_time <- 0
g_all_bot_survivor_team <- false
g_round_end <- false

BOT_STOP_DELAY <- 20.0
g_round_end <- false;

function OnGameEvent_round_start( params )
{
	g_round_end <- false;
	debug_print("round start");
	force_set_cvar();
	reset_triggers();
	reset_bot_target();
	si_reset();
	remove_entity();
	Convars.SetValue("sb_stop", 1);
	g_bot_start = false;
	g_bot_start_time = Time() + BOT_STOP_DELAY;
}
function OnGameEvent_round_end(params)
{
	g_round_end <- true;
	debug_print("round end");
}
function OnGameEvent_charger_charge_start( params )
{
	set_charge(params.userid);
}

function OnGameEvent_charger_charge_end( params )
{
	unset_charge(params.userid);
}

g_map_name <- null;
function OnGameEvent_player_first_spawn( params)
{
	local player = GetPlayerFromUserID(params.userid);
	if (player && player.IsPlayer() && !player.IsSurvivor() && IsPlayerABot(player) && player.GetZombieType() != ZC_TANK) {
		si_bot_spawned(player);
	}
	if (!g_map_name) {
		g_map_name = params.map_name;
		debug_print(format("--- map: %s", g_map_name));
	}
	if (player && player.IsPlayer() && IsPlayerABot(player) && !player.IsSurvivor() && player.GetZombieType() != ZC_TANK) {
		g_si_pos[params.userid] <- player.GetOrigin();
		g_si_pos_check_time[params.userid] <- Time();
	}
}

function takecontrol(player)
{
	client_command(player, "jointeam 3", 1.0);
	client_command(player, "jointeam 2", 1.01);
	client_command(player, "jointeam 2", 1.1);
	client_command(player, "jointeam 2", 2.1);
}

function OnGameEvent_player_death( params )
{
	if ("userid" in params) {
		unset_charge(params.userid);
		local player = GetPlayerFromUserID(params.userid);
		if (params.userid in g_si_pos) {
			g_si_pos[params.userid] <- null;
			g_si_pos_check_time[params.userid] <- null;
		}
		if (player.IsSurvivor() && !IsPlayerABot(player) && !g_round_end) {
			local bots = survivor_bots();
			if (bots.len() > 0) {
				Say(null, "try takecontrol", false);
				takecontrol(player);
			}
		}
	}
}

function OnGameEvent_player_hurt( params )
{
	local player = GetPlayerFromUserID(params.userid);
	if (("attackerentid" in params) && player && player.IsPlayer() && player.IsSurvivor()) {
		local attacker = GetPlayerFromUserID(params.attackerentid);
		g_bot_hurt_time = Time();
		if (attacker && attacker.IsPlayer() && !attacker.IsSurvivor() && attacker.GetZombieType() == ZC_TANK) {
			g_bot_hurt_tank_time = Time();
		} else if (!(attacker && attacker.IsPlayer() && attacker.IsSurvivor())) {
			g_bot_hurt_without_tank_time = Time();
		}
	}
	if (("attackerentid" in params) && player && player.IsPlayer() && !player.IsSurvivor() && player.GetZombieType() != ZC_TANK && IsPlayerABot(player)) {
		si_bot_hurt(player);
	}
}

DMG_BOT_TANK <- 12.0
DMG_BOT_TANK_CAR <- 30.0
function AllowTakeDamage( damageTable )
{
	local attacker = damageTable.Attacker;
	local victim = damageTable.Victim;
	if ( attacker
		&& victim
		&& victim.IsPlayer()
		&& !victim.IsSurvivor()
		&& attacker.IsPlayer()
		&& attacker.IsSurvivor()
		&& IsPlayerABot(victim))
	{
		// special infected bot
		local victim_id = victim.GetPlayerUserId();
		// charger damage fix
		if (victim.GetZombieType() == ZC_CHARGER && is_charging(victim_id)) {
			damageTable.DamageDone = damageTable.DamageDone * 3.0;
		}
	}
	if (victim && victim.IsPlayer() && victim.IsSurvivor() && IsPlayerABot(victim)) {
		// survivor bot
		if (damageTable.DamageDone > 1.0) {
			if (attacker && attacker.IsPlayer() && !attacker.IsSurvivor() && attacker.GetZombieType() == ZC_TANK) {
				// tank
				if (damageTable.DamageDone >= 99.0) {
					// car
					damageTable.DamageDone = DMG_BOT_TANK_CAR;
				} else {
					damageTable.DamageDone = DMG_BOT_TANK;
				}
			} else if (g_all_bot_survivor_team && attacker && attacker.IsPlayer() && !attacker.IsSurvivor()) {
				// all bot team
				damageTable.DamageDone = damageTable.DamageDone * 0.8;
			}
			if (damageTable.DamageDone < 1.0) {
				damageTable.DamageDone = 1.0;
			}
			if (g_bot_move_target) {
				damageTable.DamageDone = 1.0;
			}
		}
	}
	return true;
}

NEAR_RADIUS <- 200;
NEAR_ALL_RADIUS <- 400;
function near_survivor_bot(target_pos, all = false)
{
	local bots = survivor_bots()
	if (all) {
		local count = 0;
		local near = 0;
		foreach (bot in bots) {
			if (bot && !bot.IsDead()) {
				local pos = bot.GetOrigin();
				if ((pos - target_pos).Length() < NEAR_ALL_RADIUS) {
					near += 1;
				}
				count += 1;
			}
		}
		return count == near;
	} else {
		foreach (bot in bots) {
			if (bot && !bot.IsDead()) {
				local pos = bot.GetOrigin();
				if ((pos - target_pos).Length() < NEAR_RADIUS) {
					return true;
				}
			}
		}
		return false;
	}
}

function survivor_bots()
{
	local bots = {};
	local i = 0;
	local bot = null;
	
	while (bot = Entities.FindByClassname(bot, "player")) {
		if (bot && bot.IsSurvivor() && IsPlayerABot(bot) && !bot.IsDead()) {
			bots[i++] <- bot;
		}
	}
	return bots;
}

function all_bot_team()
{
	local bot = null;
	while (bot = Entities.FindByClassname(bot, "player")) {
		if (bot && bot.IsSurvivor() && !IsPlayerABot(bot)) {
			return false;
		}
	}
	return true;
}

function bot_flow_distance()
{
	local bots = survivor_bots();
	local dist = 0;
	foreach (bot in bots) {
		dist += GetCurrentFlowDistanceForPlayer(bot);
	}
	if (bots.len() > 0) {
		return dist / bots.len();
	}
	return 0;
}

g_c1m2_trigger1 <- false;
g_c1m2_trigger2 <- false;
g_c1m2_trigger3 <- false;
g_c1m3_trigger1 <- false;
g_c1m3_trigger2 <- false;
g_c1m3_trigger3 <- false;
g_c1m4_gascans <- null;
g_c1m4_escape <- false;
g_c1m4_scavenge_start <- false;
g_c2m3_trigger1 <- false;
g_c2m5_trigger1 <- false;
g_c2m5_trigger2 <- false;
g_c2m5_trigger_pos1 <- false;
g_c2m5_trigger_pos2 <- false;
g_c6m2_trigger1 <- false;
g_c6m2_trigger2 <- false;
g_c6m3_gascans <- null;
g_c6m3_escape <- false;
g_c6m3_scavenge_start <- false;
g_c7m1_trigger1 <- false;
g_c7m1_trigger1_time <- 0;
g_c7m1_trigger2 <- false;
g_c7m1_trigger3 <- false;
g_c7m1_trigger4 <- false;
g_c7m2_trigger1 <- false;
g_c7m3_trigger1 <- false;
g_c7m3_trigger2 <- false;
g_c7m3_trigger3 <- false;
g_c7m3_trigger4 <- false;
g_c7m3_trigger4_time <- 0;
g_c7m3_trigger5 <- false;
g_c8m2_trigger1 <- false;
g_c8m2_trigger1_time <- 0;
g_c8m2_trigger2 <- false;
g_c8m4_trigger1 <- false;
g_c8m4_trigger1_time <- 0;
g_c8m4_trigger2 <- false;
g_c8m5_trigger1 <- false;
g_c9m1_trigger1 <- false;
g_c9m1_trigger1_time <- 0;
g_c9m1_trigger2 <- false;
g_c9m2_trigger1 <- false;
g_c10m2_trigger1 <- false;
g_c10m3_trigger1 <- false;
g_c10m4_trigger1 <- false;
g_c10m5_trigger1 <- false;
g_c11m2_trigger1 <- false;
g_c11m2_trigger1_time <- 0;
g_c11m2_trigger2 <- false;
g_c11m3_trigger1 <- false;
g_c11m4_trigger1 <- false;
g_c11m5_trigger1 <- false;
g_c11m5_trigger2 <- false;
g_c3m1_trigger1 <- false;
g_c3m1_trigger1_time <- 0;
g_c3m1_trigger2 <- false;
g_c3m3_trigger1 <- false;
g_c3m3_trigger2 <- false;
g_c3m3_trigger2_time <- 0;
g_c3m3_trigger3 <- false;
g_c4m2_trigger1 <- false;
g_c4m2_trigger1_time <- false;
g_c4m2_trigger2 <- false;
g_c4m2_trigger3 <- false;
g_c12m2_trigger1 <- false;
g_c12m3_trigger1 <- false;
g_c12m3_trigger2 <- false;
g_c13m1_trigger1 <- false;
g_c13m2_trigger1 <- false;
g_c13m2_trigger2 <- false;
g_c13m2_trigger3 <- false;
g_c13m4_trigger1 <- false;
g_c13m4_trigger2 <- false;

function reset_triggers()
{
	g_c1m2_trigger1 = false;
	g_c1m2_trigger2 = false;
	g_c1m2_trigger3 = false;
	g_c1m3_trigger1 = false;
	g_c1m3_trigger2 = false;
	g_c1m3_trigger3 = false;
	g_c1m4_gascans = null;
	g_c1m4_escape = false;
	g_c1m4_scavenge_start = false;
	g_c2m3_trigger1 = false;
	g_c2m5_trigger1 = false;
	g_c2m5_trigger2 = false;
	g_c2m5_trigger_pos1 = false;
	g_c2m5_trigger_pos2 = false;
	g_c6m2_trigger1 = false;
	g_c6m2_trigger2 = false;
	g_c6m3_gascans = null;
	g_c6m3_escape = false;
	g_c6m3_scavenge_start = false;
	g_c7m1_trigger1 = false;
	g_c7m1_trigger2 = false;
	g_c7m1_trigger1_time = 0;
	g_c7m1_trigger3 = false;
	g_c7m1_trigger4 = false;
	g_c7m2_trigger1 = false;
	g_c7m3_trigger2 = false;
	g_c7m3_trigger3 = false;
	g_c7m3_trigger4 = false;
	g_c7m3_trigger5 = false;
	g_c7m3_trigger4_time = 0;
	g_c8m2_trigger1 = false;
	g_c8m2_trigger2 = false;
	g_c8m2_trigger1_time =0;
	g_c8m4_trigger1 = false;
	g_c8m4_trigger2 = false;
	g_c8m4_trigger1_time =0;
	g_c8m5_trigger1 = false;
	g_c9m1_trigger1 = false;
	g_c9m1_trigger1_time = 0;
	g_c9m1_trigger2 = false;
	g_c9m2_trigger1 = false;
	g_c10m2_trigger1 = false;
	g_c10m3_trigger1 = false;
	g_c10m4_trigger1 = false;
	g_c10m5_trigger1 = false;
	g_c11m2_trigger1 = false;
	g_c11m2_trigger1_time = false;
	g_c11m2_trigger2 = false;
	g_c11m3_trigger1 = false;
	g_c11m4_trigger1 = false;
	g_c3m1_trigger1 = false;
	g_c3m1_trigger1_time = false;
	g_c3m1_trigger2 = false;
	g_c3m3_trigger1 = false;
	g_c3m3_trigger2 = false;
	g_c3m3_trigger2_time = 0;
	g_c3m3_trigger3 = false;
	g_c4m2_trigger1 = false;
	g_c4m2_trigger1_time = false;
	g_c4m2_trigger2 = false;
	g_c4m2_trigger3 = false;
	g_c12m2_trigger1 = false;
	g_c12m3_trigger1 = false;
	g_c12m3_trigger2 = false;
	g_c13m1_trigger1 = false;
	g_c13m2_trigger1 = false;
	g_c13m2_trigger2 = false;
	g_c13m2_trigger3 = false;
	g_c13m4_trigger1 = false;
	g_c13m4_trigger2 = false;
	g_si_pos <- {}
	g_si_pos_check_time <- {}
}

/* limited */
function client_command(player, command, delay = 0.01)
{
	local ent = Entities.FindByClassname(null, "point_clientcommand");
	if (!ent) {
		ent = CreateSingleSimpleEntityFromTable({classname = "point_clientcommand", targetname = "versus_single_clientcommand"});
		debug_print("created point_clientcommand");
	}
	DoEntFire("!self", "Command", command, delay, player, ent);
	debug_print(format("exec command %s", command));
}

function get_remote_pills()
{
	local bots = survivor_bots();
	local i = 0;
	local health_avg = 0.0;
	
	if (bots.len() == 0) {
		return;
	}
	
	foreach (bot in bots) {
		// need GetWeaponSlot..
		health_avg += bot.GetHealth() + bot.GetHealthBuffer();
	}
	health_avg /= bots.len();
	if (health_avg < 45.0) {
		local pills = null;
		while (pills = Entities.FindByClassname(pills, "weapon_pain_pills_spawn")) {
			if (bots.len() > i) {
				DoEntFire("!self", "Use", "", 0.0, bots[i++], pills);
				Say(null, "bot got a remote pills", false);
			}
		}
	}
}

function auto_trigger()
{
	if (!g_all_bot_survivor_team) {
		return;
	}
	
	if (g_map_name == "c1m2_streets") {
		local door_pos = Vector(-6627, -2499, 454);
		local cola_pos = Vector(-7375, -1338, 467);
		local unstick_pos = Vector(-5744, -811, 510);
		
		if (!g_c1m2_trigger1 && bot_flow_distance() > 21929) {
			set_bot_target(door_pos);
			if (near_survivor_bot(door_pos)) {
				local door =  Entities.FindByName(null, "store_doors");
				if (door) {
					Say(null, "c1m2 trigger1", false);
					DoEntFire("!self", "Open", "", 0, null, door);
				}
				set_bot_target(cola_pos, BOT_MOVE_TYPE_HURRY);
				g_c1m2_trigger1 = true;
			}
		}
		if (g_c1m2_trigger1 && !g_c1m2_trigger2) {
			set_bot_target(cola_pos, BOT_MOVE_TYPE_HURRY);
			if (near_survivor_bot(cola_pos)) {
				local bots =  survivor_bots();
				if (bots.len() > 0) {
					Say(null, "c1m2 trigger2", false);
					DoEntFire("tanker_destroy_relay", "Trigger", "", 0, bots[0], bots[0]);
				}
				reset_bot_target();
				g_c1m2_trigger2 = true;
			}
		}
		if (g_c1m2_trigger2 && !g_c1m2_trigger3) {
			set_bot_target(unstick_pos);
			if (near_survivor_bot(unstick_pos)) {
				Say(null, "c1m2 trigger3", false);
				reset_bot_target();
				g_c1m2_trigger3 = true;
			}
		}
	}
	if (g_map_name == "c1m3_mall") {
		local dist = bot_flow_distance();
		local unstick_pos1 = Vector(1840, -2603, 598);
		local unstick_pos2 = Vector(-801, -4678, 598);
		
		get_remote_pills();
		
		if (!g_c1m3_trigger1) {
			if (dist > 14800) {
				Convars.SetValue("sb_open_fire", 0);
				Say(null, "c1m3 trigger1", false);
				g_c1m3_trigger1 = true;
			} else if (dist > 13700) {
				Convars.SetValue("sb_open_fire", 1);
			}
		}
		if (g_c1m3_trigger1 && !g_c1m3_trigger2) {
			set_bot_target(unstick_pos1, BOT_MOVE_TYPE_HURRY);
			if (near_survivor_bot(unstick_pos1, true)) {
				reset_bot_target();
				g_c1m3_trigger2 = true;
				Say(null, "c1m3 trigger2", false);
			}
		}
		if (!g_c1m3_trigger3 && dist > 24100) {
			set_bot_target(unstick_pos2, BOT_MOVE_TYPE_HURRY);
			if (near_survivor_bot(unstick_pos2, true)) {
				reset_bot_target();
				g_c1m3_trigger3 = true;
				Say(null, "c1m3 trigger3", false);
			}
		}
	}
	if (g_map_name == "c1m4_atrium") {
		get_remote_pills();
		
		if (bot_flow_distance() > 3842) {
			g_c1m4_scavenge_start = true;
		}
		if (near_survivor_bot(Vector(-4015, -3410, 597))) {
			local button = Entities.FindByName(null, "button_elev_3rdfloor");
			if (button) {
				Say(null, "try c1m4 trigger1", false);
				DoEntFire("!self", "Press", "", 0, null, button);
			}
		}
		if (g_c1m4_scavenge_start && !g_c1m4_escape) {
			local bots = survivor_bots();
			local target_gascan = null;
			local touched_count = 0;
			local bot_pos = null;
			
			if (bots.len() == 0) {
				return;
			}
			bot_pos = bots[0].GetOrigin();
			
			if (!g_c1m4_gascans) {
				local ent = null;
				local i = 0;
				
				g_c1m4_gascans = {};
				while((ent = Entities.FindByClassname(ent, "weapon_gascan")) != null) {
					g_c1m4_gascans[i++] <- { ent = ent, pos = ent.GetOrigin(), touched = false };
				}
			}
			foreach (gascan in g_c1m4_gascans) {
				if (!gascan.touched) {
					if (target_gascan == null) {
						target_gascan = gascan;
					}
					// else if ((bot_pos.z - target_gascan.pos.z) * (bot_pos.z - target_gascan.pos.z) >= (bot_pos.z - gascan.pos.z) * (bot_pos.z - gascan.pos.z)) {
					//	target_gascan = gascan;
					//}
				} else {
					touched_count += 1;
				}
			}
			if (touched_count >= 8) {
				DoEntFire("relay_car_ready", "Trigger", "", 0, bots[0], bots[0]);
				reset_bot_target();
				Say(null, "c1m4 trigger2", false);
				g_c1m4_escape = true;
			} else if (target_gascan) {
				set_bot_target(target_gascan.pos);
				if (near_survivor_bot(target_gascan.pos)) {
					local pick_bot = null;
					foreach (bot in bots) {
						local weapon = bot.GetActiveWeapon();
						if (weapon.GetClassname() != "weapon_gascan") {
							pick_bot = bot;
							break;
						}
					}
					if (pick_bot) {
						DoEntFire("!self", "Use", "", 0, pick_bot, target_gascan.ent);
						EntFire("info_director", "IncrementTeamScore", "2", 0.5);
						target_gascan.touched = true;
						Say(null, format("bot got a gascan [%d/8]", touched_count + 1), false);
					}
				}
			}
		}
	}
	if (g_map_name == "c2m3_coaster") {
		get_remote_pills();
		
		if (!g_c2m3_trigger1) {
			if (near_survivor_bot(Vector(-2994, 1687, 61))) {
				local button = Entities.FindByName(null, "minifinale_button");
				if (button) {
					Say(null, "c2m3 trigger", false);
					DoEntFire("!self", "Press", "", 0, null, button);
				}
				g_c2m3_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c2m5_concert") {
		local trigger_pos1 = Vector(-2291, 2091, 190);
		local trigger_pos2 = Vector(-1855, 3344, -113);
		local camp_pos = Vector(-2794, 2363, 142);
		//local camp_pos = Vector(-2264, 3358, -113);
		local bots = survivor_bots();
		
		get_remote_pills();
		
		if (!g_c2m5_trigger_pos1 && !g_c2m5_trigger1 && bot_flow_distance() > 3800) {
			set_bot_target(trigger_pos1, BOT_MOVE_TYPE_HURRY);
			if (near_survivor_bot(trigger_pos1)) {
				local button = Entities.FindByName(null, "stage_lights_button");
				if (button) {
					Say(null, "c2m5 trigger1", false);
					DoEntFire("!self", "Press", "", 0, null, button);
				}
				//debug_print("near target1");
				reset_bot_target();
				g_c2m5_trigger1 = true;
				g_c2m5_trigger_pos1 = true;
			}
		}
		if (g_c2m5_trigger1 && !g_c2m5_trigger2 && !g_c2m5_trigger_pos2) {
			set_bot_target(trigger_pos2);
			if (near_survivor_bot(trigger_pos2)) {
				local button = Entities.FindByName(null, "stage_escape_button");
				if (button) {
					Say(null, "c2m5 trigger2", false);
					foreach (bot in bots) {
						DoEntFire("stage_escape_button", "Use", "", 1, bot, bot);
					}
				}
				reset_bot_target();
				g_c2m5_trigger2 = true;
				g_c2m5_trigger_pos2 = true;
			}
		}
		if (g_c2m5_trigger2) {
			set_bot_target(camp_pos);
		}
	}
	if (g_map_name == "c5m2_park") {
		if (near_survivor_bot(Vector(-9597, -5952, -151))) {
			local door1 = Entities.FindByName(null, "finale_cleanse_entrance_door");
			local door2 = Entities.FindByName(null, "finale_cleanse_exit_door");
			if (door1) {
				Say(null, "try c5m2 trigger1", false);
				DoEntFire("!self", "Close", "", 0, null, door1);
			}
			if (door2) {
				Say(null, "try c5m2 trigger2", false);
				DoEntFire("!self", "Open", "", 3, null, door2);
			}
		}
	}
	if (g_map_name == "c5m5_bridge") {
		if (near_survivor_bot(Vector(-11429, 6518, 522))) {
			local button = Entities.FindByName(null, "finale");
			if (button) {
				local bots = survivor_bots();
				if (bots.len() > 0) {
					Say(null, "try c5m5 trigger", false);
					DoEntFire("finale", "Use", "", 0, bots[0], bots[0]);
				}
			}
		}
	}
	if (g_map_name == "c6m2_bedlam") {
		if (!g_c6m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 4444) {
				local unstick_pos = Vector(167, 2064, -89);
				set_bot_target(unstick_pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(unstick_pos, true)) {
					reset_bot_target();
					Say(null, "try c6m2 trigger1", false);
					g_c6m2_trigger1 = true;
				}
			}
		}
		/*
		if (g_c6m2_trigger1 && !g_c6m2_trigger2) {
			local dist = bot_flow_distance();
			if (dist > 24900) {
				local unstick_pos = Vector(4776, 5725, -1001);
				set_bot_target(unstick_pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(unstick_pos, false)) {
					reset_bot_target();
					Say(null, "c6m2 trigger2", false);
					g_c6m2_trigger2 = true;
				}
			}
		}
		*/
	}
	if (g_map_name == "c6m3_port") {
		local dist = bot_flow_distance();
		
		get_remote_pills();
		
		if (!g_c6m3_scavenge_start && near_survivor_bot(Vector(-751, -584, 382))) {
			local button = Entities.FindByName(null, "generator_elevator_button");
			if (button) {
				DoEntFire("!self", "Press", "", 0, null, button);
				Say(null, "try c6m3 trigger1", false);
			}
		}
		if (dist > 3800) {
			g_c6m3_scavenge_start = true;
		}
		if (g_c6m3_scavenge_start && !g_c6m3_escape) {
			local bots = survivor_bots();
			local target_gascan = null;
			local touched_count = 0;
			local bot_pos = null;
			
			if (bots.len() == 0) {
				return;
			}
			bot_pos = bots[0].GetOrigin();
			
			if (!g_c6m3_gascans) {
				local ent = null;
				local i = 0;
				
				g_c6m3_gascans = {};
				while((ent = Entities.FindByClassname(ent, "weapon_gascan")) != null) {
					g_c6m3_gascans[i++] <- { ent = ent, pos = ent.GetOrigin(), touched = false };
				}
			}
			foreach (gascan in g_c6m3_gascans) {
				if (!gascan.touched) {
					if (target_gascan == null) {
						target_gascan = gascan;
					}
					// else if ((bot_pos.z - target_gascan.pos.z) * (bot_pos.z - target_gascan.pos.z) >= (bot_pos.z - gascan.pos.z) * (bot_pos.z - gascan.pos.z)) {
					//	target_gascan = gascan;
					//}
				} else {
					touched_count += 1;
				}
			}
			if (touched_count >= 10) {
				DoEntFire("relay_car_ready", "Trigger", "", 0, bots[0], bots[0]);
				reset_bot_target();
				Say(null, "c6m3 trigger2", false);
				g_c6m3_escape = true;
			} else if (target_gascan) {
				set_bot_target(target_gascan.pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(target_gascan.pos)) {
					local pick_bot = null;
					foreach (bot in bots) {
						local weapon = bot.GetActiveWeapon();
						if (weapon.GetClassname() != "weapon_gascan") {
							pick_bot = bot;
							break;
						}
					}
					if (pick_bot) {
						DoEntFire("!self", "Use", "", 0, pick_bot, target_gascan.ent);
						EntFire("info_director", "IncrementTeamScore", "2", 0.5);
						target_gascan.touched = true;
						Say(null, format("bot got a gascan [%d/10]", touched_count + 1), false);
					}
				}
			}
		}
	}
	if (g_map_name == "c8m2_subway") {
		if (!g_c8m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 11000) {
				local pos = Vector(7316, 3291, 78);
				set_bot_target(pos);
				if (near_survivor_bot(pos)) {
					local camp_pos = Vector(7678, 4115, 78);
					local button = Entities.FindByClassname(null, "func_button");
					if (button) {
						local bots = survivor_bots();
						if (bots.len() > 0) {
							DoEntFire("!self", "Use", "", 0, bots[0], button);
						}
					}
					Say(null, "c8m2 trigger1", false);
					set_bot_target(camp_pos);
					g_c8m2_trigger1_time = Time();
					g_c8m2_trigger1 = true;
				}
			}
		}
		if (g_c8m2_trigger1 && !g_c8m2_trigger2) {
			if (Time() > g_c8m2_trigger1_time + 30.0) {
				Say(null, "c8m2 trigger2", false);
				reset_bot_target();
				g_c8m2_trigger2 = true;
			}
		}
	}
	if (g_map_name == "c8m4_interior") {
		if (!g_c8m4_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 8200) {
				local pos = Vector(13491, 15062, 486);
				set_bot_target(pos);
				if (near_survivor_bot(pos)) {
					local camp_pos = Vector(11936, 14823, 486);
					local button = null;
					local bots = survivor_bots();
					if (bots.len() > 0) {
						while (button = Entities.FindByClassname(button, "func_button")) {
							DoEntFire("!self", "Use", "", 0, bots[0], button);
						}
					}
					Say(null, "c8m4 trigger1", false);
					set_bot_target(camp_pos);
					g_c8m4_trigger1_time = Time();
					g_c8m4_trigger1 = true;
				}
			}
		}
		if (g_c8m4_trigger1 && !g_c8m4_trigger2) {
			if (Time() > g_c8m4_trigger1_time + 65.0) {
				Say(null, "c8m4 trigger2", false);
				reset_bot_target();
				g_c8m4_trigger2 = true;
			}
		}
		if (g_c8m4_trigger2 && near_survivor_bot(Vector(13516, 15202, 487))) {
			local button = null;
			local bots = survivor_bots();
			if (bots.len() > 0) {
				while (button = Entities.FindByClassname(button, "func_button")) {
					DoEntFire("!self", "Use", "", 0, bots[0], button);
					//Say(null, "try c8m4 trigger3", false);
				}
			}
		}
	}
	if (g_map_name == "c8m5_rooftop") {
		get_remote_pills();
		
		if (!g_c8m5_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 5900) {
				local button = Entities.FindByName(null, "radio_button");
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 0, bots[0], button);
					}
				} else {
					Say(null, "c8m5 trigger1", false);
					g_c8m5_trigger1 = true;
				}
			}
		}
		if (g_c8m5_trigger1) {
			local button = Entities.FindByName(null, "radio");
			if (button) {
				local bots = survivor_bots();
				if (bots.len() > 0) {
					DoEntFire("!self", "Use", "", 0, bots[0], button);
				}
			}
		}
	}
	if (g_map_name == "c9m1_alleys") {
		if (!g_c9m1_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 18240) {
				local pos = Vector(-1304, -6491, 58);
				set_bot_target(pos);
				if (near_survivor_bot(pos)) {
					local button = Entities.FindByName(null, "fire_howitzer");
					if (button) {
						DoEntFire("!self", "Press", "", 0, null, button);
					}
					Say(null, "c9m1 trigger1", false);
					g_c9m1_trigger1 = true;
					g_c9m1_trigger1_time = Time();
				}
			}
		}
		if (g_c9m1_trigger1 && !g_c9m1_trigger2) {
			local pos = Vector(-2272, -6218, 170);
			set_bot_target(pos);
			if (Time() > g_c9m1_trigger1_time + 60.0) {
				reset_bot_target();
				Say(null, "c9m1 trigger2", false);
				g_c9m1_trigger2 = true;
			}
		}
	}
	if (g_map_name == "c9m2_lots") {
		get_remote_pills();
		if (!g_c9m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 18000) {
				local pos = Vector(6846, 5941, 104);
				set_bot_target(pos);
				if (near_survivor_bot(pos)) {
					local button = Entities.FindByName(null, "finaleswitch_initial");
					if (button) {
						// ref: L4D2 Stripper Dumps
						EntFire("finaleswitch_initial", "Kill", "", 0);
						EntFire("finale_lever", "Enable", "", 5);
						EntFire("radio_game_event_pre", "Kill", "", 0);
						EntFire("radio_game_event", "GenerateGameEvent", 0);
						EntFire("sound_generator_start", "StopSound", "", 0);
						EntFire("generator_start_particles", "Start", "", 0);
						EntFire("generator_light_switchable", "TurnOn", "", 0);
						EntFire("generator_lights", "LightOn", "", 0);
						EntFire("sound_generator_run", "PlaySound", "", 0);
						//EntFire("orator", "SpeakResponseConcept", "CrashFinaleGeneratorOn WhoDidIt:!Activator", 0.1);
						EntFire("lift_switch_spark", "SparkOnce", "", 1);
						EntFire("lift_lever", "SetDefaultAnimation", "IDLE_DOWN", 0.1);
						EntFire("lift_lever", "SetAnimation", "DOWN", 0);
						EntFire("lift_spark02", "SparkOnce", "", 0);
						EntFire("lift_spark01", "SparkOnce", "", 0);
						EntFire("radio_game_event", "Kill", "", 0);
						EntFire("survivalmode_exempt", "Trigger", "", 0);
						EntFire("generator_break_timer", "Enable", "", 0);
						EntFire("finale_lever", "ForceFinaleStart", "", 5);
						EntFire("generator_hint", "EndHint", "", 0);
						EntFire("survival_start_relay", "Trigger", "", 0);
						
						Say(null, "c9m2 trigger1", false);
						reset_bot_target();
						g_c9m2_trigger1 = true;
					}
				}
			}
		}
		// 1 trigger if single game
	}
	if (g_map_name == "c10m2_drainage") {
		if (!g_c10m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 6044) {
				local button = Entities.FindByName(null, "button_minifinale");
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 1, bots[0], button);
						Say(null, "c10m2 trigger1", false);
					}
				}
				g_c10m2_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c10m3_ranchhouse") {
		if (!g_c10m3_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 12200) {
				local unstick_pos = Vector(-6903, -1879, 70);
				set_bot_target(unstick_pos);
				if (near_survivor_bot(unstick_pos, true)) {
					reset_bot_target();
					Say(null, "c10m3 trigger1", false);
					g_c10m3_trigger1 = true;
				}
			}
		}
	}
	if (g_map_name == "c10m4_mainstreet") {
		if (!g_c10m4_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 12855) {
				local button = Entities.FindByName(null, "button");
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 1, bots[0], button);
						Say(null, "c10m4 trigger1", false);
					}
				}
				g_c10m4_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c10m5_houseboat") {
		
		get_remote_pills();
		
		if (!g_c10m5_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 10498) {
				local button = Entities.FindByName(null, "radio_button");
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 0, bots[0], button);
					}
				} else {
					Say(null, "c10m5 trigger1", false);
					g_c10m5_trigger1 = true;
				}
			}
		}
		if (g_c10m5_trigger1) {
			local button = Entities.FindByName(null, "radio");
			if (button) {
				local bots = survivor_bots();
				if (bots.len() > 0) {
					DoEntFire("!self", "Use", "", 0, bots[0], button);
				}
			}
		}
	}
	if (g_map_name == "c7m1_docks") {
		if (!g_c7m1_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 12400) {
				local button = Entities.FindByName(null, "tankdoorin_button");
				if (button) {
					// ref: L4D2 Stripper Dumps
					EntFire("tankdoorin_button", "UnLock", "", 0);
					EntFire("versus_tank", "Trigger", "", 0);
					EntFire("tankdoorin", "Open", "", 5);
					EntFire("tankdoorin_button", "Kill", "", 5);
					EntFire("tank_sound_timer", "Disable", "", 5);
					EntFire("panic_event_relay", "Trigger", "", 5);
					EntFire("doorsound", "PlaySound", "", 5);
					EntFire("tank_fog", "Enable", "", 5);
					EntFire("tank_fog", "Disable", "", 5 + 0.5);
					EntFire("big_splash", "Stop", "", 5+2);
					//EntFire("coop_tank", "Trigger", "", 5);
					EntFire("big_splash", "Start", "", 5);
					EntFire("radio_game_event", "Kill", "", 5);
					EntFire("tank_door_clip", "Kill", "", 5);
					EntFire("director", "EnableTankFrustration", "", 5);
					EntFire("battlefield_cleared", "UnblockNav", "", 5 + 60);
					EntFire("tank_car_camera_clip", "Kill", "", 5);
					Say(null, "c7m1 trigger1", false);
				}
				g_c7m1_trigger1_time = Time();
				g_c7m1_trigger1 = true;
			}
		}
		if (g_c7m1_trigger1 && !g_c7m1_trigger2 && Time() > g_c7m1_trigger1_time + 10.0 && !has_tank()) {
			local button = Entities.FindByName(null, "tankdoorout_button");
			if (button) {
				// ref: L4D2 Stripper Dumps
				EntFire("tankdoorout_button", "UnLock", "", 0);
				EntFire("tankdoorout", "Open", "", 0);
				EntFire("tankdoorout_button", "Kill", "", 0);
				EntFire("battlefield_cleared", "UnblockNav", "", 0);
				Say(null, "c7m1 trigger2", false);
			}
			g_c7m1_trigger2 = true;
		}
		if (g_c7m1_trigger2 && !g_c7m1_trigger3) {
			local unstick_pos = Vector(6835, 470, 229);
			set_bot_target(unstick_pos, BOT_MOVE_TYPE_HURRY);
			if (near_survivor_bot(unstick_pos, true)) {
				reset_bot_target();
				Say(null, "c7m1 trigger3", false);
				g_c7m1_trigger3 = true;
			}
		}
		if (!g_c7m1_trigger4) {
			local dist = bot_flow_distance();
			if (dist > 21000) {
				local unstick_pos = Vector(4739, 672, 238);
				set_bot_target(unstick_pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(unstick_pos, true)) {
					reset_bot_target();
					Say(null, "c7m1 trigger4", false);
					g_c7m1_trigger4 = true;
				}
			}
		}
	}
	if (g_map_name == "c7m2_barge") {
		if (!g_c7m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 21140) {
				local unstick_pos = Vector(-5403, 465, 643);
				set_bot_target(unstick_pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(unstick_pos, true)) {
					reset_bot_target();
					Say(null, "c7m2 trigger1", false);
					g_c7m2_trigger1 = true;
				}
			}
		}
	}
	if (g_map_name == "c7m3_port") {
		local dist = bot_flow_distance();
		
		get_remote_pills();
		
		if (!g_c7m3_trigger1 && dist > 3292) {
			local button = Entities.FindByName(null, "finale_start_button");
			if (button) {
				local pos = button.GetOrigin();
				set_bot_target(pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(pos)) {
					EntFire("finale_start_button", "Kill", "", 0);
					EntFire("sound_generator_start", "StopSound", "", 0);
					EntFire("sound_generator_run", "PlaySound", "", 0);
					EntFire("generator_start_particles", "Start", "", 0);
					EntFire("generator_model2", "StopGlowing", "", 0);
					EntFire("radio_game_event_pre", "Kill", "", 0);
					EntFire("mob_spawner_finale", "Enable", "", 0);
					EntFire("generator2_tankmessage_templated", "Kill", "", 0);
					EntFire("relay_advance_finale_state", "Trigger", "", 2);
					Say(null, "c7m3 trigger1", false);
				}
			} else {
				reset_bot_target();
				g_c7m3_trigger1 = true;
			}
		}
		if (g_c7m3_trigger1 && !g_c7m3_trigger2) {
			local button = Entities.FindByName(null, "finale_start_button1");
			if (button) {
				local pos = button.GetOrigin();
				set_bot_target(pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(pos)) {
					EntFire("finale_start_button1", "Kill", "", 0);
					EntFire("sound_generator_start1", "StopSound", "", 0);
					EntFire("sound_generator_run1", "PlaySound", "", 0);
					EntFire("generator_start_particles1", "Start", "", 0);
					EntFire("generator_model1", "StopGlowing", "", 0);
					EntFire("mob_spawner_finale", "Enable", "", 0);
					EntFire("relay_advance_finale_state", "Trigger", "", 2);
					EntFire("radio_game_event_pre1", "Kill", "", 0);
					Say(null, "c7m3 trigger2", false);
				}
			} else {
				reset_bot_target();
				g_c7m3_trigger2 = true;
			}
		}
		if (g_c7m3_trigger2 && !g_c7m3_trigger3) {
			local button = Entities.FindByName(null, "finale_start_button2");
			if (button) {
				local pos = button.GetOrigin();
				set_bot_target(pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(pos)) {
					EntFire("finale_start_button2", "Kill", "", 0);
					EntFire("sound_generator_start2", "StopSound", "", 0);
					EntFire("sound_generator_run2", "PlaySound", "", 0);
					EntFire("generator_start_particles2", "Start", "", 0);
					EntFire("generator_model3", "StopGlowing", "", 0);
					EntFire("mob_spawner_finale", "Enable", "", 0);
					EntFire("generator3_tankmessage_templated", "Kill", "", 0);
					EntFire("relay_advance_finale_state", "Trigger", "", 2);
					EntFire("radio_game_event_pre2", "Kill", "", 0);
					Say(null, "c7m3 trigger3", false);
				}
			} else {
				reset_bot_target();
				g_c7m3_trigger3 = true;
			}
		}
		if (g_c7m3_trigger3 && !g_c7m3_trigger4) {
			local button = Entities.FindByName(null, "bridge_start_button");
			if (button) {
				local pos = button.GetOrigin();
				set_bot_target(pos, BOT_MOVE_TYPE_HURRY);
				if (near_survivor_bot(pos)) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 0, bots[0], button);
						Say(null, "c7m3 trigger4", false);
					}
					reset_bot_target();
					g_c7m3_trigger4 = true;
					g_c7m3_trigger4_time = Time();
				}
			}
		}
		if (g_c7m3_trigger4 && !g_c7m3_trigger5 && Time() > g_c7m3_trigger4_time + 60.0) {
			local bots = survivor_bots();
			if (bots.len() > 0) {
				EntFire("generator_final_button_relay", "Trigger", "", 0, bots[0]);
				g_c7m3_trigger5 = true;
				Say(null, "c7m3 trigger5", false);
			}
		}
	}
	if (g_map_name == "c11m2_offices") {
		if (!g_c11m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 6300 && !has_tank()) {
				local button = Entities.FindByName(null, "crane button");
				local camp_pos = Vector(5903, 3672, 584);
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 1, bots[0], button);
						Say(null, "c11m2 trigger1", false);
					}
				}
				set_bot_target(camp_pos);
				g_c11m2_trigger1 = true;
				g_c11m2_trigger1_time = Time();
			}
		}
		if (g_c11m2_trigger1 && !g_c11m2_trigger2 && Time() > g_c11m2_trigger1_time + 60.0) {
			Say(null, "c11m2 trigger2", false);
			reset_bot_target();
			g_c11m2_trigger2 = true;
		}
	}
	if (g_map_name == "c11m3_garage") {
		if (!g_c11m3_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 4300) {
				local gascan = Entities.FindByName(null, "barricade_gas_can");
				if (gascan) {
					DoEntFire("!self", "Ignite", "", 0, null, gascan);
					Say(null, "c11m3 trigger1", false);
				}
				g_c11m3_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c11m4_terminal") {
		if (!g_c11m4_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 6300) {
				local button = Entities.FindByName(null, "van_button");
				if (button) {
					DoEntFire("!self", "Press", "", 0, null, button);
					Say(null, "c11m4 trigger1", false);
				}
				g_c11m4_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c11m5_runway") {
		
		get_remote_pills();
		
		if (!g_c11m5_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 2800) {
				local button = Entities.FindByName(null, "radio_fake_button");
				local bots = survivor_bots();
				if (bots.len() > 0 && button) {
					DoEntFire("!self", "Use", "", 0, bots[0], button);
					Say(null, "c11m5 trigger1", false);
				}
				g_c11m5_trigger1 = true;
			}
		}
		if (g_c11m5_trigger1) {
			local button = Entities.FindByName(null, "radio");
			local bots = survivor_bots();
			if (bots.len() > 0 && button) {
				DoEntFire("!self", "Use", "", 0, bots[0], button);
			}
		}
	}
	if (g_map_name == "c3m1_plankcountry") {
		if (!g_c3m1_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 8700 && !has_tank()) {
				local button = Entities.FindByName(null, "ferry_button");
				local camp_pos = Vector(-6417, 6351, 238);
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 1, bots[0], button);
						Say(null, "c11m2 trigger1", false);
					}
				}
				set_bot_target(camp_pos);
				g_c3m1_trigger1 = true;
				g_c3m1_trigger1_time = Time();
			}
		}
		if (g_c3m1_trigger1 && !g_c3m1_trigger2 && Time() > g_c3m1_trigger1_time + 85.0 && !g_c3m1_trigger2) {
			Say(null, "c3m1 trigger2", false);
			reset_bot_target();
			g_c3m1_trigger2 = true;
		}
	}
	if (g_map_name == "c3m3_shantytown") {
		if (!g_c3m3_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 5700) {
				local unstick_pos = Vector(-3971, -3190, 124.5);
				set_bot_target(unstick_pos);
				if (near_survivor_bot(unstick_pos, true)) {
					reset_bot_target();
					Say(null, "c3m3 trigger1", false);
					g_c3m3_trigger1 = true;
				}
			}
		}
		if (g_c3m3_trigger1 && !g_c3m3_trigger2) {
			local dist = bot_flow_distance();
			if (dist > 11000) {
				local button = Entities.FindByName(null, "bridge_button");
				local camp_pos = Vector(-419.9, -4077.3, 140.1);
				if (button) {
					DoEntFire("!self", "Press", "", 0, null, button);
					Say(null, "c3m3 trigger2", false);
				}
				set_bot_target(camp_pos);
				g_c3m3_trigger2_time = Time();
				g_c3m3_trigger2 = true;
			}
		}
		if (g_c3m3_trigger2 && Time() > g_c3m3_trigger2_time + 20.0 && !g_c3m3_trigger3) {
			Say(null, "c3m3 trigger3", false);
			reset_bot_target();
			g_c3m3_trigger3 = true;
		}
	}
	if (g_map_name == "c3m4_plantation") {
		local dist = bot_flow_distance();
		
		get_remote_pills();
		
		if (dist > 11302) {
			local button1 = Entities.FindByName(null, "escape_gate_button");
			local bots = survivor_bots();
			if (bots.len() > 0) {
				if (button1) {
					DoEntFire("!self", "Use", "", 0, bots[0], button1);
					Say(null, "c3m3 trigger1", false);
				} else {
					local button2 = Entities.FindByName(null, "escape_gate_triggerfinale");
					if (button2) {
						DoEntFire("!self", "Use", "", 0, bots[0], button2);
					}
				}
			}
		}
	}
	
	if (g_map_name == "c4m2_sugarmill_a") {
		if (!g_c4m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 18317) {
				local button = Entities.FindByName(null, "button_callelevator");
				local camp_pos = Vector(-380, -8993, 686);
				local bots = survivor_bots();
				if (button && bots.len() > 0) {
					DoEntFire("!self", "Use", "", 0, bots[0], button);
					Say(null, "c4m1 trigger1", false);
				}
				set_bot_target(camp_pos);
				g_c4m2_trigger1_time = Time();
				g_c4m2_trigger1 = true;
			}
		}
		if (g_c4m2_trigger1 && Time() > g_c4m2_trigger1_time + 60.0 && !g_c4m2_trigger2) {
			local unstick_pos = Vector(-1511, -9575, 683);
			local button = Entities.FindByName(null, "button_inelevator");
			local bots = survivor_bots();
			if (button && bots.len() > 0) {
				set_bot_target(unstick_pos);
				DoEntFire("!self", "Use", "", 0, bots[0], button);
				Say(null, "try c4m2 trigger2", false);
			} else {
				g_c4m2_trigger2 = true;
			}
		}
		if (g_c4m2_trigger2 && !g_c4m2_trigger3) {
			local unstick_pos = Vector(-704, -9563, 167);
			set_bot_target(unstick_pos);
			if (near_survivor_bot(unstick_pos, true)) {
				reset_bot_target();
				Say(null, "c4m2 trigger3", false);
				g_c4m2_trigger3 = true;
			}
		}
	}
	if (g_map_name == "c4m5_milltown_escape") {
		get_remote_pills();
	}
	if (g_map_name == "c12m2_traintunnel" || g_map_name == "C12m2_traintunnel") {
		if (!g_c12m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 4000) {
				local door = Entities.FindByName(null, "emergency_door");
				local bots = survivor_bots();
				if (door && bots.len() > 0) {
					DoEntFire("!self", "PlayerOpen", "", 0, bots[0], door);
					Say(null, "c12m2 trigger1", false);
				}
				g_c12m2_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c12m3_bridge" || g_map_name == "C12m3_bridge") {
		if (!g_c12m3_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 13000) {
				g_c12m3_trigger1 = true;
			}
		}
		if (g_c12m3_trigger1 && !g_c12m3_trigger2) {
			local pos = Vector(8120, -13644, 74);
			local button = Entities.FindByName(null, "train_engine_button");
			if (button) {
				set_bot_target(pos);
				if (near_survivor_bot(pos)) {
					local button = Entities.FindByName(null, "train_engine_button");
					local bots = survivor_bots();
					if (button && bots.len() > 0) {
						DoEntFire("!self", "Use", "", 0, bots[0], button);
						Say(null, "c12m3 trigger2", false);
					}
					reset_bot_target();
					g_c12m3_trigger2 = true;
				}
			} else {
				reset_bot_target();
				g_c12m3_trigger2 = true;
			}
		}
	}
	if (g_map_name == "c12m5_cornfield" || g_map_name == "C12m5_cornfield") {
		local dist = bot_flow_distance();
		
		get_remote_pills();
		
		if (dist > 10000) {
			local button1 = Entities.FindByName(null, "radio_button");
			local bots = survivor_bots();
			if (bots.len() > 0) {
				if (button1) {
					DoEntFire("!self", "Use", "", 0, bots[0], button1);
					Say(null, "c3m3 trigger1", false);
				} else {
					local button2 = Entities.FindByName(null, "radio");
					if (button2) {
						DoEntFire("!self", "Use", "", 0, bots[0], button2);
					}
				}
			}
		}
	}
	if (g_map_name == "c13m1_alpinecreek") {
		if (!g_c13m1_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 11000) {
				local bots = survivor_bots();
				local button = Entities.FindByName(null, "bunker_button");
				if (button && bots.len() > 0) {
					DoEntFire("!self", "Press", "", 0, bots[0], button);
				}
				g_c13m1_trigger1 = true;
			}
		}
	}
	if (g_map_name == "c13m2_southpinestream") {
		local unstick_pos1 = Vector(5967, 2604, 822)
		if (!g_c13m2_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 5000 && has_tank()) {
				Convars.SetValue("sb_unstick", 0);
				set_bot_target(unstick_pos1);
				g_c13m2_trigger1 = true;
			}
		}
		if (g_c13m2_trigger1 && !g_c13m2_trigger2) {
			if (!has_tank()) {
				Convars.SetValue("sb_unstick", 1);
				if (near_survivor_bot(unstick_pos1, true)) {
					reset_bot_target();
					Say(null, "c13m2 trigger2", false);
					g_c13m2_trigger2 = true;
				}
			}
		}
		if (!g_c13m2_trigger3) {
			local dist = bot_flow_distance();
			if (dist > 18460) {
				local pos = Vector(566, 5803, 335);
				set_bot_target(pos);
				if (near_survivor_bot(pos, true)) {
					local button = Entities.FindByName(null, "bridge_button");
					if (button) {
						EntFire("bridge_barrels", "StopGlowing", "", 0);
						EntFire("bridge_barrels", "Kill", "", 0);
						EntFire("bridge_button", "Kill", "", 0);
						EntFire("bridge_explosion", "Explode", "", 3);
						EntFire("bridge_fire", "Start", "", 0);
						EntFire("bridge_fire", "Stop", "", 10);
						EntFire("bridge_fire_sound", "PlaySound", "", 0);
						EntFire("bridge_fire_sound", "StopSound", "", 11);
						EntFire("bridge_shake", "StartShake", "", 2);
						EntFire("bridge_shake", "StopShake", "", 5);
						EntFire("bridge_murette", "Break", "", 3);
						EntFire("bridge_impact", "Explode", "", 3);
						EntFire("bridge_explosion_sound", "PlaySound", "", 3);
						EntFire("barrier", "EnableMotion", "", 2.5);
						EntFire("bridge_smoke", "Start", "", 0);
						EntFire("bridge_smoke", "Stop", "", 10);
						EntFire("bridge_dummy", "Kill", "", 0);
						EntFire("director", "BeginScript", "event_alarme", 3.2);
						EntFire("bridge_new_particle", "Start", "", 3);
						EntFire("bridge_new_particle1", "Start", "", 3.2);
						EntFire("bridge_new_particle1", "Stop", "", 5);
						EntFire("bridge_new_particle", "Stop", "", 5);
						EntFire("ceda_truck_alarm", "PlaySound", "", 3.5);
						EntFire("bridge_nav_blocker", "UnblockNav", "", 3);
						EntFire("scene_relay", "Trigger", "", 4.5);
						EntFire("bridge_barrels_hurt_trigger", "Enable", "", 3);
						EntFire("bridge_barrels_hurt_trigger", "Disable", "", 10);
						EntFire("barrier", "DisableMotion", "", 8);
						EntFire("template_onslaught_hint", "ForceSpawn", "", 4);
					}
					reset_bot_target();
					Say(null, "c13m2 trigger3", false);
					g_c13m2_trigger3 = true;
				}
			}
		}
	}
	if (g_map_name == "c13m4_cutthroatcreek") {
		if (!g_c13m4_trigger1) {
			local dist = bot_flow_distance();
			if (dist > 1700) {
				local camp_pos = Vector(-3649, -7950, 593);
				local button = Entities.FindByName(null, "startbldg_door_button");
				if (button) {
					local bots = survivor_bots();
					if (bots.len() > 0) {
						DoEntFire("!self", "Use", "", 0, bots[0], button);
						set_bot_target(camp_pos);
					}
				}
				Say(null, "c13m4 trigger1", false);
				g_c13m4_trigger1 = true;
			}
		}
		if (g_c13m4_trigger1 && !g_c13m4_trigger2) {
			local button = Entities.FindByName(null, "finale");
			local bots = survivor_bots();
			if (button && bots.len() > 0) {
				DoEntFire("!self", "Use", "", 0.1, bots[0], button);
				reset_bot_target();
				Say(null, "c13m4 trigger2", false);
				g_c13m4_trigger2 = true;
			}
		}
	}
}

function remove_entity()
{
	local ent = null;
	while((ent = Entities.FindByClassname(ent, "func_playerinfected_clip")) != null) {
		DoEntFire("!self", "kill", "", 0, null, ent);
	}
	
	ent = null;
	while((ent = Entities.FindByClassname(ent, "prop_car_alarm")) != null) {
		DoEntFire("!self", "kill", "", 0, null, ent);
	}
}

BOT_MOVE_TYPE_NORMAL <- 0
BOT_MOVE_TYPE_HURRY <- 1
g_bot_hurt_time <- 0
g_bot_hurt_tank_time <- 0
g_bot_hurt_without_tank_time <- 0
g_bot_move_target_pos <- null
g_bot_move_target <- false
g_bot_move_type <- BOT_MOVE_TYPE_NORMAL
BOT_MOVE_CANCEL_TIME <- 3.0
BOT_MOVE_HURRY_CANCEL_TIME <- 1.0

function set_bot_target(pos, type = BOT_MOVE_TYPE_NORMAL)
{
	g_bot_move_target_pos = pos;
	g_bot_move_type = type;
	if (type == BOT_MOVE_TYPE_NORMAL) {
		Convars.SetValue("sb_friend_immobilized_reaction_time_vs", 0.1);
	} else {
		Convars.SetValue("sb_friend_immobilized_reaction_time_vs", 0.0);
	}
}

function reset_bot_target()
{
	local bots = survivor_bots();
	foreach (bot in bots) {
		CommandABot({cmd = BOT_CMD_RESET, bot = bot});
	}
	g_bot_move_target = false;
	g_bot_move_target_pos = null;
	Convars.SetValue("sb_friend_immobilized_reaction_time_vs", 0.25);
}
function has_tank()
{
	local tbl = {};
	GetInfectedStats(tbl);
	return tbl.Tanks != 0;
}

FORCE_BOT_COMMAND_DELAY <- 10.0
g_force_bot_command_time <- 0
g_tank_buster_tick <- 0;
g_tank_buster_switch_time <- {};
TANK_BUSTER_RETREAT_DIST <- 200.0
TANK_BUSTER_FAR_DIST <- 400.0
TANK_BUSTER_SWITCH_TIME <- 3.0
function update_survivor_bot_ai()
{
	if (!Director.HasAnySurvivorLeftSafeArea()) {
		return;
	}
	local t = Time();
	
	if (has_tank()) {
		local tanks = {};
		local tank = null;
		local tank_count = 0;
		local i, j;
		local bots = survivor_bots();
		
		//Director.ClearCachedBotQueries();
		while (tank = Entities.FindByClassname(tank, "player")) {
			if (!tank.IsSurvivor() && !tank.IsDead() && tank.GetZombieType() == ZC_TANK) {
				tanks[tank_count++] <- tank;
			}
		}
		if (tank_count > 0) {
			for (j = 0; j < bots.len(); ++j) {
				CommandABot({cmd = BOT_CMD_ATTACK, bot = bots[j], target = tanks[0]});
			}
		}
		/* shit! doesn't work! */
		/*
		if (tank_count > 0) {
			if (Time() < g_bot_hurt_without_tank_time + TANK_BUSTER_SWITCH_TIME) {
				debug_print(format("bots reset %d %d", Time(), g_bot_hurt_without_tank_time));
				for (j = 0; j < bots.len(); ++j) {
					CommandABot({cmd = BOT_CMD_RESET, bot = bots[j]});
				}
			} else {
				for (j = 0; j < bots.len(); ++j) {
					local bot_pos = bots[j].GetOrigin();
					local bot_id = bots[j].GetPlayerUserId();
					local retreat = false;
					local help = false;
					
					local tank_dist = 100000;
					for (i = 0; i < tank_count; ++i) {
						local tank_pos = tanks[i].GetOrigin();
						local dist = (tank_pos - bot_pos).Length2D();
						if (dist < TANK_BUSTER_RETREAT_DIST && tank_dist > dist) {
							tank_dist = dist;
							debug_print(format("bot %d retreat dist %f", j, tank_dist));
							CommandABot({cmd = BOT_CMD_RETREAT, bot = bots[j], target = tanks[i]});
							retreat = true;
						}
					}
					if (!retreat) {
						tank_dist = -1;
						for (i = 0; i < tank_count; ++i) {
							local tank_pos = tanks[i].GetOrigin();
							local dist = (tank_pos - bot_pos).Length2D();
							if (tank_dist < 0 || tank_dist > dist) {
								tank_dist = dist;
								if (tank_dist > TANK_BUSTER_FAR_DIST) {
									local k, near_dist = 100000, near_bot = null;
									for (k = 0; k < bots.len(); ++k) {
										dist = (tank_pos - bots[k].GetOrigin()).Length2D();
										if (dist < near_dist) {
											near_dist = dist;
											near_bot = bots[k];
										}
									}
									if (near_bot.GetEntityIndex() != bots[j].GetEntityIndex() && near_dist < TANK_BUSTER_RETREAT_DIST) {
										debug_print(format("bot %d help dist %f->%f", j, tank_dist, near_dist));
										CommandABot({cmd = BOT_CMD_MOVE, bot = bots[j], pos = near_bot.GetOrigin()});
										help = true;
									}
								}
							}
						}
					}
					if (!retreat && !help) {
						for (i = 0; i < tank_count; ++i) {
							debug_print(format("bot %d attack", j));
							CommandABot({cmd = BOT_CMD_ATTACK, bot = bots[j], target = tanks[i]});
						}
					}
				}
			}
		}
		*/
	} else {
		if (g_all_bot_survivor_team) {
			if (((g_bot_move_type == BOT_MOVE_TYPE_NORMAL && t > g_bot_hurt_time + BOT_MOVE_CANCEL_TIME) 
				|| (g_bot_move_type == BOT_MOVE_TYPE_HURRY && t > g_bot_hurt_time + BOT_MOVE_HURRY_CANCEL_TIME)) 
					&& g_bot_move_target_pos && !g_bot_move_target && !has_tank())
			{
				local bots = survivor_bots();
				foreach (bot in bots) {
					CommandABot({cmd = BOT_CMD_MOVE, bot = bot, pos = g_bot_move_target_pos});
				}
				g_force_bot_command_time = t;
				g_bot_move_target = true;
				//debug_print(format("bot move on (%s)", g_bot_move_type == BOT_MOVE_TYPE_NORMAL ? "normal" : "hurry"));
			}
			if (g_bot_move_target_pos && t > g_force_bot_command_time + FORCE_BOT_COMMAND_DELAY && !has_tank()) 
			{
				local bots = survivor_bots();
				foreach (bot in bots) {
					CommandABot({cmd = BOT_CMD_MOVE, bot = bot, pos = g_bot_move_target_pos});
				}
				g_force_bot_command_time = t;
				g_bot_move_target = true;
				//debug_print("bot move force on");
			}
		}
		if (((g_bot_move_type == BOT_MOVE_TYPE_NORMAL && t < g_bot_hurt_time + BOT_MOVE_CANCEL_TIME) 
			|| (g_bot_move_type == BOT_MOVE_TYPE_HURRY && t < g_bot_hurt_time + BOT_MOVE_HURRY_CANCEL_TIME))
				&& g_bot_move_target) 
		{
			local bots = survivor_bots();
			foreach (bot in bots) {
				CommandABot({cmd = BOT_CMD_RESET, bot = bot});
			}
			g_bot_move_target = false;
			//debug_print("bot move off");
		}
	}
}

g_si_pos <- {}
g_si_pos_check_time <- {}
STUCK_TIMER <- 10.0
STUCKED_DETECT_TIME <- 30.0
STUCK_RADIUS <- 50.0
function stuck_check()
{
	local t = Time();
	foreach (id, old_pos in g_si_pos) {
		if (old_pos) {
			local player = GetPlayerFromUserID(id);
			if (player && player.IsPlayer() && IsPlayerABot(player) && !player.IsSurvivor() && player.GetZombieType() != ZC_TANK) {
				if (t - g_si_pos_check_time[id] > STUCKED_DETECT_TIME) {
					local pos = player.GetOrigin();
					local diff = (pos - old_pos).Length();
					if (diff < STUCK_RADIUS) {
						Say(null, "Killed stucked bot", false);
						player.Kill();
					} else {
						g_si_pos[id] <- pos;
					}
					g_si_pos_check_time[id] = t;
				}
			} else {
				g_si_pos[id] <- null;
				g_si_pos_check_time[id] <- null;
			}
		}
	}
}

SI_RESPAWN_DIST <- 1500.0
function respawn_check()
{
	local svs = {}, sv_c = 0;
	local sis = {}, si_c = 0;
	local ent = null;
	
	while (ent = Entities.FindByClassname(ent, "player")) {
		if (ent.IsSurvivor() && !ent.IsDead()) {
			svs[sv_c++] <- ent;
		} else if (!ent.IsDead()) {
			sis[si_c++] <- ent;
		}
	}
	foreach (si in sis) {
		if (IsPlayerABot(si) && si.GetZombieType() != ZC_TANK) {
			local near_dist = 10000.0;
			foreach (sv in svs) {
				local dist = (sv.GetOrigin() - si.GetOrigin()).Length();
				if (near_dist > dist) {
					near_dist = dist;
				}
			}
			if (near_dist > SI_RESPAWN_DIST && svs.len() > 0 && GetFlowDistanceForPosition(svs[0].GetOrigin()) > GetFlowDistanceForPosition(si.GetOrigin())) {
				local visible = false;
				foreach (sv in svs) {
					local trace = { start = si.EyePosition(), end = sv.EyePosition(), ignore = si, mask = TRACE_MASK_VISION };
					TraceLine(trace);
					if (trace.hit && trace.enthit == sv) {
						visible = true;
						break;
					}
				}
				if (!visible) {
					debug_print("si respawn");
					local interval = Convars.GetFloat("versus_special_respawn_interval");
					local new_interval = g_si_spawn_target_time + RandomFloat(0.0, 1.0) - Time();
					if (new_interval < 0) {
						new_interval = interval;
					}
					DirectorOptions.cm_SpecialRespawnInterval = new_interval;
					DirectorOptions.SpecialRespawnInterval = new_interval;
					si.Kill();
				}
			}
		}
	}
}

g_si_count <- 0
g_si_spawn_count <- 0
g_si_spawn_target_time <- 0
SI_SPAWN_RANGE <- 600
g_zombie_spawn_range <- 2000
g_change_spawn_range_time <- 0
g_si_first_spawn_time <- 0

// SI spawn control
SI_SPAWN_DIR <- [
	SPAWN_BEHIND_SURVIVORS,
	SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS,
//	SPAWN_ABOVE_SURVIVORS,
	SPAWN_NEAR_IT_VICTIM,
	SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS,
]
function si_reset()
{
	local interval = Convars.GetFloat("versus_special_respawn_interval");
	g_si_spawn_count = 0;
	g_si_count = 0;
	g_si_spawn_target_time = 0;
	g_si_first_spawn_time = 0;
	DirectorOptions.cm_SpecialRespawnInterval = interval;
	DirectorOptions.SpecialRespawnInterval = interval;
}

function si_bot_hurt(si)
{
	if (g_si_spawn_target_time) {
		local interval = Convars.GetFloat("versus_special_respawn_interval");
		local new_interval = g_si_spawn_target_time + RandomFloat(0.0, 1.0) - Time();
		if (new_interval < 0) {
			new_interval = interval;
		}
		DirectorOptions.cm_SpecialRespawnInterval = new_interval;
		DirectorOptions.SpecialRespawnInterval = new_interval;
	}
}

g_si_dist <- 0;
g_si_dist_count <- 0;
function si_bot_spawned(si)
{
	local max_zombies = Convars.GetFloat("z_max_player_zombies") - (g_all_bot_survivor_team ? 1 : 0);
	local interval = Convars.GetFloat("versus_special_respawn_interval");
	g_si_count += 1;
	g_si_spawn_count += 1;
	if (g_map_name != "c5m5_bridge") // tank spawns behind
	{
		DirectorOptions.PreferredSpecialDirection <- SI_SPAWN_DIR[g_si_count % SI_SPAWN_DIR.len()];
	}
	
	if (Time() >= g_si_first_spawn_time + interval * 0.8) {
		g_si_spawn_count = 0;
		g_si_first_spawn_time = Time();
		g_si_spawn_target_time = Time() + interval;
		DirectorOptions.cm_SpecialRespawnInterval = interval;
		DirectorOptions.SpecialRespawnInterval = interval;
		debug_print("first spawn");
	}
	if (DEBUG_MODE) {
		local bots = survivor_bots();
		local near_dist = 100000;
		foreach (bot in bots) {
			local dist = (bot.GetOrigin() - si.GetOrigin()).Length();
			if (near_dist > dist) {
				near_dist = dist;
			}
		}
		if (near_dist < 2000) {
			g_si_dist += near_dist;
			g_si_dist_count += 1;
		}
		if (g_si_dist_count > 0) {
			debug_print(format("si bot spawn %d dist %d, avg: %f", g_si_spawn_count, near_dist, g_si_dist / g_si_dist_count));
		}
	}
}

g_auto_trigger_time <- 0
g_all_bot_check_time <- 0
g_force_conver <- false
g_stuck_check_time <- 0
g_update_count <- 0
g_set_spawn_range <- false

function Update()
{
	local t = Time();
	
	++g_update_count;
	if (g_update_count % 40 == 0) {
		debug_print(format("flow dist: %d", bot_flow_distance()));
	}
	if (!g_bot_start) {
		if (t > g_bot_start_time) {
			Convars.SetValue("sb_stop", 0);
			g_bot_start = true;
			Say(null, "BOTs Power On", false);
		}
	}
	if (t > g_auto_trigger_time) {
		g_auto_trigger_time = Time() + 3.0;
		auto_trigger();
		respawn_check();
	}
	if (t > g_all_bot_check_time) {
		if (all_bot_team()) {
			g_all_bot_survivor_team = true;
			Convars.SetValue("survivor_revive_duration", 3);
			Convars.SetValue("survivor_revive_health", 39);
			DirectorOptions.ZombieTankHealth = 2000;
		} else {
			g_all_bot_survivor_team = false;
			reset_bot_target();
			Convars.SetValue("survivor_revive_duration", 5);
			Convars.SetValue("survivor_revive_health", 30);
			DirectorOptions.ZombieTankHealth = 2000;
		}
		g_all_bot_check_time = Time() + 10.0;
	}
	if (t - g_stuck_check_time > STUCK_TIMER) {
		g_stuck_check_time = t;
		stuck_check();
	}
	
	if (!g_set_spawn_range) {
		if (!("ZombieSpawnRange" in DirectorOptions)) {
			DirectorOptions.ZombieSpawnRange <- Convars.GetFloat("z_spawn_range");
		}
		g_set_spawn_range = true;
	}
	if (g_si_spawn_target_time - 1.0 < t) {
		if (g_zombie_spawn_range == 0) {
			debug_print("set spawn range");
			g_zombie_spawn_range = DirectorOptions.ZombieSpawnRange;
			DirectorOptions.ZombieSpawnRange = SI_SPAWN_RANGE;
			g_change_spawn_range_time = t;
		}
	} else if (g_zombie_spawn_range > 0 && t > g_change_spawn_range_time + 3.0) {
		if (DirectorOptions.ZombieSpawnRange == SI_SPAWN_RANGE) {
			debug_print("reset spawn range");
			DirectorOptions.ZombieSpawnRange = g_zombie_spawn_range;
		}
		g_zombie_spawn_range = 0;
	}
	
	update_survivor_bot_ai();
}
