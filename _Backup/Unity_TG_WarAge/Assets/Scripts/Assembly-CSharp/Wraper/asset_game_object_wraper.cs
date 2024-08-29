using System;
using ComponentEx;
using Core.Audio;
using Core.Scene;
using Core.Util;
using LuaInterface;
using UnityEngine;
using UnityEngine.AI;
using UnityWrap;

namespace Wraper
{
	public class asset_game_object_wraper
	{
		public static string name = "asset_game_object_object";

		public static string libname = "asset_game_object";

		private static luaL_Reg[] libfunc = new luaL_Reg[8]
		{
			new luaL_Reg("find", find),
			new luaL_Reg("find_with_tag", find_with_tag),
			new luaL_Reg("use_quick_loopup", use_quick_lookup),
			new luaL_Reg("create", create),
			new luaL_Reg("create_unsave", create_unsave),
			new luaL_Reg("destroy_all", destroy_all),
			new luaL_Reg("dont_destroy_onload", dont_destroy_onload),
			new luaL_Reg("animator_string_to_hash", animator_string_to_hash)
		};

		private static luaL_Reg[] func = new luaL_Reg[142]
		{
			new luaL_Reg("is_nil", is_nil),
			new luaL_Reg("destroy_object", destroy_object),
			new luaL_Reg("clone", clone),
			new luaL_Reg("get_pid", get_pid),
			new luaL_Reg("get_instance_id", get_instance_id),
			new luaL_Reg("set_name", set_name),
			new luaL_Reg("get_name", get_name),
			new luaL_Reg("set_tag", set_tag),
			new luaL_Reg("get_tag", get_tag),
			new luaL_Reg("set_layer", set_layer),
			new luaL_Reg("get_layer", get_layer),
			new luaL_Reg("set_active", set_active),
			new luaL_Reg("get_active", get_active),
			new luaL_Reg("get_active_inhierarchy", get_active_inhierarchy),
			new luaL_Reg("set_local_position", set_local_position),
			new luaL_Reg("get_local_position", get_local_position),
			new luaL_Reg("set_local_scale", set_local_scale),
			new luaL_Reg("get_local_scale", get_local_scale),
			new luaL_Reg("set_local_rotation", set_local_rotation),
			new luaL_Reg("get_local_rotation", get_local_rotation),
			new luaL_Reg("set_local_rotationq", set_local_rotationq),
			new luaL_Reg("get_local_rotationq", get_local_rotationq),
			new luaL_Reg("set_position", set_position),
			new luaL_Reg("get_position", get_position),
			new luaL_Reg("set_rotation", set_rotation),
			new luaL_Reg("get_rotation", get_rotation),
			new luaL_Reg("set_rotationq", set_rotationq),
			new luaL_Reg("get_rotationq", get_rotationq),
			new luaL_Reg("translate", translate),
			new luaL_Reg("rotate", rotate),
			new luaL_Reg("rotate_around", rotate_around),
			new luaL_Reg("get_up", get_up),
			new luaL_Reg("set_up", set_up),
			new luaL_Reg("get_forward", get_forward),
			new luaL_Reg("set_forward", set_forward),
			new luaL_Reg("look_at", look_at),
			new luaL_Reg("get_world_to_local_matrix", get_world_to_local_matrix),
			new luaL_Reg("get_child_by_name", get_child_by_name),
			new luaL_Reg("get_child_by_index", get_child_by_index),
			new luaL_Reg("get_child_count", get_child_count),
			new luaL_Reg("get_parent", get_parent),
			new luaL_Reg("set_parent", set_parent),
			new luaL_Reg("set_material_render_queue", set_material_render_queue),
			new luaL_Reg("get_material_render_queue", get_material_render_queue),
			new luaL_Reg("set_material_float_with_name", set_material_float_with_name),
			new luaL_Reg("get_material_float_with_name", get_material_float_with_name),
			new luaL_Reg("set_material_vector_with_name", set_material_vector_with_name),
			new luaL_Reg("get_material_vector_with_name", get_material_vector_with_name),
			new luaL_Reg("set_material_color_with_name", set_material_color_with_name),
			new luaL_Reg("get_material_color_with_name", get_material_color_with_name),
			new luaL_Reg("set_material_texture_with_name", set_material_texture_with_name),
			new luaL_Reg("get_material_texture_with_name", get_material_texture_with_name),
			new luaL_Reg("set_material_matrix_with_name", set_material_matrix_with_name),
			new luaL_Reg("get_material_matrix_with_name", get_material_matrix_with_name),
			new luaL_Reg("set_material", set_material),
			new luaL_Reg("get_material", get_material),
			new luaL_Reg("set_shader", set_shader),
			new luaL_Reg("get_shader", get_shader),
			new luaL_Reg("set_render_enable", set_render_enable),
			new luaL_Reg("set_rigidbody_iskinematic", set_rigidbody_iskinematic),
			new luaL_Reg("set_box_collider_size", set_box_collider_size),
			new luaL_Reg("get_box_collider_size", get_box_collider_size),
			new luaL_Reg("set_capsule_collider_radius", set_capsule_collider_radius),
			new luaL_Reg("get_capsule_collider_radius", get_capsule_collider_radius),
			new luaL_Reg("set_capsule_collider_height", set_capsule_collider_height),
			new luaL_Reg("get_capsule_collider_height", get_capsule_collider_height),
			new luaL_Reg("move", move),
			new luaL_Reg("simple_move", simple_move),
			new luaL_Reg("set_charactor_controller_enable", set_charactor_controller_enable),
			new luaL_Reg("set_an_collider", set_an_collider),
			new luaL_Reg("set_collider_enable", set_collider_enable),
			new luaL_Reg("set_animator_enable", set_animator_enable),
			new luaL_Reg("set_root_motion", set_root_motion),
			new luaL_Reg("get_root_motion", get_root_motion),
			new luaL_Reg("animator_cross_fade", animator_cross_fade),
			new luaL_Reg("animator_has_state", animator_has_state),
			new luaL_Reg("animator_play", animator_play),
			new luaL_Reg("animator_play_use_hash_name", animator_play_use_hash_name),
			new luaL_Reg("get_animator_state", get_animator_state),
			new luaL_Reg("set_animator_speed", set_animator_speed),
			new luaL_Reg("is_animator_name", is_animator_name),
			new luaL_Reg("set_animator_bool", set_animator_bool),
			new luaL_Reg("get_animator_bool", get_animator_bool),
			new luaL_Reg("set_animator_integer", set_animator_integer),
			new luaL_Reg("get_animator_integer", get_animator_integer),
			new luaL_Reg("set_animator_float", set_animator_float),
			new luaL_Reg("get_animator_float", get_animator_float),
			new luaL_Reg("set_animator_int_trigger", set_animator_int_trigger),
			new luaL_Reg("set_animator_string_trigger", set_animator_string_trigger),
			new luaL_Reg("animated_play", animated_play),
			new luaL_Reg("animated_cross_fade", animated_cross_fade),
			new luaL_Reg("animated_is_playing", animated_is_playing),
			new luaL_Reg("animated_stop", animated_stop),
			new luaL_Reg("set_animated_speed", set_animated_speed),
			new luaL_Reg("set_animated_loop", set_animated_loop),
			new luaL_Reg("set_is_trigger", set_is_trigger),
			new luaL_Reg("is_intersects", is_intersects),
			new luaL_Reg("is_contains", is_contains),
			new luaL_Reg("add_component_camera_follow", add_component_camera_follow),
			new luaL_Reg("is_grounded", is_grounded),
			new luaL_Reg("set_audio_listener_target", set_audio_listener_target),
			new luaL_Reg("set_on_click", set_on_click),
			new luaL_Reg("set_on_trigger_enter", set_on_trigger_enter),
			new luaL_Reg("set_on_trigger_stay", set_on_trigger_stay),
			new luaL_Reg("set_on_trigger_exit", set_on_trigger_exit),
			new luaL_Reg("set_on_start", set_on_start),
			new luaL_Reg("set_on_awake", set_on_awake),
			new luaL_Reg("set_on_update", set_on_update),
			new luaL_Reg("set_on_late_update", set_on_late_update),
			new luaL_Reg("set_on_destory", set_on_destory),
			new luaL_Reg("get_component_flash_lighting", get_component_flash_lighting),
			new luaL_Reg("get_component_line_render", get_component_line_render),
			new luaL_Reg("get_component_navmesh_agent", get_component_navmesh_agent),
			new luaL_Reg("get_component_navmesh_obstacle", get_component_navmesh_obstacle),
			new luaL_Reg("get_component_camera_path_animator", get_component_camera_path_animator),
			new luaL_Reg("get_component_camera_shake", get_component_camera_shake),
			new luaL_Reg("add_hud_text", add_hud_text),
			new luaL_Reg("set_animator_culling_mode", set_animator_culling_mode),
			new luaL_Reg("change_model_property", change_model_property),
			new luaL_Reg("opt_replay_effect", opt_replay_effect),
			new luaL_Reg("opt_stop_effect", opt_stop_effect),
			new luaL_Reg("disable_lightprobe_effect", disable_lightprobe_effect),
			new luaL_Reg("set_material_float_property", set_material_float_property),
			new luaL_Reg("set_material_color_property", set_material_color_property),
			new luaL_Reg("opt_effect_set_culling_mode", opt_effect_set_culling_mode),
			new luaL_Reg("opt_effect_reset_quality", opt_effect_reset_quality),
			new luaL_Reg("opt_set_effect_play_speed", opt_set_effect_play_speed),
			new luaL_Reg("get_component_audio_source", get_component_audio_source),
			new luaL_Reg("get_component_audio_source_by_clip", get_component_audio_source_by_clip),
			new luaL_Reg("get_component_audio_echo_filter", get_component_audio_echo_filter),
			new luaL_Reg("set_animated_enabled", set_animated_enabled),
			new luaL_Reg("set_animated_time", set_animated_time),
			new luaL_Reg("create_fast_shadows", create_fast_shadows),
			new luaL_Reg("get_childs", get_childs),
			new luaL_Reg("inverse_transform_point", inverse_transform_point),
			new luaL_Reg("set_button_script_enable", set_button_script_enable),
			new luaL_Reg("add_component_audio_high_pass_filter", add_component_audio_high_pass_filter),
			new luaL_Reg("add_component_audio_low_pass_filter", add_component_audio_low_pass_filter),
			new luaL_Reg("get_component_audio_high_pass_filter", get_component_audio_high_pass_filter),
			new luaL_Reg("get_component_audio_low_pass_filter", get_component_audio_low_pass_filter),
			new luaL_Reg("set_audio_high_pass_filter_enable", set_audio_high_pass_filter_enable),
			new luaL_Reg("set_audio_low_pass_filter_enable", set_audio_low_pass_filter_enable)
		};

