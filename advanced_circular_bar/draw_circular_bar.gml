/**
 *	Returns a new instance of Circular_bar.
 *	@returns {Struct.Circular_bar}
 *	@param {Real} x The x position.
 *	@param {Real} y The y position.
 *	@param {Real} radius The bar's radius.
 *	@param {Real} [width] The bar's width.
 *	@param {Real} [start_angle] The bar's angle at 0%.
 *	@param {Real} [end_angle] The bar's angle at 100%.
 *	@param {Array<Constant.Color>} [colors] The colors from 0% to 100% of the value.
 *	@param {Real} [value] The value represented by the bar (0 <= x <= 1).
 *	@param {Real} [precision] The number of sectors used to draw the bar. IMPACTS ON PERFORMANCE.
 *	@param {Real} [edge_type_start] The edge drawn at the bar's 0% angle.
 *	@param {Real} [edge_type_final] The edge drawn at the bar's val% angle.
 *	@param {Array<Struct>} [divisors] The triangles that cut the bar (use circular_bar_auto_set_divisors()).
 *	@param {Array<Real>} [edges] The shapes drawn at the divisors' edges in order.
 *	@param {Bool} [activation_override] Freezes the bar's body.
*/

function circular_bar_create(x, y, radius, width = radius, start_angle = 90, end_angle = 450, colors = [c_black, c_white], transparency = 1, value = 1, precision = CIRCULAR_BAR_QUALITY.MEDIUM, edge_type_start = 0, edge_type_final = 0, divisors = [], edges = [0], activation_override = true)
{
	return new Circular_bar(x, y, radius, width, start_angle, end_angle, colors, transparency, value, precision, edge_type_start, edge_type_final, divisors, edges, activation_override);
}



/**
 *	Returns a new instance of Circular_bar.
 *	@returns {Struct.Circular_bar}
 *	@param {Real} x The x position.
 *	@param {Real} y The y position.
 *	@param {Real} radius The bar's radius.
 *	@param {Real} [width] The bar's width.
 *	@param {Real} [center_angle] The bar's angle at 50%.
 *	@param {Real} [amplitude] The bar's total amplitude.
 *	@param {Array<Constant.Color>} [colors] The colors from 0% to 100% of the value.
 *	@param {Real} [value] The value represented by the bar (0 <= x <= 1).
 *	@param {Real} [precision] The number of sectors used to draw the bar. IMPACTS ON PERFORMANCE.
 *	@param {Real} [edge_type_start] The edge drawn at the bar's 0% angle.
 *	@param {Real} [edge_type_final] The edge drawn at the bar's val% angle.
 *	@param {Array<Struct>} [divisors] The triangles that cut the bar (use circular_bar_auto_set_divisors()).
 *	@param {Array<Real>} [edges] The shapes drawn at the divisors' edges in order.
 *	@param {Bool} [activation_override] Freezes the bar's body.
*/

function circular_bar_create_amplitude(x, y, radius, width = radius, center_angle = 270, amplitude = 360, colors = [c_black, c_white], transparency = 1, value = 1, precision = CIRCULAR_BAR_QUALITY.MEDIUM, edge_type_start = 0, edge_type_final = 0, divisors = [], edges = [0], activation_override = true)
{
	var half_amplitude = amplitude / 2;
	return new Circular_bar(x, y, radius, width, center_angle - half_amplitude, center_angle + half_amplitude, colors, transparency, value, precision, edge_type_start, edge_type_final, divisors, edges, activation_override);
}



/**
 *	Draws a specific circular bar.
 *	@param {Struct.Circular_bar} bar The bar to draw.
 *	@param {Real} [x] Override x position to draw the bar.
 *	@param {Real} [y] Override y position to draw the bar.
 *	@param {Bool} [refresh_mask] Updates the bar's mask.
*/

function draw_circular_bar(bar, x = bar.x, y = bar.y, refresh_mask = false)
{
	bar.__draw(x, y, refresh_mask);
}



/**
 *	Returns a new instance of Circular_bar with the copied data.
 *	@return {Struct.Circular_bar}
 *	@param {Struct.Circular_bar} bar The bar to copy.
 *	@param {Real} [precision] The number of segments of the new bar.
*/

function circular_bar_copy(bar, precision = bar.precision)
{
	return bar.__copy(precision);
}



/**
 *	Refreshes the bar's surfaces.
 *	@param {Struct.Circular_bar} bar The bar to update.
 *	@param {Bool} [refresh_mask] Defines whether the bar mask has to be updated as well.
 *	@param {Bool} [keep_active] Defines whether the bar's body should be frozen.
*/

function circular_bar_update(bar, refresh_mask = false, keep_active = true)
{
	bar.__update(refresh_mask, keep_active);
}