		private static string string_find = "asset_game_object.find";

		private static string string_find_with_tag = "asset_game_object.find_with_tag";

		private static string string_use_quick_lookup = "ngui.use_quick_lookup";

		private static string string_create = "asset_game_object.create";

		private static string string_create_unsave = "asset_game_object.create_unsave";

		private static string string_dont_destroy_onload = "asset_game_object.dont_destroy_onload";

		private static string string_animator_string_to_hash = "asset_game_object.animator_string_to_hash";

		private static string string_is_nil = "asset_game_object_object:is_nil";

		private static string string_destroy_object = "asset_game_object_object:destroy_object";

		private static string string_clone = "asset_game_object_object:clone";

		private static string string_get_pid = "asset_game_object_object:get_pid";

		private static string string_get_instance_id = "asset_game_object_object:get_instance_id";

		private static string string_set_name = "asset_game_object_object:set_name";

		private static string string_get_name = "asset_game_object_object:get_name";

		private static string string_set_tag = "asset_game_object_object:set_tag";

		private static string string_get_tag = "asset_game_object_object:get_tag";

		private static string string_set_layer = "asset_game_object_object:set_layer";

		private static string string_get_layer = "asset_game_object_object:get_layer";

		private static string string_set_active = "asset_game_object_object:set_active";

		private static string string_get_active = "asset_game_object_object:get_active";

		private static string string_get_active_inhierarchy = "asset_game_object_object:get_active_inhierarchy";

		private static string string_set_local_position = "asset_game_object_object:set_local_position";

		private static string string_get_local_position = "asset_game_object_object:get_local_position";

		private static string string_set_local_scale = "asset_game_object_object:set_local_scale";

		private static string string_get_local_scale = "asset_game_object_object:get_local_scale";

		private static string string_set_local_rotation = "asset_game_object_object:set_local_rotation";

		private static string string_get_local_rotation = "asset_game_object_object:get_local_rotation";

		private static string string_set_local_rotationq = "asset_game_object_object:set_local_rotationq";

		private static string string_get_local_rotationq = "asset_game_object_object:get_local_rotationq";

		private static string string_set_position = "asset_game_object_object:set_position";

		private static string string_get_position = "asset_game_object_object:get_position";

		private static string string_set_rotation = "asset_game_object_object:set_rotation";

		private static string string_get_rotation = "asset_game_object_object:get_rotation";

		private static string string_set_rotationq = "asset_game_object_object:set_rotationq";

		private static string string_get_rotationq = "asset_game_object_object:get_rotationq";

		private static string string_translate = "asset_game_object_object:translate";

		private static string string_rotate = "asset_game_object_object:rotate";

		private static string string_rotate_around = "asset_game_object_object:rotate_around";

		private static string string_get_up = "asset_game_object_object:get_up";

		private static string string_set_up = "asset_game_object_object:set_up";

		private static string string_get_forward = "asset_game_object_object:get_forward";

		private static string string_set_forward = "asset_game_object_object:set_forward";

		private static string string_look_at = "asset_game_object_object:look_at";

		private static string string_get_world_to_local_matrix = "asset_game_object_object:get_world_to_local_matrix";

		private static string string_get_child_by_name = "asset_game_object_object:get_child_by_name";

		private static string string_get_child_by_index = "asset_game_object_object:get_child_by_index";

		private static string string_get_child_count = "asset_game_object_object:get_child_count";

		private static string string_get_parent = "asset_game_object_object:get_parent";

		private static string string_set_parent = "asset_game_object_object:set_parent";

		private static string string_set_material_render_queue = "asset_game_object_object:set_material_render_queue";

		private static string string_get_material_render_queue = "asset_game_object_object:get_material_render_queue";

		private static string string_set_material_float_with_name = "asset_game_object_object:set_material_float_with_name";

		private static string string_get_material_float_with_name = "asset_game_object_object:get_material_float_with_name";

		private static string string_set_material_vector_with_name = "asset_game_object_object:set_material_vector_with_name";

		private static string string_get_material_vector_with_name = "asset_game_object_object:get_material_vector_with_name";

		private static string string_set_material_color_with_name = "asset_game_object_object:set_material_color_with_name";

		private static string string_get_material_color_with_name = "asset_game_object_object:get_material_color_with_name";

		private static string string_set_material_texture_with_name = "asset_game_object_object:set_material_texture_with_name";

		private static string string_get_material_texture_with_name = "asset_game_object_object:get_material_texture_with_name";

		private static string string_set_material_matrix_with_name = "asset_game_object_object:set_material_matrix_with_name";

		private static string string_get_material_matrix_with_name = "asset_game_object_object:get_material_matrix_with_name";

		private static string string_set_material = "asset_game_object_object:set_material";

		private static string string_get_material = "asset_game_object_object:get_material";

		private static string string_set_shader = "asset_game_object_object:set_shader";

		private static string string_get_shader = "asset_game_object_object:get_shader";

		private static string string_set_render_enable = "asset_game_object_object:set_render_enable";

		private static string string_set_rigidbody_iskinematic = "asset_game_object_object:set_rigidbody_iskinematic";

		private static string string_set_box_collider_size = "asset_game_object_object:set_box_collider_size";

		private static string string_get_box_collider_size = "asset_game_object_object:get_box_collider_size";

		private static string string_set_capsule_collider_radius = "asset_game_object_object:set_capsule_collider_radius";

		private static string string_get_capsule_collider_radius = "asset_game_object_object:get_capsule_collider_radius";

		private static string string_set_capsule_collider_height = "asset_game_object_object:set_capsule_collider_height";

		private static string string_get_capsule_collider_height = "asset_game_object_object:get_capsule_collider_height";

		private static string string_move = "asset_game_object_object:move";

		private static string string_simple_move = "asset_game_object_object:simple_move";

		private static string string_set_charactor_controller_enable = "asset_game_object_object:set_charactor_controller_enable";

		private static string string_set_collider_enable = "asset_game_object_object:set_collider_enable";

		private static string string_set_an_collider = "asset_game_object_object:set_an_collider";

		private static string string_set_animator_enable = "asset_game_object_object:set_animator_enable";

		private static string string_set_root_motion = "asset_game_object_object:set_root_motion";

		private static string string_get_root_motion = "asset_game_object_object:get_root_motion";

		private static string string_animator_cross_fade = "asset_game_object_object:animator_cross_fade";

		private static string string_animator_has_state = "asset_game_object_object::animator_has_state";

		private static string string_animator_play = "asset_game_object_object:animator_play";

		private static string string_animator_play_use_hash_name = "asset_game_object_object:animator_play_use_hash_name";

		private static string string_change_model_property = "asset_game_object_object:change_model_property";

		private static string string_get_animator_state = "asset_game_object_object:get_animator_state";

		private static string string_set_animator_speed = "asset_game_object_object:set_animator_speed";

		private static string string_is_animator_name = "asset_game_object_object:is_animator_name";

		private static string string_set_animator_bool = "asset_game_object_object:set_animator_bool";

		private static string string_get_animator_bool = "asset_game_object_object:get_animator_bool";

		private static string string_set_animator_integer = "asset_game_object_object:set_animator_integer";

		private static string string_get_animator_integer = "asset_game_object_object:get_animator_integer";

		private static string string_set_animator_float = "asset_game_object_object:set_animator_float";

		private static string string_get_animator_float = "asset_game_object_object:get_animator_float";

		private static string string_set_animator_int_trigger = "asset_game_object_object:set_animator_int_trigger";

		private static string string_set_animator_string_trigger = "asset_game_object_object:set_animator_string_trigger";

		private static string string_animated_play = "asset_game_object_object:animated_play";

		private static string string_animated_cross_fade = "asset_game_object_object:animated_cross_fade";

		private static string string_animated_is_playing = "asset_game_object_object:animated_is_playing";

		private static string string_set_animated_speed = "asset_game_object_object:set_animated_speed";

		private static string string_set_animated_loop = "asset_game_object_object:set_animated_loop";

		private static string string_animated_stop = "asset_game_object_object:animated_stop";

		private static string string_set_is_trigger = "asset_game_object_object:set_is_trigger";

		private static string string_is_intersects = "asset_game_object_object:is_intersects";

		private static string string_is_contains = "asset_game_object_object:is_contains";

		private static string string_add_component_camera_follow = "asset_game_object_object:add_component_camera_follow";

		private static string string_is_grounded = "asset_game_object_object:is_grounded";

		private static string string_set_audio_listener_target = "asset_game_object_object:set_audio_listener_target";

		private static string string_set_on_click = "asset_game_object_object:set_on_click";

		private static string string_set_on_trigger_enter = "asset_game_object_object:set_on_trigger_enter";

		private static string string_set_on_trigger_stay = "asset_game_object_object:set_on_trigger_stay";

		private static string string_set_on_trigger_exit = "asset_game_object_object:set_on_trigger_exit";

		private static string string_set_on_start = "asset_game_object_object:set_on_start";

		private static string string_set_on_awake = "asset_game_object_object:set_on_awake";

		private static string string_set_on_update = "asset_game_object_object:set_on_update";

		private static string string_set_on_late_update = "asset_game_object_object:set_on_late_update";

		private static string string_set_on_destory = "asset_game_object_object:set_on_destory";

		private static string string_get_component_flash_lighting = "asset_game_object_object:get_component_flash_lighting";

		private static string string_get_component_line_render = "asset_game_object_object:get_component_line_render";

		private static string string_get_component_navmesh_agent = "asset_game_object_object:get_component_navmesh_agent";

		private static string string_get_component_navmesh_obstacle = "asset_game_object_object:get_component_navmesh_obstacle";

		private static string string_get_component_camera_path_animator = "asset_game_object_object:get_component_camera_path_animator";

		private static string string_get_component_camera_shake = "camera_object:get_component_camera_shake";

		private static string string_add_hud_text = "asset_game_object_object:add_hud_text";

		private static string string_set_animator_culling_mode = "asset_game_object_object:set_animator_culling_mode";

		private static string string_opt_replay_effect = "asset_game_object_object:opt_replay_effect";

		private static string string_opt_stop_effect = "asset_game_object_object:opt_stop_effect";

		private static string string_opt_effect_set_culling_mode = "asset_game_object_object:opt_effect_set_culling_mode";

		private static string string_opt_effect_reset_quality = "asset_game_object_object:opt_effect_reset_quality";

		private static string string_opt_set_effect_play_speed = "asset_game_object_object:opt_set_effect_play_speed";

		private static string string_disable_lightprobe_effect = "asset_game_object_object:disable_lightprobe_effect";

		private static string string_set_material_float_property = "asset_game_object_object:set_material_float_property";

		private static string string_set_material_color_property = "asset_game_object_object:set_material_color_property";

		private static string string_get_material_float_property = "asset_game_object_object:get_material_float_property";

		private static string string_get_material_color_property = "asset_game_object_object:get_material_color_property";

		private static string string_get_component_audio_source = "asset_game_object_object:get_component_audio_source";

		private static string string_get_component_audio_source_by_clip = "asset_game_object_object:get_component_audio_source_by_clip";

		private static string string_get_component_audio_echo_filter = "asset_game_object_object:get_component_audio_echo_filter";

		private static string string_set_animated_enabled = "asset_game_object_object:set_animated_enabled";

		private static string string_set_animated_time = "asset_game_object_object:set_animated_time";

		private static string string_create_fast_shadows = "asset_game_object_object:create_fast_shadows";

		private static string string_get_childs = "asset_game_object_object:get_childs";

		private static string string_inverse_transform_point = "asset_game_object_object:inverse_transform_point";

		private static string string_set_button_script_enable = "asset_game_object_object:set_button_script_enable";

		private static string string_add_component_audio_high_pass_filter = "asset_game_object_object:add_component_audio_high_pass_filter";

		private static string string_add_component_audio_low_pass_filter = "asset_game_object_object:add_component_audio_low_pass_filter";

		private static string string_get_component_audio_high_pass_filter = "asset_game_object_object:get_component_audio_high_pass_filter";

		private static string string_get_component_audio_low_pass_filter = "asset_game_object_object:get_component_audio_low_pass_filter";

		private static string string_set_audio_high_pass_filter_enable = "asset_game_object_object:set_audio_high_pass_filter_enable";

		private static string string_set_audio_low_pass_filter_enable = "asset_game_object_object:set_audio_low_pass_filter_enable";

		public static bool init(IntPtr L)
		{
			if (L != IntPtr.Zero)
			{
				LuaDLL.register_class(L, name, func, gc);
				LuaDLL.register_lib(L, libname, libfunc, 0);
				return true;
			}
			return false;
		}