/**
 *	Unfreezes a circular bar's body.
 *	@param {Struct.Circular_bar} bar The bar to activate.
*/

function circular_bar_activate(bar)
{
	bar.active = true;
}



/**
 *	Freezes a circular bar's body. Recommended for performance when working with multiple bars.
 *	@param {Struct.Circular_bar} bar The bar to deactivate.
*/

function circular_bar_deactivate(bar)
{
	bar.active = false;
}



/**
 *	Returns the number of sectors currently drawn by the bar to represent its value.
 *	@returns {Real}
 *	@param {Struct.Circular_bar} bar The bar to get the sector from.
 *	@param {Real} [value] The value to retrieve the number of sectors drawn.
*/

function circular_bar_get_sector(bar, value = bar.value)
{
	return bar.__get_sector(value);
}



/**
 *	Sets the colors of a circular bar.
 *	@param {Struct.Circular_bar} bar The bar to edit.
 *	@param {Constant.Color} color_start The color of the bar at 0% of its value.
 *	@param {Constant.Color} color_end The color of the bar at 100% of its value.
*/

function circular_bar_set_colors(bar, color_start, color_end)
{
	bar.__set_colors(color_start, color_end);
}



/**
 *	Creates a bar's divisor.
 *	@param {Real} position The absolute angle of the divisor's bisector.
 *	@param {Real} amplitude The amplitude of the divisor.
*/

function circular_bar_create_divisor(position, amplitude)
{
	return Circular_bar.__create_divisor(position, amplitude);
}



/**
 *	Adds divisors to a bar.
 *	@param {Struct.Circular_bar} bar The bar to edit.
 *	@param {Array<Struct>} divisors The divisors to add.
*/

function circular_bar_add_divisors(bar, divisors)
{
	for (var i = 0; i < array_length(divisors); i++)
	{
		bar.__add_divisor(divisors[@ i]);
	}
}



/**
 *	Automatically adds centered divisors to the bar's arc.
 *	@param {Struct.Circular_bar} bar The bar to edit.
 *	@param {Real} divisor_count The number of divisors to set.
 *	@param {Real} divisor_amplitudes The angles of the divisors (following progression).
 *	@param {Real} divisor_edges The edges to apply to the divisors (following progression).
*/

function circular_bar_auto_set_divisors(bar, divisor_count, divisor_amplitudes, divisor_edges)
{
	bar.__auto_generate_divisors(divisor_count, divisor_amplitudes, divisor_edges);
}



/**
 *	Adapts a bar to the shape of its target.
 *	@param {Struct.Circular_bar} border_bar The bar to adapt as border.
 *	@param {Struct.Circular_bar} target_bar The bar to adapt the border to.
 *	@param {Real} border_width The width of the border.
*/

function circular_bar_make_border(border_bar, target_bar, border_width)
{
	border_bar.__make_border_of(target_bar, border_width);
}



//---------------------------------------------------------------------------



#region Source code
enum CIRCULAR_BAR_EDGE_POSITIONS
{
	TOP = 0,
	CENTER = 1,
	BOTTOM = 2
}

enum CIRCULAR_BAR_QUALITY
{
	LOW = 18,
	MEDIUM = 36,
	HIGH = 54,
	ULTRA = 72,
	PLUS_ULTRA = 90
}



/**
 *	@param {Real} x
 *	@param {Real} y
 *	@param {Real} radius
 *	@param {Real} width
 *	@param {Real} start_angle
 *	@param {Real} end_angle
 *	@param {Array<Constant.Color>} colors
 *	@param {Real} transparency
 *	@param {Real} value
 *	@param {Real} precision
 *	@param {Real} edge_type_start
 *	@param {Real} edge_type_final
 *	@param {Array<Struct>} divisors
 *	@param {Array<Real>} edges
 *	@param {Bool} activation_override
*/

function Circular_bar(x, y, radius, width, start_angle, end_angle, colors, transparency, value, precision, edge_type_start, edge_type_final, divisors, edges, activation_override) constructor
{
	#region Constructor
	self.x = x;
	self.y = y;
	self.value = value;
	self.precision = precision;
	self.colors = colors;
	self.color = merge_color(colors[@ 0], colors[@ 1], value);
	self.transparency = transparency;
	self.start_angle = start_angle;
	self.end_angle = end_angle;
	self.radius = radius;
	self.width = width;
	self.active = activation_override;
	self.edge_type_start = edge_type_start;
	self.edge_type_final = edge_type_final;
	self.divisors = divisors;
	self.edges = edges;
	self.rotation = 0;
	self.surface = -1;
	self.redraw = true;
	self.mask = -1;
	#endregion

	#region Base functions
	static edge_requires_change =
	[
		true,		// NONE
		false,	// ROUND
		true,		// CHEVRON
		false,	// RECTANGLE
		true,		// BUBBLY - TOP
		true,		// BUBBLY - CENTER
		true,		// BUBBLY - BOTTOM
		true,		// DART - TOP
		true,		// DART - CENTER
		true,		// DART - BOTTOM
		true,		// DIAMOND - TOP
		true,		// DIAMOND - CENTER
		true,		// DIAMOND - BOTTOM
		true,		// TRIANGLE - TOP
		true,		// TRIANGLE - CENTER
		true,		// TRIANGLE - BOTTOM
		false,	// TRAPEZOID - TOP
		false,	// TRAPEZOID - CENTER
		false,	// TRAPEZOID - BOTTOM
		true,		// ROUNDED DIAMOND - TOP
		true,		// ROUNDED DIAMOND - CENTER
		true		// ROUNDED DIAMOND - BOTTOM
	];



	/**
	 *	@returns {Struct.Circular_bar}
	 *	@param {Real} [precision_override]
	*/

	static __copy = function(precision_override = self.precision)
	{
		var bar_copy = json_parse(json_stringify(self));
		static_set(bar_copy, static_get(Circular_bar));
		bar_copy.precision = precision_override;
		return bar_copy;
	}



	/**
	 *	@param {Bool} [refresh_mask]
	 *	@param {Bool} [active]
	*/

	static __update = function(refresh_mask = false, active = self.active)
	{
		redraw = active;
		if (refresh_mask && surface_exists(mask)) {surface_free(mask);}
	}



	/**
	 *	@param {Real} [value]
	*/

	static __get_sector = function(value = self.value)
	{
		return ceil(value * precision);
	}



	/**
	 *	@param {Constant.Color} color_start
	 *	@param {Constant.Color} color_end
	*/

	static __set_colors = function(color_start, color_end)
	{
		colors = [color_start, color_end];
		color = merge_color(color_start, color_end, value);
	}



	/**
	 *	@param {Struct.Circular_bar} bar
	 *	@param {Real} border_width
	*/

	static __make_border_of = function(bar, border_width)
	{
		radius = bar.radius + border_width;
		width = bar.width + border_width + min(border_width * (bar.width < bar.radius), bar.radius - bar.width);

		var border_angle = radtodeg(arctan(border_width / (radius + 2 * border_width)));
		var _start_angle = bar.start_angle, _end_angle = bar.end_angle, angle_diff = _end_angle - _start_angle;
		var is_not_explementary = (angle_diff % 360 != 0);
		var dir = sign(angle_diff);
		start_angle = _start_angle - dir * border_angle * edge_requires_change[@ edge_type_start] * is_not_explementary;
		end_angle = _end_angle + dir * border_angle * edge_requires_change[@ edge_type_final] * is_not_explementary;

		divisors = json_parse(json_stringify(bar.divisors));
		var edge_placements = __get_placement_values();
		edges = bar.edges;

		// I hate this
		for (var i = 0; i < array_length(divisors); i++)
		{
			with (divisors[i])
			{
				var edge = 0;

				for (var j = 0; j < array_length(edge_angles); j++)
				{
					edge = other.edges[@ array_get_index(edge_placements, other.__angle_to_placement_percentage(edge_angles[@ j])) % array_length(other.edges)];
					edge_angles[@ j] += border_angle * sign(position - edge_angles[@ j]) * other.edge_requires_change[@ edge];
				}

				position = mean(edge_angles[@ 0], edge_angles[@ 1]);
				amplitude = abs(edge_angles[@ 0] - edge_angles[@ 1]);
			}
		}

		__update(true);
	}



	/**
	 *	@returns {Array<Real>}
	*/

	static __get_placement_values = function()
	{
		var placement_values = [];
		var _ = __angle_to_placement_percentage;

		for (var i = 0; i < array_length(divisors); i++)
		{
			array_push(placement_values, _(divisors[@ i].edge_angles[@ 0]), _(divisors[@ i].edge_angles[@ 1]));
		}

		array_sort(placement_values, true);
		return placement_values;
	}



	/**
	 *	@returns {Real}
	 *	@param {Real} angle
	*/

	static __angle_to_placement_percentage = function(angle)
	{
		return (angle - start_angle) / (end_angle - start_angle);
	}
	#endregion

	#region Main
	/**
	 *	@param {Real} [x]
	 *	@param {Real} [y]
	 *	@param {Bool} [refresh_mask]
	*/

	static __draw = function(x = self.x, y = self.y, refresh_mask = false)
	{
		if (__get_sector() < 1 || transparency <= 0) {exit;}

		var side = radius * 2 + 1;

		if (!surface_exists(surface))
		{
			surface = surface_create(side, side);
		}

		surface_set_target(surface);
		__update(refresh_mask);

		if (!redraw)
		{
			__finalise_surface(x, y);
			exit;
		}

		draw_clear_alpha(c_black, 0);

		if (!surface_exists(mask))
		{
			mask = surface_create(side, side);
			__draw_mask(side);
		}

		surface_reset_target();
		surface_set_target(surface);
		__draw_body();

		gpu_set_blendmode(bm_subtract);
		draw_surface(mask, 0, 0);
		gpu_set_blendmode(bm_normal);
		__finalise_surface(x, y);

		color = merge_color(colors[@ 0], colors[@ 1], value);
	}



	/**
	 *	@param {Real} side
	*/

	static __draw_mask = function(side)
	{
		var mask_precision = min(CIRCULAR_BAR_QUALITY.PLUS_ULTRA, precision);
		var temp_surface = surface_create(side, side);
		surface_reset_target();

		surface_set_target(temp_surface);
		__draw_body(mask_precision, 1);

		if (array_length(divisors) > 0)
		{
			__draw_divisors();
		}

		if (width < radius)
		{
			gpu_set_blendmode(bm_subtract);
			__draw_progression(mask_precision, 1, radius - width + 1);
		}

		gpu_set_blendmode(bm_normal);
		surface_reset_target();
		surface_set_target(mask);

		gpu_set_blendmode(bm_subtract);
		draw_clear(c_black);
		draw_surface(temp_surface, 0, 0);
		gpu_set_blendmode(bm_normal);
		surface_free(temp_surface);
	}



	/**
	 *	@param {Real} [precision_override]
	 *	@param {Real} [value_override]
	*/

	static __draw_body = function(precision_override = self.precision, value_override = self.value)
	{
		__draw_endpoints(__draw_progression(precision_override, value_override));
	}



	/**
	 *	@param {Real} [precision_override]
	 *	@param {Real} [value_override]
	 *	@param {Real} [radius]
	*/

	static __draw_progression = function(precision_override, value_override, radius = self.radius)
	{
		var sector_count = __get_sector(value_override), angle = start_angle;
		var center = self.radius;

		draw_primitive_begin(pr_trianglefan);
		draw_vertex(center, center);

		var angle_diff = end_angle - start_angle;
		var rotation_increment = sign(angle_diff);
		var sector_size = abs(angle_diff) / precision_override;
		var calibrated_start_angle = start_angle - 180;
		var _cos, _sin;

		for (var i = 0; abs(i) < sector_count; i += rotation_increment)
		{
			angle = sector_size * i + calibrated_start_angle;
			_cos = lengthdir_x(radius, angle);
			_sin = lengthdir_y(radius, angle);
			draw_vertex(center - _cos, center - _sin);
		}

		var variable_radius = __calculate_variable_radius(value_override, radius).variable_radius;
		angle = angle_diff * value_override + calibrated_start_angle;
		_cos = lengthdir_x(variable_radius, angle);
		_sin = lengthdir_y(variable_radius, angle);
		draw_vertex(center - _cos, center - _sin);
		draw_primitive_end();

		return angle;
	}



	/**
	 *	@param {Real} [value]
	 *	@param {Real} [radius]
	*/

	static __calculate_variable_radius = function(value = self.value, radius = self.radius)
	{
		// Too much trigonometry, Maximilian out.
		var sector_count = __get_sector(value) - (value < 1);
		var angle_diff = end_angle - start_angle;
		var rotation_increment = sign(angle_diff);
		var sector_amplitude = abs(angle_diff) / precision;
		var outer_angle = (180 - sector_amplitude) / 2;
		var calibrated_start_angle = start_angle - 180;
		var angle = angle_diff * value + start_angle;
		var anchored_angle = start_angle + sector_amplitude * rotation_increment * sector_count;
		var sector_angle_diff = abs(angle - anchored_angle) % sector_amplitude;
		var inner_angle = 180 - outer_angle - sector_angle_diff;
		var variable_radius = radius * dsin(outer_angle) / dsin(inner_angle);
		var snap_dir_angle = anchored_angle + sector_amplitude / 2 * sign(angle_diff);
		return {variable_radius, snap_dir_angle, sector_angle_diff};
	}



	/**
	 *	@param {Real} current_angle
	*/

	static __draw_endpoints = function(current_angle)
	{
		__draw_edges([edge_type_final, edge_type_start], [__angle_to_placement_percentage(current_angle + 180), 0]);
	}



	/**
	 *	@param {Real} x
	 *	@param {Real} y
	*/

	static __finalise_surface = function(x = self.x, y = self.y)
	{
		surface_reset_target();
		draw_surface_ext(surface, x - radius, y - radius, 1, 1, rotation, color, transparency);
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
	#endregion

	#region Divisors management
	/**
		@param {Struct} divisor
	*/

	static __add_divisor = function(divisor)
	{
		array_push(divisors, divisor);
	}



	/**
	 *	@param {Real} divisor_count
	 *	@param {Array<Real>} divisor_amplitudes
	 *	@param {Array<Real>} divisor_edges
	*/

	static __auto_generate_divisors = function(divisor_count, divisor_amplitudes, divisor_edges)
	{
		var angle_diff = end_angle - start_angle;
		var start_index = (angle_diff % 360 != 0);
		divisor_count += start_index;
		edges = divisor_edges;
		divisors = [];

		for (var i = start_index; i < divisor_count; i++)
		{
			var position = angle_diff * i / divisor_count + start_angle;
			var amplitude = divisor_amplitudes[@ (i - start_index) % array_length(divisor_amplitudes)];
			array_push(divisors, __create_divisor(position, amplitude));
		}

		__update(true);
	}



	/**
	 *	@param {Real} position
	 *	@param {Real} amplitude
	*/

	static __create_divisor = function(position, amplitude)
	{
		var half_amplitude = amplitude / 2;
		return {position, amplitude, edge_angles: [position - half_amplitude, position + half_amplitude]};
	}

	static __draw_divisors = function()
	{
		for (var i = 0; i < array_length(divisors); i++)
		{
			__draw_divisor(divisors[@ i]);
		}

		gpu_set_blendmode_ext_sepalpha(bm_one, bm_one, bm_src_alpha, bm_dest_alpha);
		__draw_edges();
	}



	/**
	 *	@param {Struct} divisor
	*/

	static __draw_divisor = function(divisor)
	{
		var variation = (divisor.amplitude >= 180) * 90;
		var angles = divisor.edge_angles;
		var position = divisor.position;
		var len = radius * 1.5;
		var center = radius;

		var t1x1 = center + lengthdir_x(len, angles[@ 0]);
		var t1y1 = center + lengthdir_y(len, angles[@ 0]);
		var t2x1 = center + lengthdir_x(len, angles[@ 1]);
		var t2y1 = center + lengthdir_y(len, angles[@ 1]);

		var tmx3 = center + lengthdir_x(len, position);
		var tmy3 = center + lengthdir_y(len, position);
		var tmx1 = center + lengthdir_x(len, position - variation);
		var tmy1 = center + lengthdir_y(len, position - variation);
		var tmx2 = center + lengthdir_x(len, position + variation);
		var tmy2 = center + lengthdir_y(len, position + variation);

		gpu_set_blendmode(bm_subtract);
		draw_primitive_begin(pr_trianglefan);
		draw_vertex(center, center);
		draw_vertex(t1x1, t1y1);
		draw_vertex(tmx1, tmy1);
		draw_vertex(tmx3, tmy3);
		draw_vertex(tmx2, tmy2);
		draw_vertex(t2x1, t2y1);
		draw_primitive_end();
	}



	/**
	 *	@param {Array<Real>} [edges_to_draw]
	 *	@param {Array<Real>} [placement_values]
	*/

	static __draw_edges = function(edges_to_draw = edges, placement_values = __get_placement_values())
	{
		var angle_diff = end_angle - start_angle;
		var dir = sign(angle_diff) * 90;
		var direction_values = [dir, -dir];

		for (var i = 0; i < array_length(placement_values); i++)
		{
			var edge = edges_to_draw[@ i % array_length(edges_to_draw)];
			var placement_angle = placement_values[@ i] * angle_diff + start_angle;
			var edge_direction = direction_values[@ i % array_length(direction_values)];
			__draw_edge(edge, placement_angle, __calculate_variable_radius(placement_values[@ i]), edge_direction);
		}
	}



	/**
	 *	@param {Real} edge
	 *	@param {Real} placement
	 *	@param {Struct} variable_coordinates
	 *	@param {Real} dir
	 *	@param {Real} [ext]
	*/

	static __draw_edge = function(edge, placement, variable_coordinates, dir, ext = 1)
	{
		var angle = variable_coordinates.snap_dir_angle;
		var radius = variable_coordinates.variable_radius;
		var angle_diff = variable_coordinates.sector_angle_diff;
		var h_sector_size = abs(end_angle - start_angle) / precision / 2;
		var width = self.width * radius / self.radius;
		var center = self.radius - 1;
		dir += angle;

		var edge_selector =
		[
			function(center, radius, width, angle) {__round_edge(center, radius, width, angle)},
			function(center, radius, width, angle, dir, ext) {__chevron_edge(center, radius, width, angle, dir, ext)},
			function(center, radius, width, angle, dir, ext) {__rectangle_edge(center, radius, width, angle, dir, ext)},
			function(center, radius, width, angle) {__bubbly_edge(center, radius, width, angle, CIRCULAR_BAR_EDGE_POSITIONS.TOP)},
			function(center, radius, width, angle) {__bubbly_edge(center, radius, width, angle, CIRCULAR_BAR_EDGE_POSITIONS.CENTER)},
			function(center, radius, width, angle) {__bubbly_edge(center, radius, width, angle, CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM)},
			function(center, radius, width, angle, dir, ext) {__dart_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.TOP)},
			function(center, radius, width, angle, dir, ext) {__dart_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.CENTER)},
			function(center, radius, width, angle, dir, ext) {__dart_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM)},
			function(center, radius, width, angle, dir, ext) {__diamond_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.TOP)},
			function(center, radius, width, angle, dir, ext) {__diamond_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.CENTER)},
			function(center, radius, width, angle, dir, ext) {__diamond_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM)},
			function(center, radius, width, angle, dir, ext) {__triangle_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.TOP)},
			function(center, radius, width, angle, dir, ext) {__triangle_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.CENTER)},
			function(center, radius, width, angle, dir, ext) {__triangle_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM)},
			function(center, radius, width, angle, dir, ext) {__trapezoid_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.TOP)},
			function(center, radius, width, angle, dir, ext) {__trapezoid_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.CENTER)},
			function(center, radius, width, angle, dir, ext) {__trapezoid_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM)},
			function(center, radius, width, angle, dir, ext) {__rounded_diamond_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.TOP)},
			function(center, radius, width, angle, dir, ext) {__rounded_diamond_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.CENTER)},
			function(center, radius, width, angle, dir, ext) {__rounded_diamond_edge(center, radius, width, angle, dir, ext, CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM)}
		];

		if (edge < 1 || edge > array_length(edge_selector)) {return;}
		edge_selector[@ edge - 1](center, radius, width, placement, dir, ext);
	}
	#endregion

	#region Edges
	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
	*/

	static __round_edge = function(center, radius, width, angle)
	{
		var hw = width / 2, mid_point = radius - hw;
		var cx = center + lengthdir_x(mid_point, angle);
		var cy = center + lengthdir_y(mid_point, angle);

		draw_circle(cx, cy, hw, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
		@param {Real} position
	*/

	static __triangle_edge = function(center, radius, width, angle, dir, ext, position)
	{
		var in = radius - width, hw = width / 2, ew = ext * hw;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);
		var mpx = mean(p1x, p2x);
		var mpy = mean(p1y, p2y);

		var _x = 0, _y = 1;
		var positions = [[p2x, mpx, p1x], [p2y, mpy, p1y]];
		var p3x = lengthdir_x(ew, dir) + positions[@ _x][@ position];
		var p3y = lengthdir_y(ew, dir) + positions[@ _y][@ position];

		draw_triangle(p1x, p1y, p2x, p2y, p3x, p3y, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
		@param {Real} position
	*/

	static __trapezoid_edge = function(center, radius, width, angle, dir, ext, position)
	{
		var in = radius - width, ew = ext * width / 2;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);

		var xlen = p2x - p1x;
		var ylen = p2y - p1y;
		var m1x = p1x + xlen / 4;
		var m1y = p1y + ylen / 4;
		var m2x = p2x - xlen / 4;
		var m2y = p2y - ylen / 4;
		var p3x = m1x, p3y = m1y;
		var p4x = m2x, p4y = m2y;

		switch (position)
		{
			default:
			break;

			case CIRCULAR_BAR_EDGE_POSITIONS.TOP:
				m1x = p2x - xlen / 2;
				m1y = p2y - ylen / 2;
				m2x = p2x - xlen / 4;
				m2y = p2y - ylen / 4;
				p3x = p1x + lengthdir_x(ew, dir);
				p3y = p1y + lengthdir_y(ew, dir);
				p4x = m2x + lengthdir_x(ew, dir);
				p4y = m2y + lengthdir_y(ew, dir);
			break;

			case CIRCULAR_BAR_EDGE_POSITIONS.CENTER:
				p3x = m1x + lengthdir_x(ew, dir);
				p3y = m1y + lengthdir_y(ew, dir);
				p4x = m2x + lengthdir_x(ew, dir);
				p4y = m2y + lengthdir_y(ew, dir);
			break;

			case CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM:
				m1x = p1x + xlen / 2;
				m1y = p1y + ylen / 2;
				m2x = p1x + xlen / 4;
				m2y = p1y + ylen / 4;
				p3x = m2x + lengthdir_x(ew, dir);
				p3y = m2y + lengthdir_y(ew, dir);
				p4x = p2x + lengthdir_x(ew, dir);
				p4y = p2y + lengthdir_y(ew, dir);
			break;
		}

		draw_triangle(p1x, p1y, m1x, m1y, p3x, p3y, false);
		draw_triangle(m1x, m1y, p3x, p3y, p4x, p4y, false);
		draw_triangle(m2x, m2y, p4x, p4y, m1x, m1y, false);
		draw_triangle(p2x, p2y, m2x, m2y, p4x, p4y, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
	*/

	static __chevron_edge = function(center, radius, width, angle, dir, ext)
	{
		var in = radius - width, ew = ext * width / 2;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);
		var e1x = p1x + lengthdir_x(ew, dir);
		var e1y = p1y + lengthdir_y(ew, dir);
		var e2x = p2x + lengthdir_x(ew, dir);
		var e2y = p2y + lengthdir_y(ew, dir);
		var mpx = mean(p1x, p2x);
		var mpy = mean(p1y, p2y);
		var p3x = mpx + lengthdir_x(ew / 2, dir);
		var p3y = mpy + lengthdir_y(ew / 2, dir);

		draw_triangle(p1x, p1y, e1x, e1y, p3x, p3y, false);
		draw_triangle(p2x, p2y, e2x, e2y, p3x, p3y, false);
		draw_triangle(p1x, p1y, p2x, p2y, p3x, p3y, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} position
	*/

	static __bubbly_edge = function(center, radius, width, angle, position)
	{
		var in = radius - width, qw = width / 4;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);

		var xlen = p2x - p1x;
		var ylen = p2y - p1y;
		var mpx = mean(p1x, p2x);
		var mpy = mean(p1y, p2y);
		var m310x = p1x + xlen * 3 / 10;
		var m310y = p1y + ylen * 3 / 10;
		var m610x = p2x - xlen * 3 / 10;
		var m610y = p2y - ylen * 3 / 10;
		var m15x = p1x + xlen / 5;
		var m15y = p1y + ylen / 5;
		var m45x = p2x - xlen / 5;
		var m45y = p2y - ylen / 5;
		var m25x = p1x + xlen * 2 / 5;
		var m25y = p1y + ylen * 2 / 5;
		var m35x = p2x - xlen * 2 / 5;
		var m35y = p2y - ylen * 2 / 5;

		var _x = 0, _y = 1;
		var positions = [[[m610x, m25x, m15x], [m45x, mpx, m15x], [m45x, m35x, m310x]], [[m610y, m25y, m15y], [m45y, mpy, m15y], [m45y, m35y, m310y]]];
		var b1x = positions[@ _x][@ position][@ 0];
		var b1y = positions[@ _y][@ position][@ 0];
		var mbx = positions[@ _x][@ position][@ 1];
		var mby = positions[@ _y][@ position][@ 1];
		var b2x = positions[@ _x][@ position][@ 2];
		var b2y = positions[@ _y][@ position][@ 2];
		var radius_multipliers = [[.3, .24, .2], [.2, .3, .2], [.2, .24, .3]];
		var radiuses = [width * radius_multipliers[@ position][@ 0], width * radius_multipliers[@ position][@ 1], width * radius_multipliers[@ position][@ 2]];

		draw_circle(b1x, b1y, radiuses[0], false);
		draw_circle(mbx, mby, radiuses[1], false);
		draw_circle(b2x, b2y, radiuses[2], false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
	*/

	static __rectangle_edge = function(center, radius, width, angle, dir, ext)
	{
		var in = radius - width, ew = ext * width / 2;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);
		var p3x = p1x + lengthdir_x(ew, dir);
		var p3y = p1y + lengthdir_y(ew, dir);
		var p4x = p2x + lengthdir_x(ew, dir);
		var p4y = p2y + lengthdir_y(ew, dir);

		draw_triangle(p1x, p1y, p2x, p2y, p3x, p3y, false);
		draw_triangle(p2x, p2y, p3x, p3y, p4x, p4y, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
		@param {Real} position
	*/

	static __rounded_diamond_edge = function(center, radius, width, angle, dir, ext, position)
	{
		// As of now circles can't be stretched
		// If you come up with a solution to make circles (ellipses, basically) stretch
		// correctly in all angles please do contact me on Discord: maximilian.volt
		ext = 1;

		var in = radius - width, hw = width / 2, qw = hw / 2, qw3 = qw * 3, ew = ext * qw;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);

		var xlen = p2x - p1x;
		var ylen = p2y - p1y;
		var bx = mean(p1x, p2x);
		var by = mean(p1y, p2y);
		var v1x = bx, v1y = by;
		var v2x = bx, v2y = by;
		var _dir = sign(dir - angle) * 90;
		var base_dir = angle + _dir;
		var angle_diff = 0;

		switch (position)
		{
			default:
			break;

			case CIRCULAR_BAR_EDGE_POSITIONS.TOP:
				p2x -= xlen / 4;
				p2y -= ylen / 4;
				bx = p2x;
				by = p2y;

				angle_diff = darcsin(qw / qw3) * sign(_dir);
				v1x = bx + lengthdir_x(ew, base_dir + angle_diff);
				v1y = by + lengthdir_y(ew, base_dir + angle_diff);
				v2x = bx;
				v2y = by;
			break;

			case CIRCULAR_BAR_EDGE_POSITIONS.CENTER:
				angle_diff = darcsin(qw / hw) * sign(_dir);
				v1x = bx + lengthdir_x(ew, base_dir + angle_diff);
				v1y = by + lengthdir_y(ew, base_dir + angle_diff);
				v2x = bx + lengthdir_x(ew, base_dir - angle_diff);
				v2y = by + lengthdir_y(ew, base_dir - angle_diff);
			break;

			case CIRCULAR_BAR_EDGE_POSITIONS.BOTTOM:
				p1x += xlen / 4;
				p1y += ylen / 4;
				bx = p1x;
				by = p1y;

				angle_diff = darcsin(qw / qw3) * sign(_dir);
				v2x = bx + lengthdir_x(ew, base_dir - angle_diff);
				v2y = by + lengthdir_y(ew, base_dir - angle_diff);
				v1x = bx;
				v1y = by;
			break;
		}

		draw_triangle(p1x, p1y, bx, by, v1x, v1y, false);
		draw_triangle(p2x, p2y, bx, by, v2x, v2y, false);
		draw_circle(bx, by, qw, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
		@param {Real} position
	*/

	static __diamond_edge = function(center, radius, width, angle, dir, ext, position)
	{
		var in = radius - width, ew = ext * width / 4;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);

		var xlen = p2x - p1x;
		var ylen = p2y - p1y;
		var m14x = p1x + xlen / 4;
		var m14y = p1y + ylen / 4;
		var mbx = mean(p1x, p2x);
		var mby = mean(p1y, p2y);
		var m34x = p2x - xlen / 4;
		var m34y = p2y - ylen / 4;

		var _x = 0, _y = 1;
		var positions = [[m34x, mbx, m14x], [m34y, mby, m14y]];
		var vx = lengthdir_x(ew, dir) + positions[@ _x][@ position];
		var vy = lengthdir_y(ew, dir) + positions[@ _y][@ position];

		draw_triangle(p1x, p1y, p2x, p2y, vx, vy, false);
	}



	/**
		@param {Real} center
		@param {Real} radius
		@param {Real} width
		@param {Real} angle
		@param {Real} dir
		@param {Real} ext
		@param {Real} position
	*/

	static __dart_edge = function(center, radius, width, angle, dir, ext, position)
	{
		var in = radius - width, ew = ext * width / 4;
		var p1x = center + lengthdir_x(in, angle);
		var p1y = center + lengthdir_y(in, angle);
		var p2x = center + lengthdir_x(radius, angle);
		var p2y = center + lengthdir_y(radius, angle);

		var xlen = p2x - p1x;
		var ylen = p2y - p1y;
		var m316x = p1x + xlen * 3 / 16;
		var m316y = p1y + ylen * 3 / 16;
		var m616x = p1x + xlen * 3 / 8;
		var m616y = p1y + ylen * 3 / 8;
		var m1016x = p2x - xlen * 3 / 8;
		var m1016y = p2y - ylen * 3 / 8;
		var m1316x = p2x - xlen * 3 / 16;
		var m1316y = p2y - ylen * 3 / 16;

		var _x = 0, _y = 1;
		var positions1 = [[m1016x, m616x, m316x], [m1016y, m616y, m316y]];
		var positions2 = [[m1316x, m1016x, m616x], [m1316y, m1016y, m616y]];
		var b1x = positions1[@ _x][@ position];
		var b1y = positions1[@ _y][@ position];
		var b2x = positions2[@ _x][@ position];
		var b2y = positions2[@ _y][@ position];
		var v1x = b1x + lengthdir_x(ew, dir);
		var v1y = b1y + lengthdir_y(ew, dir);
		var v2x = b2x + lengthdir_x(ew, dir);
		var v2y = b2y + lengthdir_y(ew, dir);

		draw_triangle(p1x, p1y, v1x, v1y, b2x, b2y, false);
		draw_triangle(p2x, p2y, v2x, v2y, b1x, b1y, false);
	}
	#endregion Edges
}
#endregion Source code