		public static void push(IntPtr L, AssetGameObject obj)
		{
			if (obj == null)
			{
				LuaDLL.lua_pushnil(L);
				return;
			}
			obj.AddRef();
			LuaDLL.use_lua_newuserdata_ex(L, 4, obj.GetPid());
			LuaDLL.lua_getfield(L, LuaIndexes.LUA_REGISTRYINDEX, name);
			LuaDLL.lua_setmetatable(L, -2);
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_find))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				AssetGameObject base_object = AssetGameObject.CreateByFind(text);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int find_with_tag(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_find_with_tag))
			{
				string text = null;
				text = LuaDLL.lua_tostring(L, 1);
				AssetGameObject[] base_objects = AssetGameObject.CreateByFindWithTag(text);
				WraperUtil.PushObjects(L, base_objects);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int use_quick_lookup(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsBoolean(L, 1, string_use_quick_lookup))
			{
				bool useNodeQuickLookup = LuaDLL.lua_toboolean(L, 1);
				AssetGameObject.useNodeQuickLookup = useNodeQuickLookup;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create))
			{
				AssetObject assetObject = null;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_create, AssetObject.cache);
				AssetGameObject base_object = AssetGameObject.CreateByAssetObject(assetObject, true);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create_unsave(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create_unsave))
			{
				AssetObject assetObject = null;
				assetObject = WraperUtil.LuaToUserdata(L, 1, string_create_unsave, AssetObject.cache);
				AssetGameObject base_object = AssetGameObject.CreateByAssetObject(assetObject, false);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int destroy_all(IntPtr L)
		{
			int num = 0;
			AssetGameObject.DestroyAll();
			return 0;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int dont_destroy_onload(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_dont_destroy_onload))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_dont_destroy_onload, AssetGameObject.cache);
				UnityEngine.Object.DontDestroyOnLoad(assetGameObject.gameObject);
				if (assetGameObject.gameObject.GetComponent<ComponentDontDestroy>() == null)
				{
					assetGameObject.gameObject.AddComponent<ComponentDontDestroy>();
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animator_string_to_hash(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsString(L, 1, string_animator_string_to_hash))
			{
				string text = LuaDLL.lua_tostring(L, 1);
				LuaDLL.lua_pushnumber(L, Animator.StringToHash(text));
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_nil(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_is_nil))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_is_nil, AssetGameObject.cache);
				bool value = false;
				if (assetGameObject.gameObject == null)
				{
					value = true;
				}
				LuaDLL.lua_pushboolean(L, value);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int destroy_object(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_destroy_object))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_destroy_object, AssetGameObject.cache);
				assetGameObject.isNeedDestroy = true;
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int clone(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_clone))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_clone, AssetGameObject.cache);
				AssetGameObject base_object = AssetGameObject.Clone(assetGameObject);
				WraperUtil.PushObject(L, base_object);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_pid(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_pid))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_pid, AssetGameObject.cache);
				LuaDLL.lua_pushnumber(L, assetGameObject.GetPid());
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_instance_id(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_instance_id))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_instance_id, AssetGameObject.cache);
				LuaDLL.lua_pushnumber(L, (assetGameObject.gameObject != null) ? assetGameObject.gameObject.GetInstanceID() : 0);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_name) && WraperUtil.ValidIsString(L, 2, string_set_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					assetGameObject.gameObject.name = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_name))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_name, AssetGameObject.cache);
				LuaDLL.lua_pushstring(L, (!(assetGameObject.gameObject != null)) ? null : assetGameObject.gameObject.name);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_tag(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_tag) && WraperUtil.ValidIsString(L, 2, string_set_tag))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_tag, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					assetGameObject.gameObject.tag = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_tag(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_tag))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_tag, AssetGameObject.cache);
				LuaDLL.lua_pushstring(L, (!(assetGameObject.gameObject != null)) ? null : assetGameObject.gameObject.tag);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_layer(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_layer) && WraperUtil.ValidIsNumber(L, 2, string_set_layer) && WraperUtil.ValidIsBoolean(L, 3, string_set_layer))
			{
				AssetGameObject assetGameObject = null;
				int num = 0;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_layer, AssetGameObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				flag = LuaDLL.lua_toboolean(L, 3);
				if (assetGameObject.gameObject != null)
				{
					if (flag)
					{
						Transform[] componentsInChildren = assetGameObject.gameObject.GetComponentsInChildren<Transform>();
						for (int i = 0; i < componentsInChildren.Length; i++)
						{
							componentsInChildren[i].gameObject.layer = num;
						}
					}
					else
					{
						assetGameObject.gameObject.layer = num;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_layer(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_layer))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_layer, AssetGameObject.cache);
				LuaDLL.lua_pushnumber(L, (!(assetGameObject.gameObject != null)) ? (-1) : assetGameObject.gameObject.layer);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_active) && WraperUtil.ValidIsBoolean(L, 2, string_set_active))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_active, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.gameObject != null)
				{
					assetGameObject.gameObject.SetActive(flag);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_active(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_active))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_active, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.gameObject.activeSelf);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_active_inhierarchy(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_active_inhierarchy))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_active, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.gameObject.activeInHierarchy);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_local_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_local_position) && WraperUtil.ValidIsNumber(L, 2, string_set_local_position) && WraperUtil.ValidIsNumber(L, 3, string_set_local_position) && WraperUtil.ValidIsNumber(L, 4, string_set_local_position))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_local_position, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.localPosition = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_local_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_local_position))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_local_position, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Vector3 localPosition = assetGameObject.transform.localPosition;
					LuaDLL.lua_pushnumber(L, localPosition.x);
					LuaDLL.lua_pushnumber(L, localPosition.y);
					LuaDLL.lua_pushnumber(L, localPosition.z);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_local_scale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_local_scale) && WraperUtil.ValidIsNumber(L, 2, string_set_local_scale) && WraperUtil.ValidIsNumber(L, 3, string_set_local_scale) && WraperUtil.ValidIsNumber(L, 4, string_set_local_scale))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_local_scale, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.localScale = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_local_scale(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_local_scale))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_local_scale, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Vector3 localScale = assetGameObject.transform.localScale;
					LuaDLL.lua_pushnumber(L, localScale.x);
					LuaDLL.lua_pushnumber(L, localScale.y);
					LuaDLL.lua_pushnumber(L, localScale.z);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_local_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_local_rotation) && WraperUtil.ValidIsNumber(L, 2, string_set_local_rotation) && WraperUtil.ValidIsNumber(L, 3, string_set_local_rotation) && WraperUtil.ValidIsNumber(L, 4, string_set_local_rotation))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_local_rotation, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.localRotation = Quaternion.Euler(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_local_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_local_rotation))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_local_rotation, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Vector3 eulerAngles = assetGameObject.transform.localRotation.eulerAngles;
					LuaDLL.lua_pushnumber(L, eulerAngles.x);
					LuaDLL.lua_pushnumber(L, eulerAngles.y);
					LuaDLL.lua_pushnumber(L, eulerAngles.z);
					result = 3;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_local_rotationq(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_local_rotationq) && WraperUtil.ValidIsNumber(L, 2, string_set_local_rotationq) && WraperUtil.ValidIsNumber(L, 3, string_set_local_rotationq) && WraperUtil.ValidIsNumber(L, 4, string_set_local_rotationq) && WraperUtil.ValidIsNumber(L, 5, string_set_local_rotationq))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_local_rotationq, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.localRotation = new Quaternion(num, num2, num3, num4);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_local_rotationq(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_local_rotationq))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_local_rotationq, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Quaternion localRotation = assetGameObject.transform.localRotation;
					LuaDLL.lua_pushnumber(L, localRotation.x);
					LuaDLL.lua_pushnumber(L, localRotation.y);
					LuaDLL.lua_pushnumber(L, localRotation.z);
					LuaDLL.lua_pushnumber(L, localRotation.w);
				}
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_position) && WraperUtil.ValidIsNumber(L, 2, string_set_position) && WraperUtil.ValidIsNumber(L, 3, string_set_position) && WraperUtil.ValidIsNumber(L, 4, string_set_position))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_position, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.position = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_position(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_position))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_position, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Vector3 position = assetGameObject.transform.position;
					LuaDLL.lua_pushnumber(L, position.x);
					LuaDLL.lua_pushnumber(L, position.y);
					LuaDLL.lua_pushnumber(L, position.z);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_rotation) && WraperUtil.ValidIsNumber(L, 2, string_set_rotation) && WraperUtil.ValidIsNumber(L, 3, string_set_rotation) && WraperUtil.ValidIsNumber(L, 4, string_set_rotation))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_rotation, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.rotation = Quaternion.Euler(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_rotation(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_rotation))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_rotation, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					LuaDLL.lua_pushnumber(L, assetGameObject.transform.rotation.eulerAngles.x);
					LuaDLL.lua_pushnumber(L, assetGameObject.transform.rotation.eulerAngles.y);
					LuaDLL.lua_pushnumber(L, assetGameObject.transform.rotation.eulerAngles.z);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_rotationq(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_rotationq) && WraperUtil.ValidIsNumber(L, 2, string_set_rotationq) && WraperUtil.ValidIsNumber(L, 3, string_set_rotationq) && WraperUtil.ValidIsNumber(L, 4, string_set_rotationq) && WraperUtil.ValidIsNumber(L, 5, string_set_rotationq))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_rotationq, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.rotation = new Quaternion(num, num2, num3, num4);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_rotationq(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_rotationq))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_rotationq, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Quaternion rotation = assetGameObject.transform.rotation;
					LuaDLL.lua_pushnumber(L, rotation.x);
					LuaDLL.lua_pushnumber(L, rotation.y);
					LuaDLL.lua_pushnumber(L, rotation.z);
					LuaDLL.lua_pushnumber(L, rotation.w);
				}
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int translate(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_translate) && WraperUtil.ValidIsNumber(L, 2, string_translate) && WraperUtil.ValidIsNumber(L, 3, string_translate) && WraperUtil.ValidIsNumber(L, 4, string_translate) && WraperUtil.ValidIsBoolean(L, 5, string_translate))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_translate, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				flag = LuaDLL.lua_toboolean(L, 5);
				if (assetGameObject.transform != null)
				{
					if (!flag)
					{
						assetGameObject.transform.Translate(num, num2, num3, Space.Self);
					}
					else
					{
						assetGameObject.transform.Translate(num, num2, num3, Space.World);
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int rotate(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_rotate) && WraperUtil.ValidIsNumber(L, 2, string_rotate) && WraperUtil.ValidIsNumber(L, 3, string_rotate) && WraperUtil.ValidIsNumber(L, 4, string_rotate) && WraperUtil.ValidIsBoolean(L, 5, string_rotate))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_rotate, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				flag = LuaDLL.lua_toboolean(L, 5);
				if (assetGameObject.transform != null)
				{
					if (!flag)
					{
						assetGameObject.transform.Rotate(num, num2, num3, Space.Self);
					}
					else
					{
						assetGameObject.transform.Rotate(num, num2, num3, Space.World);
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int rotate_around(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_rotate_around) && WraperUtil.ValidIsNumber(L, 2, string_rotate_around) && WraperUtil.ValidIsNumber(L, 3, string_rotate_around) && WraperUtil.ValidIsNumber(L, 4, string_rotate_around) && WraperUtil.ValidIsNumber(L, 5, string_rotate_around) && WraperUtil.ValidIsNumber(L, 6, string_rotate_around) && WraperUtil.ValidIsNumber(L, 7, string_rotate_around) && WraperUtil.ValidIsNumber(L, 8, string_rotate_around))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				float num5 = 0f;
				float num6 = 0f;
				float num7 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_rotate_around, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				num4 = (float)LuaDLL.lua_tonumber(L, 5);
				num5 = (float)LuaDLL.lua_tonumber(L, 6);
				num6 = (float)LuaDLL.lua_tonumber(L, 7);
				num7 = (float)LuaDLL.lua_tonumber(L, 8);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.RotateAround(new Vector3(num, num2, num3), new Vector3(num4, num5, num6), num7);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_up(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_up))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_up, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Vector3 up = assetGameObject.transform.up;
					LuaDLL.lua_pushnumber(L, up.x);
					LuaDLL.lua_pushnumber(L, up.y);
					LuaDLL.lua_pushnumber(L, up.z);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_up(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_up) && WraperUtil.ValidIsNumber(L, 2, string_set_up) && WraperUtil.ValidIsNumber(L, 3, string_set_up) && WraperUtil.ValidIsNumber(L, 4, string_set_up))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_up, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.up = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_forward(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_forward))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_forward, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					Vector3 forward = assetGameObject.transform.forward;
					LuaDLL.lua_pushnumber(L, forward.x);
					LuaDLL.lua_pushnumber(L, forward.y);
					LuaDLL.lua_pushnumber(L, forward.z);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_forward(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_forward) && WraperUtil.ValidIsNumber(L, 2, string_set_forward) && WraperUtil.ValidIsNumber(L, 3, string_set_forward) && WraperUtil.ValidIsNumber(L, 4, string_set_forward))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_forward, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.forward = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int look_at(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_look_at) && WraperUtil.ValidIsNumber(L, 2, string_look_at) && WraperUtil.ValidIsNumber(L, 3, string_look_at) && WraperUtil.ValidIsNumber(L, 4, string_look_at))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_look_at, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.LookAt(new Vector3(num, num2, num3));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_world_to_local_matrix(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_world_to_local_matrix))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_world_to_local_matrix, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					WraperUtil.PushObject(L, MatrixWrap.CreateInstance(assetGameObject.transform.worldToLocalMatrix));
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_child_by_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_child_by_name) && WraperUtil.ValidIsString(L, 2, string_get_child_by_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_child_by_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				AssetGameObject assetGameObject2 = null;
				if (assetGameObject.transform != null)
				{
					Transform transform = Utils.FastFind<Transform>(assetGameObject.uiNodeLookUp, assetGameObject.gameObject, text);
					if (transform != null)
					{
						assetGameObject2 = AssetGameObject.CreateByInstance(transform.gameObject);
					}
				}
				if (assetGameObject2 != null)
				{
					WraperUtil.PushObject(L, assetGameObject2);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_child_by_index(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_child_by_index) && WraperUtil.ValidIsNumber(L, 2, string_get_child_by_index))
			{
				AssetGameObject assetGameObject = null;
				int num = 0;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_child_by_index, AssetGameObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				AssetGameObject assetGameObject2 = null;
				if (assetGameObject.transform != null)
				{
					Transform child = assetGameObject.transform.GetChild(num);
					if (child != null)
					{
						assetGameObject2 = AssetGameObject.CreateByInstance(child.gameObject);
					}
				}
				if (assetGameObject2 != null)
				{
					WraperUtil.PushObject(L, assetGameObject2);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_child_count(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_child_count))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_child_count, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					LuaDLL.lua_pushnumber(L, assetGameObject.transform.childCount);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_parent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_parent))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_parent, AssetGameObject.cache);
				AssetGameObject assetGameObject2 = null;
				if (assetGameObject.transform != null)
				{
					Transform parent = assetGameObject.transform.parent;
					if (parent != null)
					{
						assetGameObject2 = AssetGameObject.CreateByInstance(parent.gameObject);
					}
				}
				if (assetGameObject2 != null)
				{
					WraperUtil.PushObject(L, assetGameObject2);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_parent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_parent) && WraperUtil.ValidIsUserdataOrNil(L, 2, string_set_parent))
			{
				AssetGameObject assetGameObject = null;
				AssetGameObject assetGameObject2 = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_parent, AssetGameObject.cache);
				assetGameObject2 = WraperUtil.LuaToUserdataOrNil(L, 2, string_set_parent, AssetGameObject.cache);
				if (assetGameObject.transform != null)
				{
					assetGameObject.transform.parent = ((assetGameObject2 != null) ? assetGameObject2.transform : null);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_render_queue(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_render_queue) && WraperUtil.ValidIsNumber(L, 2, string_set_material_render_queue))
			{
				AssetGameObject assetGameObject = null;
				int num = 0;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_render_queue, AssetGameObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material.renderQueue = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material_render_queue(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material_render_queue))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material_render_queue, AssetGameObject.cache);
				if (assetGameObject.render != null)
				{
					LuaDLL.lua_pushnumber(L, assetGameObject.render.material.renderQueue);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_float_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_float_with_name) && WraperUtil.ValidIsString(L, 2, string_set_material_float_with_name) && WraperUtil.ValidIsNumber(L, 3, string_set_material_float_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_float_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material.SetFloat(text, num);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material_float_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material_float_with_name) && WraperUtil.ValidIsString(L, 2, string_get_material_float_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material_float_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.render != null && assetGameObject.render.material.HasProperty(text))
				{
					LuaDLL.lua_pushnumber(L, assetGameObject.render.material.GetFloat(text));
				}
				else
				{
					LuaDLL.lua_pushnumber(L, 0.0);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_vector_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_vector_with_name) && WraperUtil.ValidIsString(L, 2, string_set_material_vector_with_name) && WraperUtil.ValidIsNumber(L, 3, string_set_material_vector_with_name) && WraperUtil.ValidIsNumber(L, 4, string_set_material_vector_with_name) && WraperUtil.ValidIsNumber(L, 5, string_set_material_vector_with_name) && WraperUtil.ValidIsNumber(L, 6, string_set_material_vector_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				Vector4 zero = Vector4.zero;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_vector_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				zero.x = (float)LuaDLL.lua_tonumber(L, 3);
				zero.y = (float)LuaDLL.lua_tonumber(L, 4);
				zero.z = (float)LuaDLL.lua_tonumber(L, 5);
				zero.w = (float)LuaDLL.lua_tonumber(L, 6);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material.SetVector(text, zero);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material_vector_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material_vector_with_name) && WraperUtil.ValidIsString(L, 2, string_get_material_vector_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material_vector_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.render != null && assetGameObject.render.material.HasProperty(text))
				{
					Vector4 vector = assetGameObject.render.material.GetVector(text);
					LuaDLL.lua_pushnumber(L, vector.x);
					LuaDLL.lua_pushnumber(L, vector.y);
					LuaDLL.lua_pushnumber(L, vector.z);
					LuaDLL.lua_pushnumber(L, vector.w);
				}
				else
				{
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
				}
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_color_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_color_with_name) && WraperUtil.ValidIsString(L, 2, string_set_material_color_with_name) && WraperUtil.ValidIsNumber(L, 3, string_set_material_color_with_name) && WraperUtil.ValidIsNumber(L, 4, string_set_material_color_with_name) && WraperUtil.ValidIsNumber(L, 5, string_set_material_color_with_name) && WraperUtil.ValidIsNumber(L, 6, string_set_material_color_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				float num4 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_color_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				num2 = (float)LuaDLL.lua_tonumber(L, 4);
				num3 = (float)LuaDLL.lua_tonumber(L, 5);
				num4 = (float)LuaDLL.lua_tonumber(L, 6);
				if (assetGameObject.render != null && assetGameObject.render.material.HasProperty(text))
				{
					assetGameObject.render.material.SetColor(text, new Color(num, num2, num3, num4));
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material_color_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material_color_with_name) && WraperUtil.ValidIsString(L, 2, string_get_material_color_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material_color_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.render != null && assetGameObject.render.material.HasProperty(text))
				{
					Color color = assetGameObject.render.material.GetColor(text);
					LuaDLL.lua_pushnumber(L, color.r);
					LuaDLL.lua_pushnumber(L, color.g);
					LuaDLL.lua_pushnumber(L, color.b);
					LuaDLL.lua_pushnumber(L, color.a);
				}
				else
				{
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
				}
				result = 4;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_texture_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_texture_with_name) && WraperUtil.ValidIsString(L, 2, string_set_material_texture_with_name) && WraperUtil.ValidIsUserdata(L, 3, string_set_material_texture_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				TextureWrap textureWrap = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_texture_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				textureWrap = WraperUtil.LuaToUserdata(L, 3, string_set_material_texture_with_name, TextureWrap.cache);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material.SetTexture(text, textureWrap.component);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material_texture_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material_texture_with_name) && WraperUtil.ValidIsString(L, 2, string_get_material_texture_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material_texture_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.render != null)
				{
					WraperUtil.PushObject(L, TextureWrap.CreateInstance(assetGameObject.render.material.GetTexture(text)));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_matrix_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_matrix_with_name) && WraperUtil.ValidIsString(L, 2, string_set_material_matrix_with_name) && WraperUtil.ValidIsUserdata(L, 3, string_set_material_matrix_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				MatrixWrap matrixWrap = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_matrix_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				matrixWrap = WraperUtil.LuaToUserdata(L, 3, string_set_material_matrix_with_name, MatrixWrap.cache);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material.SetMatrix(text, matrixWrap.component);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material_matrix_with_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material_matrix_with_name) && WraperUtil.ValidIsString(L, 2, string_get_material_matrix_with_name))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material_matrix_with_name, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.render != null)
				{
					WraperUtil.PushObject(L, MatrixWrap.CreateInstance(assetGameObject.render.material.GetMatrix(text)));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material) && WraperUtil.ValidIsUserdata(L, 2, string_set_material))
			{
				AssetGameObject assetGameObject = null;
				MaterialWrap materialWrap = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material, AssetGameObject.cache);
				materialWrap = WraperUtil.LuaToUserdata(L, 2, string_set_material, MaterialWrap.cache);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material = materialWrap.material;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_material(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_material))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_material, AssetGameObject.cache);
				if (assetGameObject.render != null && assetGameObject.render.material != null)
				{
					WraperUtil.PushObject(L, MaterialWrap.CreateInstance(assetGameObject.render.material));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_shader(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_shader) && WraperUtil.ValidIsUserdata(L, 2, string_set_shader))
			{
				AssetGameObject assetGameObject = null;
				ShaderWrap shaderWrap = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_shader, AssetGameObject.cache);
				shaderWrap = WraperUtil.LuaToUserdata(L, 2, string_set_shader, ShaderWrap.cache);
				if (assetGameObject.render != null)
				{
					assetGameObject.render.material.shader = shaderWrap.component;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_shader(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_shader))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_shader, AssetGameObject.cache);
				if (assetGameObject.render != null && assetGameObject.render.material.shader != null)
				{
					WraperUtil.PushObject(L, ShaderWrap.CreateInstance(assetGameObject.render.material.shader));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_render_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_render_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_render_enable) && WraperUtil.ValidIsBoolean(L, 3, string_set_render_enable))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				bool flag2 = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_render_enable, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				flag2 = LuaDLL.lua_toboolean(L, 3);
				if (assetGameObject != null)
				{
					if (flag2)
					{
						Renderer[] componentsInChildren = assetGameObject.gameObject.GetComponentsInChildren<Renderer>();
						for (int i = 0; i < componentsInChildren.Length; i++)
						{
							componentsInChildren[i].enabled = flag;
						}
					}
					else
					{
						Renderer component = assetGameObject.gameObject.GetComponent<Renderer>();
						if (component != null)
						{
							component.enabled = flag;
						}
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_rigidbody_iskinematic(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_rigidbody_iskinematic) && WraperUtil.ValidIsBoolean(L, 2, string_set_rigidbody_iskinematic))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_rigidbody_iskinematic, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				Rigidbody component = assetGameObject.gameObject.GetComponent<Rigidbody>();
				if (component != null)
				{
					component.isKinematic = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_box_collider_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_box_collider_size) && WraperUtil.ValidIsNumber(L, 2, string_set_box_collider_size) && WraperUtil.ValidIsNumber(L, 3, string_set_box_collider_size) && WraperUtil.ValidIsNumber(L, 4, string_set_box_collider_size))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_box_collider_size, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.collider != null && assetGameObject.collider is BoxCollider)
				{
					BoxCollider boxCollider = (BoxCollider)assetGameObject.collider;
					boxCollider.size = new Vector3(num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_box_collider_size(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_box_collider_size))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_box_collider_size, AssetGameObject.cache);
				if (assetGameObject.collider != null && assetGameObject.collider is BoxCollider)
				{
					BoxCollider boxCollider = (BoxCollider)assetGameObject.collider;
					LuaDLL.lua_pushnumber(L, boxCollider.size.x);
					LuaDLL.lua_pushnumber(L, boxCollider.size.y);
					LuaDLL.lua_pushnumber(L, boxCollider.size.z);
				}
				else
				{
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
					LuaDLL.lua_pushnumber(L, 0.0);
				}
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_capsule_collider_radius(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_capsule_collider_radius) && WraperUtil.ValidIsNumber(L, 2, string_set_capsule_collider_radius))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_capsule_collider_radius, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				if (assetGameObject.collider != null && assetGameObject.collider is CapsuleCollider)
				{
					CapsuleCollider capsuleCollider = (CapsuleCollider)assetGameObject.collider;
					capsuleCollider.radius = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_capsule_collider_radius(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_capsule_collider_radius))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_capsule_collider_radius, AssetGameObject.cache);
				if (assetGameObject.collider != null && assetGameObject.collider is CapsuleCollider)
				{
					CapsuleCollider capsuleCollider = (CapsuleCollider)assetGameObject.collider;
					LuaDLL.lua_pushnumber(L, capsuleCollider.radius);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_capsule_collider_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_capsule_collider_height) && WraperUtil.ValidIsNumber(L, 2, string_set_capsule_collider_height))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_capsule_collider_height, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				if (assetGameObject.collider != null && assetGameObject.collider is CapsuleCollider)
				{
					CapsuleCollider capsuleCollider = (CapsuleCollider)assetGameObject.collider;
					capsuleCollider.height = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_capsule_collider_height(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_capsule_collider_height))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_capsule_collider_height, AssetGameObject.cache);
				if (assetGameObject.collider != null && assetGameObject.collider is CapsuleCollider)
				{
					CapsuleCollider capsuleCollider = (CapsuleCollider)assetGameObject.collider;
					LuaDLL.lua_pushnumber(L, capsuleCollider.height);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_move) && WraperUtil.ValidIsNumber(L, 2, string_move) && WraperUtil.ValidIsNumber(L, 3, string_move) && WraperUtil.ValidIsNumber(L, 4, string_move))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_move, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.characterController != null)
				{
					LuaDLL.lua_pushnumber(L, (double)assetGameObject.characterController.Move(new Vector3(num, num2, num3)));
				}
				else
				{
					LuaDLL.lua_pushnumber(L, 0.0);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int simple_move(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_simple_move) && WraperUtil.ValidIsNumber(L, 2, string_simple_move) && WraperUtil.ValidIsNumber(L, 3, string_simple_move) && WraperUtil.ValidIsNumber(L, 4, string_simple_move))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_simple_move, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.characterController != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.characterController.SimpleMove(new Vector3(num, num2, num3)));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_charactor_controller_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_charactor_controller_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_charactor_controller_enable))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_charactor_controller_enable, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.characterController != null)
				{
					assetGameObject.characterController.enabled = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_an_collider(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_an_collider) && WraperUtil.ValidIsUserdata(L, 2, string_set_an_collider))
			{
				AssetGameObject assetGameObject = null;
				AncontrollerWraper ancontrollerWraper = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_collider_enable, AssetGameObject.cache);
				ancontrollerWraper = WraperUtil.LuaToUserdata(L, 2, string_set_collider_enable, AncontrollerWraper.cache);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.runtimeAnimatorController = ancontrollerWraper.component;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_collider_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_collider_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_collider_enable))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_collider_enable, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				bool flag2 = false;
				if (LuaDLL.lua_isboolean(L, 3))
				{
					flag2 = LuaDLL.lua_toboolean(L, 3);
				}
				if (!flag2)
				{
					Collider component = assetGameObject.gameObject.GetComponent<Collider>();
					if (component != null)
					{
						component.enabled = flag;
					}
				}
				else
				{
					Collider[] componentsInChildren = assetGameObject.gameObject.GetComponentsInChildren<Collider>();
					Collider[] array = componentsInChildren;
					foreach (Collider collider in array)
					{
						collider.enabled = flag;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_animator_enable))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_enable, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.enabled = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_root_motion(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_root_motion) && WraperUtil.ValidIsBoolean(L, 2, string_set_root_motion))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_root_motion, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.applyRootMotion = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_root_motion(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_root_motion))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_root_motion, AssetGameObject.cache);
				if (assetGameObject.animator != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.animator.applyRootMotion);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animator_cross_fade(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animator_cross_fade) && WraperUtil.ValidIsString(L, 2, string_animator_cross_fade) && WraperUtil.ValidIsNumber(L, 3, string_animator_cross_fade) && WraperUtil.ValidIsNumber(L, 4, string_animator_cross_fade) && WraperUtil.ValidIsNumber(L, 5, string_animator_cross_fade))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				int num2 = 0;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animator_cross_fade, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				num2 = (int)LuaDLL.lua_tonumber(L, 4);
				num3 = (float)LuaDLL.lua_tonumber(L, 5);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.CrossFade(text, num, num2, num3);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animator_play(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animator_play) && WraperUtil.ValidIsString(L, 2, string_animator_play))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animator_play, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.Play(text, 0, 0f);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animator_has_state(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animator_has_state) && WraperUtil.ValidIsString(L, 2, string_animator_has_state))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animator_play, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animator != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.animator.HasState(0, Animator.StringToHash(text)));
					result = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animator_play_use_hash_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animator_play_use_hash_name) && WraperUtil.ValidIsNumber(L, 2, string_animator_play_use_hash_name) && WraperUtil.ValidIsNumber(L, 3, string_animator_play_use_hash_name) && WraperUtil.ValidIsNumber(L, 4, string_animator_play_use_hash_name))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animator_play, AssetGameObject.cache);
				int stateNameHash = LuaDLL.lua_tointeger(L, 2);
				int layer = LuaDLL.lua_tointeger(L, 3);
				float normalizedTime = (float)LuaDLL.lua_tonumber(L, 4);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.Play(stateNameHash, layer, normalizedTime);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_animator_state(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_animator_state) && WraperUtil.ValidIsNumber(L, 2, string_get_animator_state))
			{
				AssetGameObject assetGameObject = null;
				int num = 0;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_animator_state, AssetGameObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (assetGameObject.animator != null)
				{
					AnimatorStateInfo currentAnimatorStateInfo = assetGameObject.animator.GetCurrentAnimatorStateInfo(num);
					WraperUtil.Push(L, currentAnimatorStateInfo);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_speed) && WraperUtil.ValidIsString(L, 2, string_set_animator_speed) && WraperUtil.ValidIsNumber(L, 3, string_set_animator_speed))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_speed, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.speed = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_animator_name(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_is_animator_name) && WraperUtil.ValidIsNumber(L, 2, string_is_animator_name) && WraperUtil.ValidIsString(L, 3, string_is_animator_name))
			{
				AssetGameObject assetGameObject = null;
				int num = 0;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_is_animator_name, AssetGameObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				text = LuaDLL.lua_tostring(L, 3);
				if (assetGameObject.animator != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.animator.GetCurrentAnimatorStateInfo(num).IsName(text));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_bool(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_bool) && WraperUtil.ValidIsString(L, 2, string_set_animator_bool) && WraperUtil.ValidIsBoolean(L, 3, string_set_animator_bool))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_bool, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				flag = LuaDLL.lua_toboolean(L, 3);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.SetBool(text, flag);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_animator_bool(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_animator_bool) && WraperUtil.ValidIsString(L, 2, string_get_animator_bool))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_animator_bool, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animator != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.animator.GetBool(text));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_integer(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_integer) && WraperUtil.ValidIsString(L, 2, string_set_animator_integer) && WraperUtil.ValidIsNumber(L, 3, string_set_animator_integer))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				int num = 0;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_integer, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (int)LuaDLL.lua_tonumber(L, 3);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.SetInteger(text, num);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_animator_integer(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_animator_integer) && WraperUtil.ValidIsString(L, 2, string_get_animator_integer))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_animator_integer, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animator != null)
				{
					LuaDLL.lua_pushnumber(L, assetGameObject.animator.GetInteger(text));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_float(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_float) && WraperUtil.ValidIsString(L, 2, string_set_animator_float) && WraperUtil.ValidIsNumber(L, 3, string_set_animator_float))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_float, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.SetFloat(text, num);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_animator_float(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_animator_float) && WraperUtil.ValidIsString(L, 2, string_get_animator_float))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_animator_float, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animator != null)
				{
					LuaDLL.lua_pushnumber(L, assetGameObject.animator.GetFloat(text));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_int_trigger(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_int_trigger) && WraperUtil.ValidIsNumber(L, 2, string_set_animator_int_trigger))
			{
				AssetGameObject assetGameObject = null;
				int num = 0;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_int_trigger, AssetGameObject.cache);
				num = (int)LuaDLL.lua_tonumber(L, 2);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.SetTrigger(num);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_string_trigger(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_string_trigger) && WraperUtil.ValidIsString(L, 2, string_set_animator_string_trigger))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_string_trigger, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animator != null)
				{
					assetGameObject.animator.SetTrigger(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animated_play(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animated_play) && WraperUtil.ValidIsString(L, 2, string_animated_play))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animated_play, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animation != null)
				{
					assetGameObject.animation.Play(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animated_cross_fade(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animated_cross_fade) && WraperUtil.ValidIsString(L, 2, string_animated_cross_fade))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animated_cross_fade, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animation != null)
				{
					assetGameObject.animation.CrossFade(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animated_stop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animated_stop) && WraperUtil.ValidIsString(L, 2, string_animated_stop))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animated_stop, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animation != null)
				{
					assetGameObject.animation.Stop(text);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int animated_is_playing(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_animated_is_playing) && WraperUtil.ValidIsString(L, 2, string_animated_is_playing))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_animated_is_playing, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.animation != null)
				{
					if (text != null)
					{
						LuaDLL.lua_pushboolean(L, assetGameObject.animation.IsPlaying(text));
					}
					else
					{
						LuaDLL.lua_pushboolean(L, assetGameObject.animation.isPlaying);
					}
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animated_speed(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animated_speed) && WraperUtil.ValidIsString(L, 2, string_set_animated_speed) && WraperUtil.ValidIsNumber(L, 3, string_set_animated_speed))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animated_speed, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				if (assetGameObject.animation != null)
				{
					assetGameObject.animation[text].speed = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animated_loop(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animated_loop) && WraperUtil.ValidIsString(L, 2, string_set_animated_loop) && WraperUtil.ValidIsBoolean(L, 3, string_set_animated_loop))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animated_loop, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				flag = LuaDLL.lua_toboolean(L, 3);
				if (assetGameObject.animation != null)
				{
					if (flag)
					{
						assetGameObject.animation[text].wrapMode = WrapMode.Loop;
					}
					else
					{
						assetGameObject.animation[text].wrapMode = WrapMode.Default;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animated_time(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animated_time) && WraperUtil.ValidIsString(L, 2, string_set_animated_time) && WraperUtil.ValidIsNumber(L, 3, string_set_animated_time))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				float num = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animated_time, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				num = (float)LuaDLL.lua_tonumber(L, 3);
				if (assetGameObject.animation != null)
				{
					assetGameObject.animation[text].time = num;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animated_enabled(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animated_enabled) && WraperUtil.ValidIsBoolean(L, 2, string_set_animated_enabled))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animated_enabled, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.animation != null)
				{
					assetGameObject.animation.enabled = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_is_trigger(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_is_trigger) && WraperUtil.ValidIsBoolean(L, 2, string_set_is_trigger))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_is_trigger, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.collider != null)
				{
					assetGameObject.collider.isTrigger = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_intersects(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_is_intersects) && WraperUtil.ValidIsUserdata(L, 2, string_is_intersects))
			{
				AssetGameObject assetGameObject = null;
				AssetGameObject assetGameObject2 = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_is_intersects, AssetGameObject.cache);
				assetGameObject2 = WraperUtil.LuaToUserdata(L, 2, string_is_intersects, AssetGameObject.cache);
				Collider component = assetGameObject.gameObject.GetComponent<Collider>();
				Collider component2 = assetGameObject2.gameObject.GetComponent<Collider>();
				if (component != null && component2 != null)
				{
					LuaDLL.lua_pushboolean(L, component.bounds.Intersects(component2.bounds));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_contains(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_is_contains) && WraperUtil.ValidIsNumber(L, 2, string_is_contains) && WraperUtil.ValidIsNumber(L, 3, string_is_contains) && WraperUtil.ValidIsNumber(L, 4, string_is_contains))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_is_contains, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Collider component = assetGameObject.gameObject.GetComponent<Collider>();
				if (component != null)
				{
					LuaDLL.lua_pushboolean(L, component.bounds.Contains(new Vector3(num, num2, num3)));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_component_camera_follow(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_component_camera_follow))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_add_component_camera_follow, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					CameraFollow com = assetGameObject.gameObject.AddComponent<CameraFollow>();
					WraperUtil.PushObject(L, CameraFollowWrap.CreateInstance(com));
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int is_grounded(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_is_grounded))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_is_grounded, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					LuaDLL.lua_pushboolean(L, assetGameObject.characterController.isGrounded);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_audio_listener_target(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_audio_listener_target))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_audio_listener_target, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioController.GetInstance().SetListenerTarget(assetGameObject.gameObject);
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_click(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_click) && WraperUtil.ValidIsString(L, 2, string_set_on_click))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_click, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					MouseHandler mouseHandler = assetGameObject.gameObject.GetComponent<MouseHandler>();
					if (mouseHandler == null)
					{
						mouseHandler = assetGameObject.gameObject.AddComponent<MouseHandler>();
					}
					mouseHandler.onClick = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_trigger_enter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_trigger_enter) && WraperUtil.ValidIsString(L, 2, string_set_on_trigger_enter))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_trigger_enter, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					TriggerHandler triggerHandler = assetGameObject.gameObject.GetComponent<TriggerHandler>();
					if (triggerHandler == null)
					{
						triggerHandler = assetGameObject.gameObject.AddComponent<TriggerHandler>();
					}
					triggerHandler.onTriggerEnter = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_trigger_stay(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_trigger_stay) && WraperUtil.ValidIsString(L, 2, string_set_on_trigger_stay))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_trigger_stay, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					TriggerHandler triggerHandler = assetGameObject.gameObject.GetComponent<TriggerHandler>();
					if (triggerHandler == null)
					{
						triggerHandler = assetGameObject.gameObject.AddComponent<TriggerHandler>();
					}
					triggerHandler.onTriggerStay = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_trigger_exit(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_trigger_exit) && WraperUtil.ValidIsString(L, 2, string_set_on_trigger_exit))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_trigger_exit, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					TriggerHandler triggerHandler = assetGameObject.gameObject.GetComponent<TriggerHandler>();
					if (triggerHandler == null)
					{
						triggerHandler = assetGameObject.gameObject.AddComponent<TriggerHandler>();
					}
					triggerHandler.onTriggerExit = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_start(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_start) && WraperUtil.ValidIsString(L, 2, string_set_on_start))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_start, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					MonoHandler monoHandler = assetGameObject.gameObject.GetComponent<MonoHandler>();
					if (monoHandler == null)
					{
						monoHandler = assetGameObject.gameObject.AddComponent<MonoHandler>();
					}
					monoHandler.onStart = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_awake(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_awake) && WraperUtil.ValidIsString(L, 2, string_set_on_awake))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_awake, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					MonoHandler monoHandler = assetGameObject.gameObject.GetComponent<MonoHandler>();
					if (monoHandler == null)
					{
						monoHandler = assetGameObject.gameObject.AddComponent<MonoHandler>();
					}
					monoHandler.onAwake = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_update(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_update) && WraperUtil.ValidIsString(L, 2, string_set_on_update))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_update, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					MonoHandler monoHandler = assetGameObject.gameObject.GetComponent<MonoHandler>();
					if (monoHandler == null)
					{
						monoHandler = assetGameObject.gameObject.AddComponent<MonoHandler>();
					}
					monoHandler.onUpdate = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_late_update(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_late_update) && WraperUtil.ValidIsString(L, 2, string_set_on_late_update))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_late_update, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					MonoHandler monoHandler = assetGameObject.gameObject.GetComponent<MonoHandler>();
					if (monoHandler == null)
					{
						monoHandler = assetGameObject.gameObject.AddComponent<MonoHandler>();
					}
					monoHandler.onLateUpdate = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_on_destory(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_on_destory) && WraperUtil.ValidIsString(L, 2, string_set_on_destory))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_on_destory, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					MonoHandler monoHandler = assetGameObject.gameObject.GetComponent<MonoHandler>();
					if (monoHandler == null)
					{
						monoHandler = assetGameObject.gameObject.AddComponent<MonoHandler>();
					}
					monoHandler.onDestory = text;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_flash_lighting(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_flash_lighting))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_flash_lighting, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					FlashLighting flashLighting = assetGameObject.gameObject.GetComponent<FlashLighting>();
					if (flashLighting == null)
					{
						flashLighting = assetGameObject.gameObject.AddComponent<FlashLighting>();
					}
					WraperUtil.PushObject(L, FlashLightingWrap.CreateInstance(flashLighting));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_line_render(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_line_render))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_line_render, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					LineRenderer lineRenderer = assetGameObject.gameObject.GetComponent<LineRenderer>();
					if (lineRenderer == null)
					{
						lineRenderer = assetGameObject.gameObject.AddComponent<LineRenderer>();
					}
					WraperUtil.PushObject(L, LineRenderWrap.CreateInstance(lineRenderer));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_navmesh_agent(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_navmesh_agent))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_navmesh_agent, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					NavMeshAgent component = assetGameObject.gameObject.GetComponent<NavMeshAgent>();
					if (component == null)
					{
						LuaDLL.lua_pushnil(L);
						result = 1;
						goto IL_007b;
					}
					WraperUtil.PushObject(L, NavMeshAgentWrap.CreateInstance(component));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			goto IL_007b;
			IL_007b:
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_navmesh_obstacle(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_navmesh_obstacle))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_navmesh_obstacle, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					NavMeshObstacle component = assetGameObject.gameObject.GetComponent<NavMeshObstacle>();
					if (component == null)
					{
						LuaDLL.lua_pushnil(L);
						result = 1;
						goto IL_007b;
					}
					WraperUtil.PushObject(L, NavMeshObstacleWrap.CreateInstance(component));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			goto IL_007b;
			IL_007b:
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_camera_path_animator(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_camera_path_animator))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_camera_path_animator, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					CameraPathAnimator cameraPathAnimator = assetGameObject.gameObject.GetComponent<CameraPathAnimator>();
					if (cameraPathAnimator == null)
					{
						cameraPathAnimator = assetGameObject.gameObject.AddComponent<CameraPathAnimator>();
					}
					WraperUtil.PushObject(L, CameraPathAnimatorWrap.CreateInstance(cameraPathAnimator));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_camera_shake(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_camera_shake))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_camera_path_animator, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					CameraShake cameraShake = assetGameObject.gameObject.GetComponent<CameraShake>();
					if (cameraShake == null)
					{
						cameraShake = assetGameObject.gameObject.AddComponent<CameraShake>();
					}
					WraperUtil.PushObject(L, CameraShakeWrap.CreateInstance(cameraShake));
					result = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_audio_source(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_audio_source))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_audio_source, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioSource audioSource = assetGameObject.gameObject.GetComponent<AudioSource>();
					if (audioSource == null)
					{
						audioSource = assetGameObject.gameObject.AddComponent<AudioSource>();
					}
					WraperUtil.PushObject(L, AudioSourceWrap.CreateInstance(audioSource));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_audio_echo_filter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_audio_echo_filter))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_audio_echo_filter, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioEchoFilter audioEchoFilter = assetGameObject.gameObject.GetComponent<AudioEchoFilter>();
					if (audioEchoFilter == null)
					{
						audioEchoFilter = assetGameObject.gameObject.AddComponent<AudioEchoFilter>();
						audioEchoFilter.enabled = false;
					}
					WraperUtil.PushObject(L, AudioEchoFilterWrap.CreateInstance(audioEchoFilter));
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int opt_replay_effect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_opt_replay_effect))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_opt_replay_effect, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					if (null == assetGameObject.effectHelper)
					{
						assetGameObject.SetupEffectHelper();
					}
					if (null != assetGameObject.effectHelper)
					{
						assetGameObject.effectHelper.Replay();
						LuaDLL.lua_pushboolean(L, true);
					}
				}
				LuaDLL.lua_pushboolean(L, false);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int opt_stop_effect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_opt_stop_effect))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_opt_stop_effect, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					if (null == assetGameObject.effectHelper)
					{
						assetGameObject.SetupEffectHelper();
					}
					if (null != assetGameObject.effectHelper)
					{
						assetGameObject.effectHelper.Stop();
						LuaDLL.lua_pushboolean(L, true);
					}
				}
				LuaDLL.lua_pushboolean(L, false);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int disable_lightprobe_effect(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_disable_lightprobe_effect))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_disable_lightprobe_effect, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					if (null == assetGameObject.effectHelper)
					{
						assetGameObject.SetupEffectHelper();
					}
					if (null != assetGameObject.effectHelper)
					{
						assetGameObject.effectHelper.DisableLightProbe();
						LuaDLL.lua_pushboolean(L, true);
					}
				}
				LuaDLL.lua_pushboolean(L, false);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_float_property(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_float_property) && WraperUtil.ValidIsString(L, 2, string_set_material_float_property) && WraperUtil.ValidIsNumber(L, 3, string_set_material_float_property))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_float_property, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					string text = LuaDLL.lua_tostring(L, 2);
					float value = (float)LuaDLL.lua_tonumber(L, 3);
					if (null == assetGameObject.effectHelper)
					{
						assetGameObject.SetupEffectHelper();
					}
					if (null != assetGameObject.effectHelper)
					{
						assetGameObject.effectHelper.SetMaterialFloatProperty(text, value);
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_material_color_property(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_material_color_property) && WraperUtil.ValidIsString(L, 2, string_set_material_color_property) && WraperUtil.ValidIsNumber(L, 3, string_set_material_color_property) && WraperUtil.ValidIsNumber(L, 4, string_set_material_color_property) && WraperUtil.ValidIsNumber(L, 5, string_set_material_color_property) && WraperUtil.ValidIsNumber(L, 6, string_set_material_color_property))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_material_color_property, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					string text = LuaDLL.lua_tostring(L, 2);
					Vector4 value = new Vector4((float)LuaDLL.lua_tonumber(L, 3), (float)LuaDLL.lua_tonumber(L, 4), (float)LuaDLL.lua_tonumber(L, 5), (float)LuaDLL.lua_tonumber(L, 6));
					if (null == assetGameObject.effectHelper)
					{
						assetGameObject.SetupEffectHelper();
					}
					if (null != assetGameObject.effectHelper)
					{
						assetGameObject.effectHelper.SetMaterialColorProperty(text, value);
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int opt_effect_set_culling_mode(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_opt_effect_set_culling_mode) && WraperUtil.ValidIsNumber(L, 2, string_opt_effect_set_culling_mode))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_opt_effect_set_culling_mode, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					if (null == assetGameObject.effectHelper)
					{
						assetGameObject.SetupEffectHelper();
					}
					if (null != assetGameObject.effectHelper)
					{
						int animatorCullingMode = (int)LuaDLL.lua_tonumber(L, 2);
						assetGameObject.effectHelper.SetAnimatorCullingMode(animatorCullingMode);
						LuaDLL.lua_pushboolean(L, true);
					}
				}
				LuaDLL.lua_pushboolean(L, false);
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int opt_effect_reset_quality(IntPtr L)
		{
			int num = 0;
			AssetGameObject assetGameObject = null;
			assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_opt_effect_reset_quality, AssetGameObject.cache);
			if (assetGameObject.gameObject != null)
			{
				if (null == assetGameObject.effectHelper)
				{
					assetGameObject.SetupEffectHelper();
				}
				if (null != assetGameObject.effectHelper)
				{
					assetGameObject.effectHelper.ResetEffectQuality();
				}
			}
			LuaDLL.lua_pushboolean(L, false);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int opt_set_effect_play_speed(IntPtr L)
		{
			int num = 0;
			AssetGameObject assetGameObject = null;
			assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_opt_set_effect_play_speed, AssetGameObject.cache);
			if (assetGameObject.gameObject != null)
			{
				if (null == assetGameObject.effectHelper)
				{
					assetGameObject.SetupEffectHelper();
				}
				if (null != assetGameObject.effectHelper)
				{
					float playSpeed = (float)LuaDLL.lua_tonumber(L, 2);
					assetGameObject.effectHelper.SetPlaySpeed(playSpeed);
				}
			}
			LuaDLL.lua_pushboolean(L, false);
			return 1;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_audio_source_by_clip(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_audio_source_by_clip) && WraperUtil.ValidIsString(L, 2, string_get_component_audio_source_by_clip))
			{
				AssetGameObject assetGameObject = null;
				string text = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_audio_source_by_clip, AssetGameObject.cache);
				text = LuaDLL.lua_tostring(L, 2);
				if (assetGameObject.gameObject != null)
				{
					AudioSource[] components = assetGameObject.gameObject.GetComponents<AudioSource>();
					if (components == null || components.Length == 0)
					{
						LuaDLL.lua_pushnil(L);
						goto IL_00d4;
					}
					for (int i = 0; i < components.Length; i++)
					{
						if (components[i].clip.name == text)
						{
							WraperUtil.PushObject(L, AudioSourceWrap.CreateInstance(components[i]));
							break;
						}
					}
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				result = 1;
			}
			goto IL_00d4;
			IL_00d4:
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int create_fast_shadows(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_create_fast_shadows))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_create_fast_shadows, AssetGameObject.cache);
				FS_ShadowSimple component = assetGameObject.gameObject.GetComponent<FS_ShadowSimple>();
				if (component == null)
				{
					component = assetGameObject.gameObject.AddComponent<FS_ShadowSimple>();
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int change_model_property(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_change_model_property) && WraperUtil.ValidIsNumber(L, 2, string_change_model_property))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_change_model_property, AssetGameObject.cache);
				int type = (int)LuaDLL.lua_tonumber(L, 2);
				ChangeModelProperty changeModelProperty = assetGameObject.gameObject.GetComponent<ChangeModelProperty>();
				if (changeModelProperty == null)
				{
					changeModelProperty = assetGameObject.gameObject.AddComponent<ChangeModelProperty>();
				}
				changeModelProperty.SetType((SceneChangeModelProperty.PropertyType)type);
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_hud_text(IntPtr L)
		{
			int result = 0;
			AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_add_hud_text, AssetGameObject.cache);
			if (assetGameObject != null && (bool)assetGameObject.gameObject && WraperUtil.ValidIsUserdata(L, 1, string_add_hud_text) && WraperUtil.ValidIsNumber(L, 2, string_add_hud_text) && WraperUtil.ValidIsUserdata(L, 3, string_add_hud_text) && WraperUtil.ValidIsUserdata(L, 4, string_add_hud_text) && WraperUtil.ValidIsUserdata(L, 5, string_add_hud_text))
			{
				int num = (int)LuaDLL.lua_tonumber(L, 2);
				AssetGameObject assetGameObject2 = WraperUtil.LuaToUserdata(L, 3, string_add_hud_text, AssetGameObject.cache);
				AssetGameObject assetGameObject3 = WraperUtil.LuaToUserdata(L, 4, string_add_hud_text, AssetGameObject.cache);
				AssetGameObject assetGameObject4 = WraperUtil.LuaToUserdata(L, 5, string_add_hud_text, AssetGameObject.cache);
				HUDText hUDText = assetGameObject.gameObject.GetComponent<HUDText>();
				if (hUDText == null)
				{
					hUDText = assetGameObject.gameObject.AddComponent<HUDText>();
				}
				UIFollowTarget uIFollowTarget = assetGameObject.gameObject.GetComponent<UIFollowTarget>();
				if (uIFollowTarget == null)
				{
					uIFollowTarget = assetGameObject.gameObject.AddComponent<UIFollowTarget>();
				}
				if (assetGameObject2 != null && !(assetGameObject2.transform == null) && assetGameObject3 != null && !(assetGameObject3.transform == null) && assetGameObject4 != null && !(assetGameObject4.transform == null))
				{
					uIFollowTarget.target = assetGameObject2.transform;
					uIFollowTarget.gameCamera = assetGameObject3.gameObject.GetComponent<Camera>();
					uIFollowTarget.uiCamera = assetGameObject4.gameObject.GetComponent<Camera>();
					Vector3 vector = uIFollowTarget.gameCamera.WorldToViewportPoint(uIFollowTarget.target.position);
					int num2 = (((uIFollowTarget.gameCamera.orthographic || vector.z > 0f) && vector.x > 0f && vector.x < 1f && vector.y > 0f && vector.y < 1f) ? 1 : 0);
					if (num2 == 1)
					{
						hUDText.Add(c: (num <= 0) ? Color.red : Color.green, obj: num, stayDuration: 0f);
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_animator_culling_mode(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_animator_culling_mode) && WraperUtil.ValidIsNumber(L, 2, string_set_animator_culling_mode))
			{
				int cullingMode = (int)LuaDLL.lua_tonumber(L, 2);
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_animator_culling_mode, AssetGameObject.cache);
				if (assetGameObject != null && (bool)assetGameObject.gameObject)
				{
					assetGameObject.animator.cullingMode = (AnimatorCullingMode)cullingMode;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_childs(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_childs))
			{
				AssetGameObject assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_childs, AssetGameObject.cache);
				if (assetGameObject != null)
				{
					Transform transform = assetGameObject.transform;
					int childCount = transform.childCount;
					AssetGameObject[] array = new AssetGameObject[childCount];
					for (int i = 0; i < childCount; i++)
					{
						array[i] = AssetGameObject.CreateByInstance(transform.GetChild(i).gameObject);
					}
					WraperUtil.PushObjects(L, array);
					result = 1;
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int inverse_transform_point(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_inverse_transform_point) && WraperUtil.ValidIsNumber(L, 2, string_inverse_transform_point) && WraperUtil.ValidIsNumber(L, 3, string_inverse_transform_point) && WraperUtil.ValidIsNumber(L, 4, string_inverse_transform_point))
			{
				AssetGameObject assetGameObject = null;
				float num = 0f;
				float num2 = 0f;
				float num3 = 0f;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_inverse_transform_point, AssetGameObject.cache);
				num = (float)LuaDLL.lua_tonumber(L, 2);
				num2 = (float)LuaDLL.lua_tonumber(L, 3);
				num3 = (float)LuaDLL.lua_tonumber(L, 4);
				Vector3 vector = Vector3.zero;
				if (assetGameObject.transform != null)
				{
					vector = assetGameObject.transform.InverseTransformPoint(num, num2, num3);
				}
				LuaDLL.lua_pushnumber(L, vector.x);
				LuaDLL.lua_pushnumber(L, vector.y);
				LuaDLL.lua_pushnumber(L, vector.z);
				result = 3;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_button_script_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_button_script_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_button_script_enable))
			{
				AssetGameObject assetGameObject = null;
				bool flag = false;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_button_script_enable, AssetGameObject.cache);
				flag = LuaDLL.lua_toboolean(L, 2);
				UIButton component = assetGameObject.gameObject.GetComponent<UIButton>();
				if (component != null)
				{
					component.enabled = flag;
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_component_audio_high_pass_filter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_component_audio_high_pass_filter))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_add_component_audio_high_pass_filter, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioHighPassFilter com = assetGameObject.gameObject.AddComponent<AudioHighPassFilter>();
					WraperUtil.PushObject(L, AudioHighPassFilterWrap.CreateInstance(com));
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int add_component_audio_low_pass_filter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_add_component_audio_low_pass_filter))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_add_component_audio_low_pass_filter, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioLowPassFilter com = assetGameObject.gameObject.AddComponent<AudioLowPassFilter>();
					WraperUtil.PushObject(L, AudioLowPassFilterWrap.CreateInstance(com));
				}
				result = 1;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_audio_high_pass_filter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_audio_high_pass_filter))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_audio_high_pass_filter, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioHighPassFilter component = assetGameObject.gameObject.GetComponent<AudioHighPassFilter>();
					if (component != null)
					{
						WraperUtil.PushObject(L, AudioHighPassFilterWrap.CreateInstance(component));
						result = 1;
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int get_component_audio_low_pass_filter(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_get_component_audio_low_pass_filter))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_get_component_audio_low_pass_filter, AssetGameObject.cache);
				if (assetGameObject.gameObject != null)
				{
					AudioLowPassFilter component = assetGameObject.gameObject.GetComponent<AudioLowPassFilter>();
					if (component != null)
					{
						WraperUtil.PushObject(L, AudioLowPassFilterWrap.CreateInstance(component));
						result = 1;
					}
				}
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_audio_high_pass_filter_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_audio_high_pass_filter_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_audio_high_pass_filter_enable))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_audio_high_pass_filter_enable, AssetGameObject.cache);
				bool enabled = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.gameObject != null)
				{
					AudioHighPassFilter component = assetGameObject.gameObject.GetComponent<AudioHighPassFilter>();
					if (component != null)
					{
						component.enabled = enabled;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int set_audio_low_pass_filter_enable(IntPtr L)
		{
			int result = 0;
			if (WraperUtil.ValidIsUserdata(L, 1, string_set_audio_low_pass_filter_enable) && WraperUtil.ValidIsBoolean(L, 2, string_set_audio_low_pass_filter_enable))
			{
				AssetGameObject assetGameObject = null;
				assetGameObject = WraperUtil.LuaToUserdata(L, 1, string_set_audio_low_pass_filter_enable, AssetGameObject.cache);
				bool enabled = LuaDLL.lua_toboolean(L, 2);
				if (assetGameObject.gameObject != null)
				{
					AudioLowPassFilter component = assetGameObject.gameObject.GetComponent<AudioLowPassFilter>();
					if (component != null)
					{
						component.enabled = enabled;
					}
				}
				result = 0;
			}
			return result;
		}

		[MonoPInvokeCallback(typeof(LuaCSFunction))]
		private static int gc(IntPtr L)
		{
			AssetGameObject assetGameObject = WraperUtil.LuaToUserdataByGc(L, 1, "gc asset_game_object_object", AssetGameObject.cache);
			if (assetGameObject != null)
			{
				assetGameObject.DelRef();
			}
			return 0;
		}
	}
}
